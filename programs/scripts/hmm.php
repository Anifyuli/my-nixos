<?php

/**
 * h-m-m
 *
 * h-m-m (pronounced like the interjection "hmm") is a simple, fast,
 * keyboard-centric terminal-based tool for working with mind maps.
 *
 * @author  Nader K. Rad <me@nader.pm>
 * @link    https://github.com/nadrad/h-m-m
 * @license https://www.gnu.org/licenses/gpl-3.0.en.html GPLv3
 */


// {{{ settings and defaults

mb_internal_encoding("UTF-8");


// $mm, short for "mind map", is an array that contains the
// 'nodes' array, as well as the other settings and parameters
// required for building and showing a mind map.
//
// escape codes for colors:
// https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797

$mm=[];


// parsing the command line arguments

$mm['arguments'] = [];
$mm['config'] = [];
$mm['env'] = [];
$alen = count($argv);

for ( $i = 1 ; $i < $alen ; $i++ )
	if (substr($argv[$i],0,2) == '--')
	{
		$a = explode('=', substr($argv[$i],2));
		$mm['arguments'][ str_replace('-','_',$a[0]) ] = trim( $a[1] ?? true, '"' );
	}
	elseif (isset($mm['arguments']['filename']))
	{
		echo "Invalid arguments: more than one filename!".PHP_EOL;
		exit(1);
	}
	else
		$mm['arguments']['filename'] = $argv[$i];


// parsing the config file

$conf =
	$mm['arguments']['config']
	??
	(
		PHP_OS_FAMILY === 'Windows'
		? $argv[0].'.conf'
		:
		(
			PHP_OS_FAMILY === 'Darwin'
			? getenv('HOME').'/Library/Preferences/h-m-m/h-m-m.conf'
			: getenv('HOME').'/.config/h-m-m/h-m-m.conf'
		)
	)
;

if (file_exists($conf))
{
	$handle = fopen($conf, "r");
	if ($handle)
	{
		while (($line = fgets($handle)) !== false)
		{
			if (empty(trim($line))) continue;
			$c = explode('=',trim($line));
			$mm['config'][ str_replace('-','_',trim($c[0] ?? 'NA')) ] = trim($c[1] ?? 'NA');
		}
		fclose($handle);
	}
}
elseif (isset($mm['arguments']['config']))
	die("ERROR: the custom config file ($conf) doesn't exit!\n");


// parsing the environment variables

$mm['env']=[];
$e = getenv();
foreach ($e as $k=>$v)
	if (substr($k,0,4)=='hmm_')
		$mm['env'][str_replace('-','_',substr($k,4))] = $v ?? '';


// and now, the settings!
// arguments > environment variables > config file > default

config($mm, 'max_parent_node_width', 25);
config($mm, 'max_leaf_node_width',   55);
config($mm, 'line_spacing',          1);
config($mm, 'align_levels',          0);

config($mm, 'symbol1',               "✓");
config($mm, 'symbol2',               "✗");

config($mm, 'show_hidden',           0);

config($mm, 'initial_depth',         1);
config($mm, 'center_lock',           false);
config($mm, 'focus_lock',            false);

config($mm, 'max_undo_steps',        24);

config($mm, 'active_node_color',     "\033[38;5;0m\033[48;5;172m\033[1m");
config($mm, 'message_color',         "\033[38;5;0m\033[48;5;141m\033[1m");
config($mm, 'doubt_color',           "\033[38;5;168m");

config($mm, 'post_export_command',   "");

config($mm, 'clipboard',             "os");
config($mm, 'clipboard_file',        "/tmp/h-m-m");
config($mm, 'clipboard_in_command',  "");
config($mm, 'clipboard_out_command', "");

config($mm, 'auto_save',             false);
config($mm, 'echo_keys',             false);


if (isset($mm['arguments']['debug_config']))
{
	echo "1. the config arguments:\n";
	print_r($mm['arguments']);
	echo "2. the environment variables:\n";
	print_r($mm['env']);
	echo "3. the config file:\n";
	print_r($mm['config']);
	exit;
}


$clipboard                  = '';


$mm['show_logo']            = true;
$mm['changes']              = [];
$mm['change_active_node']   = [];
$mm['change_index']         = 0;

$mm['top_left_column']      = 0;
$mm['top_left_row']         = 0;

$mm['terminal_width']       = (int)exec('tput cols');
$mm['terminal_height']      = (int)exec('tput lines');

$mm['viewport_left']        = 0;
$mm['viewport_top']         = 0;

$mm['root_id']              = 2;

const min_indentation       = 2;
const width_tolerance       = 1.3;
const width_min             = 15;
const width_change_factor   = 1.2;
const max_width_padding     = 30;
const left_padding          = 1;

const conn_left_len         = 6;
const conn_right_len        = 4;

$mm['conn_right']           = str_repeat('─', conn_right_len - 2 );
$mm['conn_left']            = str_repeat('─', conn_left_len -2 );
$mm['conn_single']          = str_repeat('─', conn_left_len + conn_right_len - 3 );

const vertical_offset       = 4;

const BOM                   = "\xEF\xBB\xBF";
const default_color         = "\033[0m";
const clear_screen          = "\033[2J";

const special_keys =
[
	'ctrl_a' => "\001",
	'ctrl_b' => "\002",
	'ctrl_c' => "\003",
	'ctrl_d' => "\004",
	'ctrl_e' => "\005",
	'ctrl_f' => "\006",
	'ctrl_g' => "\007",
	'ctrl_back_space' => "\010",
	'ctrl_h' => "\010",
	'ctrl_i' => "\011",
	'ctrl_j' => "\012",
	'ctrl_k' => "\013",
	'ctrl_l' => "\014",
	'ctrl_m' => "\015",
	'ctrl_n' => "\016",
	'ctrl_o' => "\017",
	'ctrl_p' => "\020",
	'ctrl_q' => "\021",
	'ctrl_r' => "\022",
	'ctrl_s' => "\023",
	'ctrl_t' => "\024",
	'ctrl_u' => "\025",
	'ctrl_v' => "\026",
	'ctrl_w' => "\027",
	'ctrl_x' => "\030",
	'ctrl_y' => "\031",
	'ctrl_z' => "\032",

	'alt_a' => "\033\141",
	'alt_b' => "\033\142",
	'alt_c' => "\033\143",
	'alt_d' => "\033\144",
	'alt_e' => "\033\145",
	'alt_f' => "\033\146",
	'alt_g' => "\033\147",
	'alt_h' => "\033\150",
	'alt_i' => "\033\151",
	'alt_j' => "\033\152",
	'alt_k' => "\033\153",
	'alt_l' => "\033\154",
	'alt_m' => "\033\155",
	'alt_n' => "\033\156",
	'alt_o' => "\033\157",
	'alt_p' => "\033\160",
	'alt_q' => "\033\161",
	'alt_r' => "\033\162",
	'alt_s' => "\033\163",
	'alt_t' => "\033\164",
	'alt_u' => "\033\165",
	'alt_v' => "\033\166",
	'alt_w' => "\033\167",
	'alt_x' => "\033\170",
	'alt_y' => "\033\171",
	'alt_z' => "\033\172",

	'arr_down' => "\033\133\102",
	'arr_right'=> "\033\133\103",
	'arr_up'   => "\033\133\101",
	'arr_left' => "\033\133\104",

	'meta_arr_left' => "\033\033\133\104",
	'ctrl_arr_left'   => "\033\133\061\073\065\104",
	'shift_arr_left'  => "\033\133\061\073\062\104",

	'meta_arr_right'=> "\033\033\133\103",
	'ctrl_arr_right'  => "\033\133\061\073\065\103",
	'shift_arr_right' => "\033\133\061\073\062\103",

	'home' => "\033\133\110",
	'end'  => "\033\133\106",

	'home_alternative' => "\033\133\061\176",
	'end_alternative'  => "\033\133\064\176",

	'del' => "\033\133\063\176",
	'ctrl_del' => "\033\133\63\073\065\176",
	'back_space' => "\177",
	'meta_back_space' => "\033\177",

	'enter' => "\012",
	'space' => "\040",
	'tab'   => "\011",
	'esc'   => "\033",
	'equal' => "="

];

const reset_page            = "\033[2J\033[0;0f";
const reset_color           = "\033[0m";

const invert_on             = "\033[7m";
const invert_off            = "\033[27m";

const dim_on                = "\033[2m";
const dim_off               = "\033[22m";

const line_on               = "\033[0m\033[38;5;95m";
const line_off              = "\033[0m";

const collapsed_symbol_on   = "\033[38;5;215m";
const collapsed_symbol_off  = "\033[0m";

const insert_sibling        = 0;
const insert_child          = 1;

$keybindings = [];

$keybindings['a'] = 'edit_node_append';
$keybindings['A'] = 'edit_node_replace';

$keybindings['b'] = 'expand_all';

$keybindings['c'] = 'center_active_node';
$keybindings['C'] = 'toggle_center_lock';
$keybindings[special_keys['ctrl_c']] = 'quit';

$keybindings['d'] = 'delete_node';
$keybindings['D'] = 'delete_children';
$keybindings[special_keys['del']] = 'delete_node_without_clipboard';

$keybindings['e'] = 'edit_node_append';
$keybindings['E'] = 'edit_node_replace';

$keybindings['f'] = 'focus';
$keybindings['F'] = 'toggle_focus_lock';

$keybindings['g'] = 'go_to_top';
$keybindings['G'] = 'go_to_bottom';

$keybindings['h'] = 'go_left';
$keybindings['H'] = 'toggle_hide';
$keybindings[special_keys['ctrl_h']] = 'toggle_show_hidden';

$keybindings['i'] = 'edit_node_append';
$keybindings['I'] = 'edit_node_replace';

$keybindings['j'] = 'go_down';
$keybindings['J'] = 'move_node_down';

$keybindings['k'] = 'go_up';
$keybindings['K'] = 'move_node_up';

$keybindings['l'] = 'go_right';

$keybindings['m'] = 'go_to_root';
$keybindings['~'] = 'go_to_root';

$keybindings['n'] = 'next_search_result';
$keybindings['N'] = 'previous_search_result';

$keybindings['o'] = 'insert_new_sibling';
$keybindings['O'] = 'insert_new_child';
$keybindings[special_keys['ctrl_o']] = 'open_link';

$keybindings['p'] = 'paste_as_children';
$keybindings['P'] = 'paste_as_siblings';
$keybindings[special_keys['ctrl_p']] = 'append';

$keybindings['q'] = 'quit';
$keybindings['Q'] = 'shutdown';
$keybindings[special_keys['ctrl_q']] = 'quit_with_debug';

$keybindings['r'] = 'collapse_other_branches';
$keybindings['R'] = 'collapse_inner';

$keybindings['s'] = 'save';
$keybindings['S'] = 'save_as';

$keybindings['t'] = 'toggle_symbol';
$keybindings['T'] = 'sort_siblings';
$keybindings['#'] = 'toggle_numbers';

$keybindings['u'] = 'undo';

$keybindings['v'] = 'collapse_all';
$keybindings['V'] = 'collapse_children';

$keybindings['w'] = 'increase_text_width';
$keybindings['W'] = 'decrease_text_width';

$keybindings['x'] = 'export_html';
$keybindings['X'] = 'export_text';

$keybindings['y'] = 'yank_node';
$keybindings['Y'] = 'yank_children';

$keybindings['z'] = 'decrease_line_spacing';
$keybindings['Z'] = 'increase_line_spacing';

$keybindings["\n"] = 'insert_new_sibling';
$keybindings["\t"] = 'insert_new_child';
$keybindings[" "]  = 'toggle_node';

$keybindings[special_keys['arr_down']]  = 'go_down';
$keybindings[special_keys['arr_up']]    = 'go_up';
$keybindings[special_keys['arr_right']] = 'go_right';
$keybindings[special_keys['arr_left']]  = 'go_left';

$keybindings['1'] = 'collapse_level_1';
$keybindings['2'] = 'collapse_level_2';
$keybindings['3'] = 'collapse_level_3';
$keybindings['4'] = 'collapse_level_4';
$keybindings['5'] = 'collapse_level_5';
$keybindings['6'] = 'collapse_level_6';
$keybindings['7'] = 'collapse_level_7';
$keybindings['8'] = 'collapse_level_8';
$keybindings['9'] = 'collapse_level_9';

$keybindings['|'] = 'toggle_align';

$keybindings['?']    = 'help';
$keybindings['/']    = 'search';
$keybindings[special_keys['ctrl_f']] = 'search';

$keybindings['=']    = 'increase_positive_rank';
$keybindings['+']    = 'decrease_positive_rank';
$keybindings['-']    = 'increase_negative_rank';
$keybindings['_']    = 'decrease_negative_rank';

foreach ($mm['config'] as $key=>$value)
	if (substr($key,0,4) == 'bind')
	{
		$key = trim(substr($key,4));
		if (isset(special_keys[$key]))
			$key = special_keys[$key];
		if (!is_callable($value))
		{
			echo 'Config error! "'.$value.'" is an unknown command.'."\n";
			exit;
		}
		$keybindings[$key] = trim($value);
	}


function config(&$mm, $key, $default)
{
	$mm[$key] =
		str_replace
		(
			'\033'
			,"\033"
			,
			   $mm['arguments'][$key]
			?? $mm['env'][$key]
			?? $mm['config'][$key]
			?? $default
		);
}


// }}}
// {{{ checking the requirements

function check_required_extensions()
{
	if (!function_exists('mb_strlen'))
	{
		echo 'Required extension mbstring is not enabled; please check your php installation!'.PHP_EOL;
		exit(1);
	}
}


function check_the_available_clipboard_tool(&$mm)
{

	if ($mm['clipboard'] == 'file' && !file_exists($mm['clipboard_file']))
		file_put_contents($mm['clipboard_file'],'');

	if ($mm['clipboard'] != 'os')
		return;

	if (PHP_OS_FAMILY === "Windows")
	{
		$mm['os_clipboard']['write'] = "clip";
		$mm['os_clipboard']['read']  = 'powershell -sta "add-type -as System.Windows.Forms; [windows.forms.clipboard]::GetText()"';
		return;
	}

	if (PHP_OS_FAMILY === "Darwin")
	{
		$mm['os_clipboard']['write'] = "pbcopy";
		$mm['os_clipboard']['read']  = 'pbpaste';
		return;
	}


	// now, the main OS ;)

	exec('command -v xclip xsel wl-copy klipper', $result);
	$tool = basename($result[0] ?? '');

	if (trim($tool)==='')
	{
		echo "Can't find your clipboard tool! I expected to find xclip, xsel, wl-clipboard, or Klipper.".PHP_EOL;
		exit(1);
	}

	switch ($tool)
	{
		case 'xclip':
			$mm['os_clipboard']['write'] = 'xclip -selection clipboard';
			$mm['os_clipboard']['read']  = 'xclip -out -selection clipboard';
			break;

		case 'xsel':
			$mm['os_clipboard']['write'] = 'xsel --clipboard';
			$mm['os_clipboard']['read']  = 'xsel --clipboard';
			break;

		case 'wl-copy':
			$mm['os_clipboard']['write'] = 'wl-copy';
			$mm['os_clipboard']['read']  = 'wl-paste';
			break;

		case 'klipper':
			$mm['clipboard'] = 'command';
			$mm['clipboard_in_command']  = 'qdbus org.kde.klipper /klipper setClipboardContents %text%';
			$mm['clipboard_out_command'] = 'qdbus org.kde.klipper /klipper getClipboardContents';
			break;

		default:
			echo "I can't find your clipboard tool!".PHP_EOL;
			exit(1);
	}

}


// }}}
// {{{ alternative screen buffer

function enable_alternate_screen()
{
	// https://www.ibm.com/docs/en/aix/7.1?topic=s-stty-command
	system('stty cbreak -echo -crterase intr undef');

	echo 
		 "\033[?1049h" // enabling the alternate screen buffer
		."\033[?25l" // disabling the text cursor
		."\033[?9;1000;1001;1002;1003;1004;1007;1005;1006;1015;1016l" // disabling the mouse
		.clear_screen
	;
}


function shutdown()
{
	echo 
		clear_screen
		."\033[?1049l" // enabling the default screen buffer
		."\033[?25h" // enabling the text cursor
	;
	system("stty sane");
	change_window_title('');
	exit;
}


// }}}
// {{{ list to map converter

function list_to_map($lines, $root_id, $start_id)
{
	// calculating the indentation shift and cleaning up the special characters

	$indentation_shift = 9999999;

	foreach ($lines as $lid=>$line)
	{
		$lines[$lid] =
			mb_ereg_replace
			(
				"^( *)•"
				,'\1*'
				,
				mb_ereg_replace
				(
					"[\000-\010\013-\037\177]|".BOM
					,''
					,str_replace
					(
						 [ "\t", "\n" ]
						,[ "  ", " "  ]
						,$lines[$lid]
					)
				)
			)
		;

		$indentation = mb_strlen($lines[$lid]) - mb_strlen(ltrim($lines[$lid]));
		$start = mb_substr($lines[$lid], $indentation, 2);

		if ($start=='* ' || $start=='- ')
		{
			$lines[$lid][$indentation] = ' ';
			$indentation += 2;
		}

		if (trim($lines[$lid])!='')
			$indentation_shift =
				min
				(
					 $indentation_shift
					,$indentation
				)
			;
	}


	// building the tree

	$nodes = [];
	$id = $start_id;

	$previous_level = 1;
	$level = 1;
	$previous_indentation = 0;

	$level_parent[1]      = $root_id;
	$level_indentation[1] = 0;

	foreach ($lines as $line)
		if (trim($line)!='')
		{
			// warming up for this round!
			$indentation = mb_strlen($line) - mb_strlen(ltrim($line)) - $indentation_shift;

			// going one level down
			if ($indentation > $previous_indentation )
			{
				$level = $previous_level + 1;
				$level_indentation[$level] = $indentation;
			}

			// going one or more levels up
			if ($indentation < $previous_indentation )
				foreach ($level_indentation as $plevel=>$pindentation)
					if ($pindentation == $indentation)
						$level = $plevel;

			// saving the latest level_parent
			if ($level > $previous_level)
				$level_parent[$level] = $id-1;

			// done! saving the data

			$nodes[$id] =
			[
				 'title'   => trim($line)
				,'parent'  => $level_parent[$level]
			];

			// getting ready for the next round!
			$previous_indentation = $indentation;
			$previous_level = $level;
			$id++;
		}


	// setting a few properties that simplify future calculations

	foreach ($nodes as $id=>$node)
	{
		$nodes[$id]['collapsed'] = false;
		$nodes[$id]['is_leaf']   = true;
		$nodes[$id]['children']  = [];
	}

	foreach ($nodes as $id=>$node)
		if (isset($nodes[ $node['parent'] ]))
		{
			$nodes[ $node['parent'] ]['is_leaf']    = false;
			$nodes[ $node['parent'] ]['children'][] = $id;
		}

	return($nodes);
}


// }}}
// {{{ map to list converter

function map_to_list(&$mm, $id, $exclude_parent = false, $base = 0)
{
	if (!$exclude_parent)
		$output = str_repeat("\t",$base).$mm['nodes'][$id]['title'].PHP_EOL;
	else
		$output = '';

	foreach ($mm['nodes'][$id]['children'] as $cid)
		$output .= map_to_list($mm, $cid, false, $base+1-$exclude_parent);

	return $output;
}


// }}}
// {{{ load file

function load_file(&$mm)
{
	$mm['filename'] = $mm['arguments']['filename'] ?? '';

	if (isset($mm['arguments']['filename']) && file_exists($mm['filename']))
		$lines = file($mm['filename'], FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
	else
	{
		load_empty_map($mm);
		return;
	}


	// starting from 2 instead of 1, in case the files doesn't have
	// a single root and we have to inject one. leaving "1" empty
	// won't cause any problems.
	$new_nodes = list_to_map($lines, 0, 2);

	if (empty($new_nodes))
	{
		load_empty_map($mm);
		return;
	}

	change_window_title($mm['filename']);


	// checking to see how many first-level nodes we have
	$first_level_nodes = [];
	foreach ($new_nodes as $id=>$node)
		if ($id!=0 && $node['parent']==0)
			$first_level_nodes[] = $id;

	$mm['nodes'][0]['parent']   = -1;
	$mm['nodes'][0]['title']    = 'X';
	$mm['nodes'][0]['is_leaf']  = false;

	if (count($first_level_nodes)>1)
	{
		$mm['root_id'] = 1;

		$mm['nodes'][1]['parent']   = 0;
		$mm['nodes'][1]['title']    = 'root';
		$mm['nodes'][1]['is_leaf']  = false;
		$mm['nodes'][1]['children'] = $first_level_nodes;
		$mm['nodes'][0]['children'] = [1];

		foreach ($new_nodes as $id=>$node)
			if ($node['parent']==0)
				$new_nodes[$id]['parent'] = 1;
	}
	else
		$mm['nodes'][0]['children'] = $first_level_nodes;

	$mm['nodes'] = $mm['nodes'] + $new_nodes;

	if (isset($mm['nodes'][1]))
		$mm['active_node']=1;
	else
		$mm['active_node']=2;
}


// }}}
// {{{ list visible children

function list_visible_children(&$mm, $id)
{
	$mm['nodes'][$id]['visible_children'] = [];
	foreach ($mm['nodes'][$id]['children'] as $cid)
		if (substr($mm['nodes'][$cid]['title'],0,9) != '[HIDDEN] ')
			$mm['nodes'][$id]['visible_children'][] = $cid;

	foreach ($mm['nodes'][$id]['children'] as $cid)
		list_visible_children($mm, $cid);
}


// }}}
// {{{ calculate w, x, lh, and clh

function calculate_x_and_lh(&$mm, $id)
{
	$node = $mm['nodes'][$id];


	$mm['nodes'][$id]['x'] =
		$mm['nodes'][ $node['parent'] ]['x']
		+ $mm['nodes'][ $node['parent'] ]['w']
		+ conn_left_len
		+ conn_right_len
		+ 1
		+
		(
			$node['parent']==0
			? 1 - conn_right_len - conn_left_len
			: 0
		)
	;

	$at_the_end =
		$node['is_leaf']
		|| ($node['collapsed'] ?? false)
		|| count($node['visible_children']) == 0
	;

	$max_width =
		$at_the_end
		? $mm['max_leaf_node_width']
		: $mm['max_parent_node_width']
	;

	if ( mb_strlen($node['title']) > width_tolerance * $max_width )
	{
		$lines = explode(PHP_EOL ,wordwrap($node['title'] ,$max_width, PHP_EOL));

		$mm['nodes'][$id]['w'] = 0;
		$mm['nodes'][$id]['wl'] = 0;
		foreach ($lines as $line)
		{
			$mm['nodes'][$id]['w']  = max($mm['nodes'][$id]['w'],  mb_strwidth(trim($line)));
			$mm['nodes'][$id]['wl'] = max($mm['nodes'][$id]['wl'], mb_strlen(trim($line)));
		}

		$mm['nodes'][$id]['lh'] = count($lines);
	}
	else
	{
		$mm['nodes'][$id]['w']  = mb_strwidth(trim($node['title']));
		$mm['nodes'][$id]['wl'] = mb_strlen(trim($node['title']));
		$mm['nodes'][$id]['lh'] = 1;
	}

	$mm['map_width'] =
		max
		(
			  $mm['map_width']
			, $mm['nodes'][$id]['x']
			+ $mm['nodes'][$id]['w']
		)
	;

	$mm['nodes'][$id]['clh'] = 0;
	if ($at_the_end)
		$mm['nodes'][$id]['clh'] = $mm['nodes'][$id]['lh'];

	foreach ($node['visible_children'] as $cid)
	{
		calculate_x_and_lh($mm, $cid);
		$mm['nodes'][$id]['clh'] += $mm['nodes'][$cid]['clh'];
	}

}


// }}}
// {{{ calculate aligned x

function calculate_aligned_x(&$mm,$id,$x)
{
	$mm['map_width'] =
		max
		(
			  $mm['map_width']
			, $mm['nodes'][$id]['x']
			+ $mm['nodes'][$id]['w']
		)
	;

	$max_width = 0;
	foreach ($mm['nodes'][$id]['visible_children'] as $cid)
	{
		$max_width = max( $max_width, $mm['nodes'][$cid]['w'] );
		$mm['nodes'][$cid]['x'] = $x;
	}

	foreach ($mm['nodes'][$id]['visible_children'] as $cid)
		calculate_aligned_x
		(
			$mm
			,$cid
			,$max_width
			+$x
			+conn_left_len
			+conn_right_len
			+1
		)
	;
}



// }}}
// {{{ calculate h

function calculate_h(&$mm)
{
	$unfinished = true;
	while ($unfinished)
	{
		$unfinished = false;

		foreach ($mm['nodes'] as $id=>$node)

			if ($node['is_leaf'] || $node['visible_children']==0 || ($node['collapsed'] ?? false))

				$mm['nodes'][$id]['h']
					= $mm['line_spacing']
					+ $mm['nodes'][$id]['lh']
				;

			else
			{
				$h = 0;
				$unready = false;

				foreach ($node['visible_children'] as $cid)
					if ($mm['nodes'][$cid]['h']>=0)
						$h += $mm['nodes'][$cid]['h'];
					else
					{
						$unready = true;
						break;
					}

				if ($unready)
					$unfinished = true;
				else
					$mm['nodes'][$id]['h']
						= max
						(
							  $h
							, $node['lh']
							+ $mm['line_spacing']
						)
					;
			}
	}
}


// }}}
// {{{ calculate y and yo

function calculate_y(&$mm)
{
	$mm['map_top']    = 0;
	$mm['map_bottom'] = 0;
	$mm['map_height'] = $mm['nodes'][0]['h'];

	$mm['nodes'][0]['y'] = 0;
	calculate_children_y($mm, 0);
}

function calculate_children_y(&$mm,$pid)
{
	$y = $mm['nodes'][$pid]['y'];

	$mm['nodes'][$pid]['yo'] =
		round(
			(
				+ $mm['nodes'][$pid]['h']
				- $mm['nodes'][$pid]['lh']
			)/2
		)
	;

	if (!($mm['nodes'][$pid]['collapsed'] ?? false))
		foreach ($mm['nodes'][$pid]['visible_children'] as $cid)
		{
			$mm['nodes'][$cid]['y'] = $y;

			$mm['map_bottom'] =
				max
				(
					 $mm['map_bottom']
					,$mm['nodes'][$cid]['lh']
					+$mm['line_spacing']
					+$y
				)
			;

			$mm['map_top'] = min($mm['map_top'],$y);
			$y += $mm['nodes'][$cid]['h'];
			calculate_children_y($mm,$cid);
		}
}


// }}}
// {{{ calculate top-down height shift

function calculate_height_shift(&$mm, $id, $shift = 0)
{
	$mm['nodes'][$id]['yo'] += $shift;
	$shift += max(0, floor( (($mm['nodes'][$id]['lh'] - $mm['nodes'][$id]['clh']))/2 - 0.9 ));

	foreach ($mm['nodes'][$id]['visible_children'] as $cid)
		if (!$mm['nodes'][$id]['collapsed'])
			calculate_height_shift($mm, $cid, $shift);
}


// }}}
// {{{ draw connections on the map

function draw_connections(&$mm, $id)
{
	$node = $mm['nodes'][$id];

	$num_visible_children = count($mm['nodes'][$id]['visible_children']);
	$num_children         = count($mm['nodes'][$id]['children']);
	$has_hidden_children  = $num_visible_children != $num_children;


	// if the node is collapsed
	if ( ($node['collapsed'] ?? false) && ($num_children > 0) )
	{
		if ($num_visible_children == $num_children)
			mmput
			(
				 $mm
				,$node['x'] + $node['w']+1
				,$node['y'] + $node['yo']
				,' [+]'
			);
		else
			mmput
			(
				 $mm
				,$node['x'] + $node['w']+1
				,$node['y'] + $node['yo']
				,'─╫─ [+]'
			);
		return;
	}

	// the easy part...
	if ($num_visible_children==0)
	{
		if ($num_children>0)
			mmput
			(
				 $mm
				,$node['x'] + $node['w'] + 1
				,round( $node['y']  + $node['yo']  ) + round( ($node['lh'] ) / 2 - 0.6 )
				,'─╫─'
			);
		return;
	}


	// if there's only one child: the same y coordinate
	if ($num_visible_children==1)
	{
		$child_id = $node['visible_children'][ array_key_first( $node['visible_children'] ) ];
		$child = $mm['nodes'][ $child_id ];

		$y1  = round( $node['y']  + $node['yo']  ) + round( ($node['lh'] ) / 2 - 0.6 );
		$y2  = round( $child['y'] + $child['yo'] ) + round( ($child['lh']) / 2 - 0.6 );

		$x =
			$mm['align_levels']
			? $node['x'] + $node['w'] - 2
			: $child['x'] - conn_left_len - conn_right_len
		;

		$line =
			(
				$has_hidden_children
				? '─╫'
				: '──'
			)
			.
			(
				$mm['align_levels']
				? str_repeat('─', $child['x'] - $node['x'] - $node['w'] - 1)
				: $mm['conn_single']
			)
		;

		mmput
		(
			 $mm
			,$x
			,min($y1,$y2)
			,$line
		);

		if (abs(min($y1,$y2)-$y2)>0)
		{
			for ($yy=min($y1,$y2); $yy<max($y1,$y2); $yy++)
				mmput
				(
					 $mm
					,$child['x'] - 2
					,$yy
					,'│'
				);

			mmput
			(
				$mm
				,$child['x'] - 2
				,$y2
				,( $y2 > $y1 ? '╰' : '╭' )
			);

			mmput
			(
				 $mm
				,$child['x'] - 2
				,min($y1,$y2)
				,( $y2 > $y1 ? '╮' : '╯' )
			);
		}

		draw_connections($mm, $child_id );
		return;
	}

	// if there's more than one child
	$bottom = 0;
	$bottom_child = 0;
	$top = $mm['map_height'];
	$top_child = 0;

	foreach ($node['visible_children'] as $cid)
	{
		if ($mm['nodes'][$cid]['y'] + $mm['nodes'][$cid]['yo'] > $bottom)
		{
			$bottom = $mm['nodes'][$cid]['y'] + $mm['nodes'][$cid]['yo'];
			$bottom_child = $cid;
		}

		if ($mm['nodes'][$cid]['y'] + $mm['nodes'][$cid]['yo'] < $top)
		{
			$top = $mm['nodes'][$cid]['y'] + $mm['nodes'][$cid]['yo'];
			$top_child = $cid;
		}
	}

	$middle  = round($node['y']+$node['yo']) + round($node['lh']/2-0.6);

	$x =
		$mm['align_levels']
		? $node['x'] + $node['w'] - 2
		: $mm['nodes'][$top_child]['x'] - conn_left_len - conn_right_len
	;

	$line =
		(
			$has_hidden_children
			? '─╫'
			: '──'
		)
		.
		(
			$mm['align_levels']
			? str_repeat('─', $mm['nodes'][$top_child]['x'] - $node['x'] - $node['w'] - 3 )
			: $mm['conn_left']
		)
	;

	mmput
	(
		 $mm
		,$x
		,$middle
		,$line
	);

	for ( $i = $top ; $i < $bottom ; $i++ )
		mmput
		(
			 $mm
			,$mm['nodes'][$top_child]['x'] - conn_right_len
			,$i
			,'│'
		);

	mmput
	(
		 $mm
		,$mm['nodes'][$top_child]['x'] - conn_right_len
		,$top
		,'╭'
		.$mm['conn_right']
	);

	mmput
	(
		 $mm
		,$mm['nodes'][$top_child]['x']-conn_right_len
		,$bottom
		,'╰'
		.$mm['conn_right']
	);

	if ($num_visible_children>2)
	foreach ($node['visible_children'] as $cid)
		if ($cid!=$top_child && $cid!=$bottom_child)
			mmput
			(
				 $mm
				,$mm['nodes'][$cid]['x']-conn_right_len
				,$mm['nodes'][$cid]['y']
				+$mm['nodes'][$cid]['lh']/2-0.2
				+$mm['nodes'][$cid]['yo']
				,'├'
				.$mm['conn_right']
			);


	$existing_char =
		mb_substr
		(
			 $mm['map'][$middle]
			,$mm['nodes'][$top_child]['x'] - conn_right_len
			,1
		);

	if ($existing_char=='│')
		mmput
		(
			 $mm
			,$mm['nodes'][$top_child]['x'] - conn_right_len
			,$middle
			,'┤'
		);

	if ($existing_char=='╭')
		mmput
		(
			 $mm
			,$mm['nodes'][$top_child]['x'] - conn_right_len
			,$middle
			,'┬'
		);

	if ($existing_char=='├')
		mmput
		(
			 $mm
			,$mm['nodes'][$top_child]['x'] - conn_right_len
			,$middle
			,'┼'
		);

	foreach ($node['visible_children'] as $cid)
		draw_connections($mm, $cid);
}

function calculate_xo(&$mm)
{
	foreach($mm['nodes'] as $id=>$node) {
		$node = $mm['nodes'][$id];
		$mm['nodes'][$id]['xo'] = 0;

		if (!array_key_exists('yo',$node)) {
			$node['yo'] = 0;
		}

		foreach($mm['nodes'] as $fore_node ) {
			if (!array_key_exists('yo', $fore_node)) {
				$fore_node['yo'] = 0;
			}

			if ($fore_node['y'] + $fore_node['yo'] == $node['y']  + $node['yo'] && $fore_node['x'] < $node['x']) {
				$mm['nodes'][$id]['xo'] +=  mb_strlen($fore_node['title']) - mb_strwidth($fore_node['title']);
			}
		}
	}
}

// }}}
// {{{ add content to the map

function add_content_to_the_map(&$mm, $id)
{
	$node = $mm['nodes'][$id];

	$at_the_end =
		$node['is_leaf']
		|| ($node['collapsed'] ?? false)
		|| count($node['visible_children']) == 0
	;

	$max_width =
		$at_the_end
		? $mm['max_leaf_node_width']
		: $mm['max_parent_node_width']
	;

	if ( mb_strlen($node['title']) > width_tolerance * $max_width)
		$lines =
			explode
			(
				PHP_EOL,
				wordwrap
				(
					$node['title']
					,$max_width
					,PHP_EOL
				)
			)
		;
	else
		$lines = [$node['title']];

	$num_lines = count($lines);
	for ( $i=0 ; $i<$num_lines ; $i++ )
		mmput
		(
			$mm,
			$node['x']+$node['xo'],
			$node['y']+$node['yo']+$i,
			$lines[$i].' '
		);

	if (!($node['collapsed'] ?? false))
		foreach ($node['visible_children'] as $cid)
			add_content_to_the_map($mm,$cid);
}


// }}}
// {{{ build map

function build_map(&$mm)
{
	// resetting the global values
	$mm['map_width']  = 0;
	$mm['map_height'] = 0;
	$mm['map_top']    = 0;
	$mm['map_bottom'] = 0;

	// resetting the coordinates
	foreach ($mm['nodes'] as $id=>$node)
	{
		$mm['nodes'][$id]['x']  = -1;
		$mm['nodes'][$id]['y']  = -1;
		$mm['nodes'][$id]['h']  = -1;
		$mm['nodes'][$id]['lh'] = -1;
		$mm['nodes'][$id]['visible_children'] = $mm['nodes'][$id]['children'];
	}

	$mm['nodes'][0]['x']  = 0;
	$mm['nodes'][0]['xo']  = 0;
	$mm['nodes'][0]['w']  = left_padding;
	$mm['nodes'][0]['lh'] = 1;

	// resetting the map, 1/2
	$mm['map']=[];
	$mm['map_width']=0;
	$mm['map_height']=0;
	$mm['map_top']=0;
	$mm['map_bottom']=0;

	// calculating the new coordinates
	if (!$mm['show_hidden'])
		list_visible_children($mm, $mm['root_id']);
	calculate_x_and_lh($mm,$mm['root_id']);
	if ($mm['align_levels'])
		calculate_aligned_x($mm,$mm['root_id'],$mm['nodes'][ $mm['root_id'] ]['w'] + conn_left_len + conn_right_len + 1);
	calculate_h($mm);
	calculate_y($mm);
	calculate_height_shift($mm, $mm['root_id']);

	calculate_xo($mm);

	// resetting the map, 2/2
	$height = max($mm['map_bottom'],$mm['terminal_height']);
	$blank = str_repeat(' ', max($mm['map_width'],$mm['terminal_width']));

	for ($i=$mm['map_top'] ; $i<=$height ; $i++)
		$mm['map'][$i] = $blank;

	// building the new map
	draw_connections($mm, $mm['root_id']);
	add_content_to_the_map($mm, $mm['root_id']);

}


// }}}
// {{{ toggle numbers

function toggle_numbers()
{
	global $mm;

	if ($mm['active_node'] <= $mm['root_id'])
		return;

	$padlen = count($mm['nodes'][ $mm['nodes'][$mm['active_node']]['parent'] ]['children']) > 9 ? 2 : 1;

	$ordered= false;
	$i=1;
	foreach ($mm['nodes'][ $mm['nodes'][$mm['active_node']]['parent'] ]['children'] as $cid)
		$ordered = $ordered || mb_ereg('^\d+\.',$mm['nodes'][$cid]['title']);

	$i=1;
	foreach ($mm['nodes'][ $mm['nodes'][$mm['active_node']]['parent'] ]['children'] as $cid)
		if ($ordered)
			$mm['nodes'][$cid]['title'] = mb_ereg_replace('^\d+\. *','',$mm['nodes'][$cid]['title']);
		else
			$mm['nodes'][$cid]['title'] = str_pad($i++, $padlen, '0', STR_PAD_LEFT).'. '.$mm['nodes'][$cid]['title'];

	push_change($mm);
	build_map($mm);
	display($mm);
}




// }}}
// {{{ toggle symbol

function toggle_symbol()
{
	global $mm;

	$len1 = mb_strlen($mm['symbol1'])+1;
	$len2 = mb_strlen($mm['symbol2'])+1;

	$sym1 = mb_substr($mm['nodes'][ $mm['active_node'] ]['title'],0,$len1);
	$sym2 = mb_substr($mm['nodes'][ $mm['active_node'] ]['title'],0,$len2);

	if ($sym1==$mm['symbol1'].' ')
		$mm['nodes'][ $mm['active_node'] ]['title'] =
			$mm['symbol2']
			.' '
			.mb_substr($mm['nodes'][ $mm['active_node'] ]['title'],$len1);
	elseif ($sym2==$mm['symbol2'].' ')
		$mm['nodes'][ $mm['active_node'] ]['title'] =
			mb_substr($mm['nodes'][ $mm['active_node'] ]['title'],$len2);
	else
		$mm['nodes'][ $mm['active_node'] ]['title'] =
			$mm['symbol1']
			.' '
			.$mm['nodes'][ $mm['active_node'] ]['title'];

	push_change($mm);
	build_map($mm);
	display($mm);
}


// }}}
// {{{ toggle hide

function toggle_hide()
{
	global $mm;

	if ($mm['active_node'] == $mm['root_id'])
		return;

	push_change($mm);

	$is_hidden = false;
	if ( substr($mm['nodes'][ $mm['active_node'] ]['title'], 0, 9) == '[HIDDEN] ')
		$mm['nodes'][ $mm['active_node'] ]['title'] = mb_substr( $mm['nodes'][ $mm['active_node'] ]['title'], 9 );
	else
	{
		$mm['nodes'][ $mm['active_node'] ]['title'] = '[HIDDEN] ' . $mm['nodes'][ $mm['active_node'] ]['title'];
		$is_hidden = true;
		move_active_node_to_sibling_or_parent($mm);
	}

	build_map($mm);
	display($mm);
	message($mm, 'Hidden attribute is turned '.($is_hidden ? 'on' : 'off').' for the node.');
}

function toggle_show_hidden()
{
	global $mm;

	$mm['show_hidden'] = !$mm['show_hidden'];
	move_active_node_to_sibling_or_parent($mm);

	build_map($mm);
	display($mm);
	message($mm, 'Hidden nodes will '.($mm['show_hidden'] ? '' : 'not ').'be shown.');
}

function move_active_node_to_sibling_or_parent(&$mm)
{
	if ($mm['show_hidden'] || substr($mm['nodes'][ $mm['active_node'] ]['title'],0,9)!='[HIDDEN] ' )
		return;

	$parent_id = $mm['nodes'][ $mm['active_node'] ]['parent'];
	if (count($mm['nodes'][$parent_id]['visible_children'])<=1)
		$mm['active_node'] = $parent_id;
	else
	{
		$passed = false;

		// getting the next sibling
		foreach ($mm['nodes'][$parent_id]['children'] as $cid)
			if ($cid==$mm['active_node'])
				$passed = true;
			elseif ($passed && substr($mm['nodes'][$cid]['title'],0,9)!='[HIDDEN] ')
			{
				$mm['active_node'] = $cid;
				return;
			}

		// so, there's no item after it!
		$mm['active_node'] = $parent_id;
	}
}



// }}}
// {{{ toggle align

function toggle_align()
{
	global $mm;
	$mm['align_levels'] = !$mm['align_levels'];
	build_map($mm);
	display($mm);
}


// }}}
// {{{ toggle node

function toggle_node()
{
	global $mm;

	if ($mm['nodes'][ $mm['active_node'] ]['is_leaf'])
		$mm['active_node'] = $mm['nodes'][ $mm['active_node'] ]['parent'];

	$mm['nodes'][ $mm['active_node'] ]['collapsed'] =
		!($mm['nodes'][ $mm['active_node'] ]['collapsed'] ?? false);

	build_map($mm);
	display($mm);
}


// }}}
// {{{ change line spacing

function increase_line_spacing()
{
	global $mm;
	change_line_spacing($mm, +1);
}

function decrease_line_spacing()
{
	global $mm;
	change_line_spacing($mm, -1);
}

function change_line_spacing(&$mm, $amount)
{
	$mm['line_spacing'] = max(0, $mm['line_spacing'] + $amount);

	build_map($mm);
	center_active_node_vh();
	display($mm);
	message($mm,'Spacing: '.$mm['line_spacing']);
}


// }}}
// {{{ change max node width

function increase_text_width()
{
	global $mm;
	change_max_node_width($mm, width_change_factor);
}

function decrease_text_width()
{
	global $mm;
	change_max_node_width($mm, 1/width_change_factor);
}

function change_max_node_width(&$mm, $amount)
{
	$mx = $mm['terminal_width'] - max_width_padding;

	$mm['max_parent_node_width'] = round(min($mx, max( width_min, $mm['max_parent_node_width'] * $amount )));
	$mm['max_leaf_node_width']   = round(min($mx, max( width_min, $mm['max_leaf_node_width']   * $amount )));

	build_map($mm);
	center_active_node_vh();
	display($mm);

	message($mm,'Width: '.$mm['max_parent_node_width'].' / '.$mm['max_leaf_node_width']);
}


// }}}
// {{{ push node down

function push_node_down(&$mm, $id)
{
	if ($id==$mm['root_id'])
		return;

	push_change($mm);

	if (isset($mm['nodes'][$id+1]))
		push_node_down($mm,$id+1);

	$mm['nodes'][$id+1] = $mm['nodes'][$id];
	unset($mm['nodes'][$id]);

	$mm['nodes'][ $mm['nodes'][$id+1]['parent'] ]['children'] =
		array_diff
		(
			$mm['nodes'][ $mm['nodes'][$id+1]['parent'] ]['children'],
			[$id]
		);

	$mm['nodes'][ $mm['nodes'][$id+1]['parent'] ]['children'] =
		array_push
		(
			$mm['nodes'][ $mm['nodes'][$id+1]['parent'] ]['children'],
			[$id+1]
		);

	foreach($mm['nodes'][$id+1]['children'] as $cid=>$cdata)
		$mm['nodes'][$cid]['parent'] = $id+1;
}


// }}}
// {{{ insert node


function insert_new_child()
{
	insert_new_node(insert_child);
}

function insert_new_sibling()
{
	insert_new_node(insert_sibling);
}


function insert_new_node($type)
{
	global $mm;

	if ($mm['active_node']==$mm['root_id'])
		$type=insert_child;

	if ($type==insert_sibling)
		$parent_id  = $mm['nodes'][ $mm['active_node'] ]['parent'];
	else
		$parent_id  = $mm['active_node'];

	$mm['nodes'][$parent_id]['is_leaf']   = false;
	$mm['nodes'][$parent_id]['collapsed'] = false;

	$new_id = max(array_keys($mm['nodes'])) + 1;

	$mm['nodes'][$new_id] =
	[
		'title'     => 'NEW',
		'is_leaf'   => true,
		'collapsed' => false,
		'children'  => [],
		'parent'    => $parent_id
	];

	if ($type==insert_sibling)
	{
		$children = [];
		foreach ($mm['nodes'][$parent_id]['children'] as $child)
		{
			$children[] = $child;
			if ($child==$mm['active_node'])
				$children[] = $new_id;
		}
		$mm['nodes'][$parent_id]['children'] = $children;
	}
	else
		$mm['nodes'][$parent_id]['children'][] = $new_id;

	$mm['active_node'] = $new_id;

	build_map($mm);
	display($mm);

	push_change($mm);

	$mm['nodes'][ $mm['active_node'] ]['title']='';
	edit_node($mm);
}


// }}}
// {{{ magic readline!

function magic_readline(&$mm, $title)
{
	$in = '';
	$cursor = mb_strlen($title)+1;
	$shift = max( 0, $cursor - $mm['terminal_width'] );

	show_line($mm, $title, $cursor, $shift);

	while(true)
	{
		usleep(5000);
		$in = fread(STDIN, 66666);
		// normally, the longest sequence we have is 13 bytes,
		// but if ctrl+shift+v is used, the whole text will be passed!
		// In other words, we don't receive a ctrl+shift+v input,
		// but the actual content. Was that a confusing behavior? Of course!!!

		if ($in != '')
		{
			if ($in==special_keys['esc'])
			{
				display($mm);
				return false;
			}

			elseif ($in==special_keys['arr_up'] || $in==special_keys['home'])
				$cursor = 1;

			elseif ($in==special_keys['arr_right'])
				$cursor = min( mb_strlen($title)+1, $cursor+1);

			elseif ($in==special_keys['arr_down'] || $in==special_keys['end'])
				$cursor = mb_strlen($title)+1;

			elseif ($in==special_keys['arr_left'])
				$cursor = max(1, $cursor-1);

			elseif ($in==special_keys['ctrl_arr_left'] || $in==special_keys['shift_arr_left'] || $in==special_keys['meta_arr_left'])
				$cursor =
					$cursor < 3
					? 1
					: max
						(
							1,
							(
								mb_strrpos($title,' ',$cursor-mb_strlen($title)-3) !== false
								? mb_strrpos($title,' ',$cursor-mb_strlen($title)-3) + 2
								: 1
							)
						);

			elseif ($in==special_keys['ctrl_arr_right'] || $in==special_keys['shift_arr_right'] || $in==special_keys['meta_arr_right'])
				$cursor =
					$cursor > mb_strlen($title) -2
					? mb_strlen($title) + 1
					: min
						(
							mb_strlen($title)+1,
							(
								mb_strpos($title,' ',$cursor+1) !== false
								? mb_strpos($title,' ',$cursor+1) + 2
								: mb_strlen($title) + 1
							)
						);

			// ctrl+backspace, meta+backspace, or alt+backspace
			elseif ($in==special_keys['ctrl_back_space'] || $in==special_keys['meta_back_space'] || $in==special_keys['ctrl_w'])
			{
				$from = 
					max
					(
						0
						,mb_strrpos
						(
							$title
							,' '
							,max
							(
								-mb_strlen($title)
								,$cursor-mb_strlen($title)-3
							)
						)
					)
				;
				$title = 
					 mb_substr($title, 0, $from + ($from>0) )
					.mb_substr($title, $cursor-1)
				;
				$cursor = $from+1+($from>0);
			}

			elseif ($in==special_keys['back_space'])
			{
				if ($cursor>1)
				{
					$title =
						mb_substr
						(
							$title
							,0
							,$cursor-2
						)
						.mb_substr
						(
							$title
							,$cursor-1
						);
					$cursor--;
				}
			}

			elseif ($in==special_keys['ctrl_del'])
			{
				$len = mb_strlen($title);
				$from = 
					mb_strpos
					(
						$title
						,' '
						,min
						(
							$cursor+1
							,$len
						)
					)
				;
				if ($from===false)
					$from=$len;
				$title = 
					 mb_substr($title, 0, $cursor-1)
					.mb_substr($title, $from+1 )
				;
			}

			elseif ($in==special_keys['del'])
			{
				$title =
					mb_substr
					(
						$title
						,0
						,$cursor-1
					)
					.mb_substr
					(
						$title
						,$cursor
					);
			}

			elseif ($in==special_keys['enter'])
				return trim($title);

			elseif ($in==special_keys['ctrl_v'])
			{
				$content =
					trim
					(
						str_replace
						(
							["\n", "\r", "\t"]
							,[" ",  "", "  " ]
							,get_from_clipboard($mm)
						)
					);

				$title =
					mb_substr
					(
						$title
						,0
						,$cursor-1
					)
					.$content
					.mb_substr
					(
						$title
						,$cursor-1
					);

				$cursor += mb_strlen($content);
			}


			// normal characters
			else
			{
				if ($in==special_keys['tab'])
					$in='  ';

				$title =
					mb_substr
					(
						$title
						,0
						,$cursor-1
					)
					.$in
					.mb_substr
					(
						$title
						,$cursor-1
					)
				;

				$title = str_replace(["\n","\r","\t"],[" ","","  "],$title);
				$title = mb_ereg_replace("[\000-\010\013-\037\177]|".BOM,'',$title);
				$cursor += mb_strlen($in);
				// the input content can be longer than one character if
				// the user uses ctrl+shift+v to paste.
			}

			// adjusting the position and shift

			$shift = max( 0, $shift, $cursor - $mm['terminal_width'] );
			$shift = min( $shift, $cursor-1 );

			show_line($mm, $title, $cursor, $shift);
		}
	}
}


function show_line(&$mm, $title, $cursor, $shift)
{
	$output  = mb_substr($title,$shift,$mm['terminal_width']-1);

	$output_len = mb_strwidth($output);
	if ($mm['terminal_width'] > $output_len)
		$output .= str_repeat( ' ' ,$mm['terminal_width'] - mb_strwidth($output) );

	// showing the cursor
	$output =
		mb_substr
		(
			$output
			,0
			,$cursor-$shift-1
		)
		.invert_on
		.mb_substr
		(
			$output
			,$cursor-$shift-1
			,1
		)
		.invert_off
		.mb_substr
		(
			$output
			,$cursor-$shift
		);

	echo
		"\033["
		.$mm['terminal_height'] //y
		.";0f" // 0 -> x
		.$mm['active_node_color']
		.$output
	;
}


// }}}
// {{{ edit node

function edit_node_append()
{
	edit_node(false);
}

function edit_node_replace()
{
	edit_node(true);
}

function edit_node($rewrite = false)
{
	global $mm;
	$title = $rewrite ? '' : $mm['nodes'][ $mm['active_node'] ]['title'];

	if
	(
		(
			$mm['active_node']==$mm['root_id']
			&& $title=='root'
		)
		or $title=='NEW'
	)
		$title = '';

	$output = magic_readline($mm, $title);

	if
	(
		(
			$output === false
			or $output === ''
		)
		&& $mm['nodes'][ $mm['active_node'] ]['title'] === ''
		&& $mm['nodes'][ $mm['active_node'] ]['is_leaf']
	)
	{
		delete_node_vh($mm, false, true);
		push_change($mm);
		build_map($mm);
		display($mm);
		return;
	}

	if ($output === false)
	{
		display($mm);
		message($mm, 'Editing cancelled');
		return;
	}

	$mm['nodes'][ $mm['active_node'] ]['title'] = $output;

	push_change($mm);

	build_map($mm);
	display($mm);
}


// }}}
// {{{ center active node

function center_active_node()
{
	global $mm;
	center_active_node_vh(false);
	display($mm);
}

function toggle_center_lock()
{
	global $mm;
	$mm['center_lock'] = !$mm['center_lock'];
	display($mm);
}

function center_active_node_vh($only_vertically = false)
{
	global $mm;
	$node = $mm['nodes'][ $mm['active_node'] ];

	$midx = $node['w']/2 + $node['x'];
	$midy = $node['lh']/2 + $node['y'] + $node['yo'];

	if (!$only_vertically)
		$mm['viewport_left'] = max(0, round( $midx - $mm['terminal_width']/2 ) );

	$mm['viewport_top'] = round( $midy - $mm['terminal_height']/2 );
}


// }}}
// {{{ goto's

function go_to_root()
{
	global $mm;
	$mm['active_node']=$mm['root_id'];
	display($mm, true);
}

function go_up()
{
	global $mm;
	change_active_node($mm,0,-1);
}

function go_down()
{
	global $mm;
	change_active_node($mm,0,1);
}

function go_left()
{
	global $mm;
	change_active_node($mm,-1,0);
}

function go_to_top()
{
	global $mm;
	$yid = 0;
	$y = $mm['map_height'];

	foreach ($mm['nodes'] as $id=>$node)
		if ($node['y']>=0 && $node['y']+$node['yo'] < $y)
		{
			$y = $node['y']+$node['yo'];
			$yid = $id;
		}

	$mm['active_node'] = $yid;
	display($mm, true);
}


function go_right()
{
	global $mm;
	change_active_node($mm,1,0);
}


function go_to_bottom()
{
	global $mm;
	$yid = 0;
	$y = 0;

	foreach ($mm['nodes'] as $id=>$node)
		if ($node['y']>=0 && $node['y']+$node['yo'] > $y)
		{
			$y = $node['y']+$node['yo']+$node['lh'];
			$yid = $id;
		}

	$mm['active_node'] = $yid;
	display($mm, true);
}


// }}}
// {{{ help

function help()
{

	global $mm;
	global $keybindings;

	$keynames = array_flip(special_keys);

	$commands = [];
	foreach ($keybindings as $key => $command)
		$commands[$command][] = ( $keynames[$key] ?? $key );

	$output = [];
	foreach ($commands as $command => $keys)
		$output[] =
		str_pad($command.' ',32,'.',STR_PAD_RIGHT)
		.' '
		.implode(', ',$keys);

	sort($output);

	$breakpoint = floor((count($output)-1)/2);

	for ($i=0 ; $i<=$breakpoint ; $i++)
		echo
			' '
			.str_pad($output[$i],56,' ',STR_PAD_RIGHT)
			.
			($output[$i+$breakpoint+1] ?? '')
			."\n"
		;
	echo "\n";

	message($mm, "Press any key to exit this help screen.");

	while (true)
	{
		usleep(20000);
		$in = fread(STDIN, 16);
		if ($in != '')
			break;
	}

	display($mm);

}


// }}}
// {{{ search

function search()
{
	global $mm;

	$mm['query'] = magic_readline($mm,'');

	if (empty($mm['query']))
	{
		display($mm);
		return;
	}

	if (!next_search_result())
		previous_search_result();
}


function previous_search_result()
{
	global $mm;

	$cy
		= $mm['nodes'][ $mm['active_node'] ]['y']
		+ $mm['nodes'][ $mm['active_node'] ]['yo']
	;

	$ny = -1;
	$nid = -1;

	foreach ($mm['nodes'] as $id=>$node)
		if
		(
			$id != 0 &&
			(
				$mm['show_hidden'] ||
				substr($node['title'],0,9) != '[HIDDEN] '
			) &&
			$node['y'] > -1 &&
			$node['y']+$node['yo'] < $cy &&
			$node['y']+$node['yo'] > $ny &&
			mb_stripos($node['title'],$mm['query'])!==false
		)
		{
			 $ny = $node['y'] + $node['yo'];
			 $nid = $id;
		}

	if ($nid<0)
	{
		display($mm);
		return false;
	}

	$mm['active_node'] = $nid;
	display($mm);
}


function next_search_result()
{
	global $mm;

	$cy
		= $mm['nodes'][ $mm['active_node'] ]['y']
		+ $mm['nodes'][ $mm['active_node'] ]['yo']
	;

	$ny = $mm['map_height']+1;
	$nid = -1;

	foreach ($mm['nodes'] as $id=>$node)
		if
		(
			$id != 0 &&
			(
				$mm['show_hidden'] ||
				substr($node['title'],0,9) != '[HIDDEN] '
			) &&
			$node['y'] > -1 &&
			$node['y']+$node['yo'] > $cy &&
			$node['y']+$node['yo'] < $ny &&
			mb_stripos($node['title'],$mm['query'])!==false
		)
		{
			$ny = $node['y'] + $node['yo'];
			$nid = $id;
		}

	if ($nid<0)
		return false;

	$mm['active_node'] = $nid;
	display($mm);
}


// }}}
// {{{ move active node

function move_node_down()
{
	global $mm;

	if ($mm['active_node']==0) return;

	push_change($mm);

	$parent_id = $mm['nodes'][ $mm['active_node'] ]['parent'];
	$children = [];
	$just_passed_active = false;

	foreach ($mm['nodes'][ $parent_id ]['children'] as $child)
	{
		if ($child!=$mm['active_node'])
			$children[] = $child;

		if ($just_passed_active && ($mm['show_hidden'] || substr($mm['nodes'][$child]['title'],0,9)!='[HIDDEN] ' ) )
		{
			$children[] = $mm['active_node'];
			$just_passed_active = false;
		}

		if ($child==$mm['active_node'])
			$just_passed_active = true;
	}

	if ($just_passed_active)
		$children[] = $mm['active_node'];

	$mm['nodes'][ $parent_id ]['children'] = $children;

	build_map($mm);
	display($mm);
}


function move_node_up()
{
	global $mm;

	if ($mm['active_node']==0) return;

	push_change($mm);

	$parent_id = $mm['nodes'][ $mm['active_node'] ]['parent'];
	$children = [];
	$just_passed_active = false;
	$rev_children = array_reverse($mm['nodes'][$parent_id]['children']);

	foreach ($rev_children as $child)
	{
		if ($child!=$mm['active_node'])
			$children[] = $child;

		if ($just_passed_active && ($mm['show_hidden'] || substr($mm['nodes'][$child]['title'],0,9)!='[HIDDEN] ' ) )
		{
			$children[] = $mm['active_node'];
			$just_passed_active = false;
		}

		if ($child==$mm['active_node'])
			$just_passed_active = true;
	}

	if ($just_passed_active)
		$children[] = $mm['active_node'];

	$mm['nodes'][ $parent_id ]['children'] = array_reverse($children);

	build_map($mm);
	display($mm);
}


// }}}
// {{{ export html

function export_html()
{
	global $mm;

	if (empty($mm['filename']))
	{
		message($mm, "Can't export the map when it doesn't have a file name yet. Save it first.");
		return;
	}

	$file = fopen($mm['filename'].'.html', "w");

	if ($file===false)
	{
		message($mm, 'ERROR! Could not save the file');
		return;
	}

	fwrite
	(
		$file
		,'<!DOCTYPE html>'
		.'<html lang=en>'
		.'<head>'
		.'<title>'
		.$mm['nodes'][ $mm['root_id'] ]['title']
		.'</title>'
		.'<meta charset="UTF-8">'
		.'<meta name=viewport content="width=device-width,initial-scale=1,user-scalable=yes">'
		.'<style>'
		.'body { background-color: #222; color: #ddd; font-family: monospace; padding: 0; font-size: 16px; }'
		.'#root {margin:10px 0}'
		.'p:before { content: "━ "; }'
		.'p, summary { padding: 8px; margin: 0; font-size: 16px; }'
		.'details, p { padding-left: 29px; border-left: 3px solid #444; font-size:16px; }'
		.'summary { margin-left: -10px; cursor: pointer; }'
		.'summary:hover, p:hover { color: #fbc531; }'
		.'details:hover, p:hover { border-color: #e1b12c; }'
		.'#source { position: absolute; bottom: 0; left: 0; padding: 5px 15px 8px 15px; margin: 100px 0 0 0; }'
		.'#source { background-color: #333; border: none; box-sizing: border-box;}'
		.'#source > summary { list-style: none; }'
		.'#source[open] { position: static; margin: 100px 0 0 0; font-size: 16px; }'
		.'#map { margin: 40px 30px; }'
		.'</style>'
		.'</head>'
		.'<body>'
		.'<div id=map>'
		.export_html_node($mm, $mm['root_id'])
		.'</div>'
		.'<details id=source>'
		.'<summary>This is a limited, read-only version of a mind-map created in h-m-m | view source!</summary>'
		.'<pre>'
		.map_to_list($mm,$mm['root_id'])
		.'</pre>'
		.'</details>'
		.'</body>'
		.'</html>'
	);

	fclose($file);

	message($mm, $mm['filename'].'.html', 'Exported as');
	copy_to_clipboard($mm, $mm['filename'].'.html');
	$filename = getenv('PWD').'/'.basename($mm['filename']).'.html';

	if ($mm['post_export_command']!='')
	{
		message($mm, 'Running the "'.$mm['post_export_command'].'" command');
		exec(str_replace('%filename%', $filename, $mm['post_export_command']), $output, $result);
		display($mm);
		message($mm, 'Post-export command ended ('.$result.')');
	}
}


function export_html_node(&$mm, $parent_id)
{
	if ($mm['nodes'][$parent_id]['visible_children']==[])
	{
		$output =
			"<p>"
			.$mm['nodes'][$parent_id]['title']
			."</p>";
	}
	elseif ($parent_id==$mm['root_id'])
	{
		$output =
			"<div id=root>"
			.$mm['nodes'][$parent_id]['title']
			."</div>";

		foreach ($mm['nodes'][$parent_id]['visible_children'] as $cid)
			$output .= export_html_node($mm, $cid);
	}
	else
	{
		$output =
			"<details>"
			."<summary>"
			.$mm['nodes'][$parent_id]['title']
			."</summary>";

		foreach ($mm['nodes'][$parent_id]['visible_children'] as $cid)
			$output .= export_html_node($mm, $cid);

		$output .=
			"</details>";
	}

	return $output;
}


// }}}
// {{{ export text

function export_text()
{
	global $mm;

	$output = '';
	foreach ($mm['map'] as $line)
		if (rtrim($line) != '')
			$output .= substr(rtrim($line),3)."\n";

	copy_to_clipboard($mm, $output);
	message($mm, 'Exported the map to clipboard.');
}



// }}}
// {{{ save

function save()
{
	global $mm;
	if ($mm['auto_save'])
		message($mm,'auto_save is enabled and you don\'t need to save manually.');
	else
		save_vh($mm, false);
}

function save_as()
{
	global $mm;
	save_vh($mm, true);
}

function save_vh(&$mm, $new_name = false)
{
	if ($new_name || empty($mm['filename']))
	{
		$path = getenv('PWD');

		if (substr($path,-1,1) != '/')
			$path .= '/';

		if (empty($mm['filename']) && $mm['nodes'][ $mm['root_id'] ]['title'] != 'root')
			$path .= preg_replace('/[^a-zA-Z0-9]/','-',$mm['nodes'][ $mm['root_id'] ]['title']);

		$new_name = magic_readline($mm, (empty($mm['filename']) ? $path : $mm['filename'] ) );

		if ($new_name === false)
		{
			display($mm);
			message($mm, 'Saving cancelled');
			return;
		}

		$mm['filename'] = $new_name;
		$ext = mb_substr( $mm['filename'], mb_strrpos($mm['filename'],'.') + 1);

		if ($ext!='hmm')
			$mm['filename'] .= '.hmm';

		display($mm);
	}

	if (file_exists($mm['filename']) && !is_writable($mm['filename']))
	{
		message($mm, "ERROR! I don't have access to write into \"$mm[filename]\". Use shift+s and set another path and filename.");
		sleep(1);
		return;
	}

	change_window_title($mm['filename']);

	$file = fopen($mm['filename'], "w");

	$mm['modified'] = false;

	if ($file===false)
	{
		message($mm, 'ERROR! Could not save the file');
		$mm['modified'] = true;
		return;
	}

	fwrite($file, map_to_list($mm, $mm['root_id']) . "\n");
	fclose($file);

	display($mm);
	if (!$mm['auto_save'])
		message($mm, $mm['filename'], 'Saved');
}


// }}}
// {{{ message

function message(&$mm, $body, $prefix='')
{
	$mm['terminal_width']  = (int)exec('tput cols');
	$mm['terminal_height'] = (int)exec('tput lines');

	$extralen = $mm['terminal_width'] - mb_strlen($prefix) - mb_strlen($body) - 2;
	if ($extralen < 1)
		$body = '...' . mb_substr($body, -$extralen+4);

	echo
		"\033["
		.$mm['terminal_height'] // y
		.";"
		.max(0,$extralen) //x
		."f"
		.$mm['message_color']
		.' '
		.$prefix
		.($prefix=='' ? '' : ' ')
		.$body
		.' '
		.reset_color
	;

	usleep(200000);
}


// }}}
// {{{ quit

function quit()
{
	global $mm;
	if (($mm['modified'] ?? false) === false)
		shutdown();
	message($mm, "You have unsaved changes. Save them, or use shift+Q to quit without saving.");
}


function quit_with_debug()
{
	global $mm;
	$file = fopen('./h-m-m--debug.txt', "w");

	if ($file!==false)
	{
		fwrite($file, serialize($mm));
		fclose($file);
		echo "Debug information is written to h-m-m--debug.txt file.";
	}

	shutdown();
}


// }}}
// {{{ move_window

function move_window(&$mm)
{
	$node = $mm['nodes'][ $mm['active_node'] ];

	$x1 = max(0, $node['x'] - conn_right_len - 2);
	$x2 = $node['x'] + $node['w'] + 2;
	$y1 = max(0, $node['y'] + $node['yo'] - vertical_offset);
	$y2 = $y1 + $node['lh'] + vertical_offset*2;

	$mm['viewport_left'] = min( $mm['viewport_left'], $x1);
	$mm['viewport_left'] = max( $mm['viewport_left'], $x2 - $mm['terminal_width']);

	$mm['viewport_top']  = min( $mm['viewport_top'],  $y1);
	$mm['viewport_top']  = max( $mm['viewport_top'],  $y2 - $mm['terminal_height']);
}


// }}}
// {{{ changes

function push_change(&$mm)
{
	// flush any redo chain
	while(count($mm['changes']) > $mm['change_index'])
	{
		array_pop($mm['changes']);
		array_pop($mm['change_active_node']);
	}

	// removing the old history if it's getting bigger than the maximum
	if (count($mm['changes']) >= $mm['max_undo_steps'])
	{
		array_shift($mm['changes']);
		array_shift($mm['change_active_node']);
		$mm['change_index']--;
	}

	array_push($mm['changes'], $mm['nodes']);
	array_push($mm['change_active_node'], $mm['active_node']);
	$mm['change_index']++;

	$mm['modified'] = true;
	if ($mm['auto_save'])
		save_vh($mm);
}


function undo()
{
	global $mm;

	if($mm['change_index'] == 0)
		return;

	$mm['change_index']--;
	$mm['nodes'] = $mm['changes'][$mm['change_index']];
	$mm['active_node'] = $mm['change_active_node'][$mm['change_index']];

	build_map($mm);
	display($mm);
}


function redo()
{
	global $mm;

	if(count($mm['changes']) == $mm['change_index'])
		return;

	$mm['nodes'] = $mm['changes'][$mm['change_index']];
	$mm['active_node'] = $mm['change_active_node'][$mm['change_index']];
	$mm['change_index']++;

	build_map($mm);
	display($mm);
}


// }}}
// {{{ change active node

function change_active_node(&$mm, $x, $y)
{
	$node = $mm['nodes'][ $mm['active_node'] ];

	// we go to the child that is closest to the parent node;
	// i.e., closest to the middle.

	if ($x > 0)
	{
		if (count($node['visible_children'])==0)
			return;

		// auto-unfold node on right move
		if ($node['collapsed'] ?? false) {
			toggle_node($mm);
			$node = $mm['nodes'][ $mm['active_node'] ];
		}

		$distance = [];
		foreach ($node['visible_children'] as $cid)
			$distance[$cid] =
				abs
				(
					+ $node['y']
					+ $node['yo']
					+ $node['lh']/2
					- $mm['nodes'][$cid]['y']
					- $mm['nodes'][$cid]['yo']
					- $mm['nodes'][$cid]['lh']/2
				)
			;

		asort($distance);

		$mm['active_node'] = array_keys($distance)[0];

		display($mm);
		return;
	}

	// no other movement applies to the root element
	if ( $mm['active_node']==0 ) return;


	// it can't be easier than moving to the left!
	if ($x < 0)
	{
		if ($mm['active_node']==$mm['root_id']) return;
		$mm['active_node'] = $node['parent'];
		display($mm);
		return;
	}

	// for up and down, we'll try to move between siblings first,
	// considering that their order is set based on their list
	// in the parent item.

	if ($y < 0)
	{
		$rchildren = array_reverse($mm['nodes'][ $node['parent'] ]['visible_children']);
		foreach ($rchildren as $cid)
			if ($mm['nodes'][$cid]['y']+$mm['nodes'][$cid]['yo'] < $node['y']+$node['yo'])
			{
				$mm['active_node'] = $cid;
				display($mm);
				return;
			}
	}

	if ($y > 0)
		foreach ($mm['nodes'][ $node['parent'] ]['visible_children'] as $cid)
			if ($mm['nodes'][$cid]['y']+$mm['nodes'][$cid]['yo'] > $node['y']+$node['yo'])
			{
				$mm['active_node'] = $cid;
				display($mm);
				return;
			}

	// if it's not possible to move up or down between siblings,
	// we'll measure distance and move to the nearest node.
	// because the goal is to move vertically, and also because
	// the aspect ratio of characters is not 1, there's a factor
	// for y to give it more importance. I've set the amount by
	// trial and erros and doesn't follow an exact logic. It may
	// need refinements in the future.

	$distance = [];

	foreach ($mm['nodes'] as $id=>$nd)
		if ($id != $mm['active_node'] && $nd['y']!=-1)
		{
			$dy = $nd['y'] + $nd['yo'] + $nd['lh']/2 - $node['y'] - $node['yo'] - $node['lh']/2;
			if ( ($y>0 && $dy>0) || ($y<0 && $dy<0) )
			{
				$dx = $nd['x'] + $nd['w']/2 - $node['x'] - $node['w']/2;
				$distance[$id] = pow($dy*15,2) + pow($dx,2);
			}
		}

	if ($distance==[]) return;
	asort($distance);

	$mm['active_node'] = array_keys($distance)[0];

	display($mm);
	return;
}


// }}}
// {{{ append

function append()
{
	global $mm;

	$mm['nodes'][ $mm['active_node'] ]['title'] .=
		' '
		.str_replace
		(
			["\n","\r","\t"]
			,[' ','',  '  ']
			,trim(get_from_clipboard($mm))
		)
	;

	build_map($mm);
	display($mm);
}


// }}}
// {{{ paste sub-tree

function paste_as_children()
{
	global $mm;
	paste_sub_tree($mm, false);
}

function paste_as_siblings()
{
	global $mm;
	paste_sub_tree($mm, true);
}

function paste_sub_tree(&$mm, $as_sibling )
{
	if ($as_sibling && $mm['active_node']==$mm['root_id'])
		return;

	if ($as_sibling)
		$parent_id = $mm['nodes'][ $mm['active_node'] ]['parent'];
	else
		$parent_id = $mm['active_node'];

	$mm['nodes'][ $parent_id ]['collapsed'] = false;
	$mm['nodes'][ $parent_id ]['is_leaf']   = false;

	$new_id = 1 + max(array_keys($mm['nodes']));

	// \n instead of PHP_EOL, just to be sure.
	// existing \r's will be removed later.
	$st =
		list_to_map
		(
			explode("\n",get_from_clipboard($mm)),
			$parent_id,
			$new_id
		)
	;

	if ($st==[])
		return;

	push_change($mm);

	$mm['nodes'] += $st;

	// doing it like this, in case the sub-tree has more than
	// one top-level element.

	foreach ($st as $cid=>$cdata)
		if ($cdata['parent'] == $parent_id)
			$mm['nodes'][ $parent_id ]['children'][] = $cid;

	// rearranging the items only if they are pasted as siblings
	// (for pasting as children, it makes sense to have them
	// at the end)

	if ($as_sibling)
	{
		$sub_roots = [];
		foreach ($st as $cid=>$cdata)
			if ($cdata['parent']==$parent_id)
				$sub_roots[] = $cid;

		$children = [];

		foreach ($mm['nodes'][ $parent_id ]['children'] as $child_id)
		{
			if (!in_array($child_id, $sub_roots))
				$children[] = $child_id;

			if ($child_id == $mm['active_node'])
				$children = array_merge($children, $sub_roots);
		}

		$mm['nodes'][ $parent_id ]['children'] = $children;
	}

	$mm['active_node'] = $new_id;

	build_map($mm);
	display($mm);
}


// }}}
// {{{ clipboard

function copy_to_clipboard(&$mm, $text)
{
	switch ($mm['clipboard'])
	{
		case 'os':
			$clip = popen($mm['os_clipboard']['write'],'wb');
			if (!isset($clip))
				return;
			fwrite($clip,$text);
			pclose($clip);
			break;
		case 'internal':
			$GLOBALS['clipboard'] = $text;
			break;
		case 'file':
			file_put_contents($mm['clipboard_file'],$text);
			break;
		case 'command':
			shell_exec(str_replace('%text%', '"'.$text.'"', $mm['clipboard_in_command']));
			break;
	}
}


function get_from_clipboard(&$mm)
{

	$text = 'clipboard unavailable!';

	switch ($mm['clipboard'])
	{
		case 'os':       $text = shell_exec($mm['os_clipboard']['read']);  break;
		case 'internal': $text = $GLOBALS['clipboard'];                    break;
		case 'file':     $text = file_get_contents($mm['clipboard_file']); break;
		case 'command':  $text = shell_exec($mm['clipboard_out_command']); break;
		default:         $text = "The clipboard type you've set is invalid!";
	}

	return
		mb_ereg_replace
		(
			"[\000-\010\013-\037\177]|".BOM
			,''
			,$text
		)
	;
}


// }}}
// {{{ load empty map

function load_empty_map(&$mm)
{
	change_window_title('new mind map');

	if (isset($mm['nodes']))
		unset($mm['nodes']);

	$mm['nodes'][0] =
		[
			'title'=>'X'
			,'is_leaf'=>false
			,'children'=>[1]
			,'collapsed'=>false
			,'parent'=>-1
		]
	;

	$title = basename( empty($mm['filename']) ? 'root' : $mm['filename'] );
	if (substr($title,-4)=='.hmm')
		$title = substr($title,0,-4);

	$mm['nodes'][1] =
		[
			'title'=> $title
			,'is_leaf'=>true
			,'children'=>[]
			,'collapsed'=>false
			,'parent'=>0
		]
	;

	$mm['active_node']=1;
	$mm['root_id']=1;
}


// }}}
// {{{ yank

function yank_node()
{
	global $mm;
	copy_to_clipboard($mm, map_to_list($mm, $mm['active_node'], false));
	message($mm, 'Item(s) are copied to the clipboard.');
}

function yank_children()
{
	global $mm;
	copy_to_clipboard($mm, map_to_list($mm, $mm['active_node'], true));
	message($mm, 'Item(s) are copied to the clipboard.');
}


// }}}
// {{{ delete

function delete_node()
{
	global $mm;
	delete_node_vh($mm, false, false);
}

function delete_children()
{
	global $mm;
	delete_node_vh($mm, true, false);
}

function delete_node_without_clipboard()
{
	global $mm;
	delete_node_vh($mm, false, true);
}

function delete_node_vh(&$mm, $exclude_parent = false, $dont_copy_to_clipboard = false )
{
	if ($mm['active_node']==$mm['root_id'])
		$exclude_parent = true;

	if (!$dont_copy_to_clipboard)
		copy_to_clipboard($mm, map_to_list($mm, $mm['active_node'], $exclude_parent) );

	push_change($mm);

	delete_node_internal($mm, $mm['active_node'], $exclude_parent);

	build_map($mm);
	display($mm);

	if (!$dont_copy_to_clipboard)
		message($mm, 'Item(s) are cut and placed into the clipboard.');
}


function delete_node_internal(&$mm, $active_node, $exclude_parent = false )
{
	// taking a shorter approach if it's for the whole tree

	if ($active_node==$mm['root_id'] && !$exclude_parent)
	{
		load_empty_map($mm);
		display($mm, true);
		return;
	}

	// if it's for a sub-tree, then...

	delete_children_vh($mm, $active_node);

	if ($exclude_parent)
	{
		$mm['nodes'][ $active_node ]['is_leaf'] = true;
		$mm['nodes'][ $active_node ]['children'] = [];
	}
	else
	{
		$parent_id = $mm['nodes'][ $active_node ]['parent'];

		$previous_sibling = 0;
		$passed = false;
		foreach ($mm['nodes'][$parent_id]['visible_children'] as $cid)
			if ($cid==$active_node)
			{
				if ($previous_sibling!=0) break;
				$passed = true;
			}
			else
			{
				$previous_sibling = $cid;
				if ($passed) break;
			}

		$mm['nodes'][$parent_id]['children'] =
			array_diff
			(
				$mm['nodes'][$parent_id]['children'],
				[$active_node]
			)
		;

		$mm['nodes'][$parent_id]['visible_children'] =
			array_diff
			(
				$mm['nodes'][$parent_id]['visible_children'],
				[$active_node]
			)
		;

		if (count($mm['nodes'][$parent_id]['children'])==0)
			$mm['nodes'][$parent_id]['is_leaf'] = true;

		unset($mm['nodes'][ $active_node ]);

		if (count($mm['nodes'][$parent_id]['visible_children'])==0)
			$mm['active_node'] = $parent_id;
		else
			$mm['active_node'] = $previous_sibling;
	}
}


function delete_children_vh(&$mm,$id)
{
	foreach (($mm['nodes'][$id]['children'] ?? []) as $cid)
	{
		delete_children_vh($mm, $cid);
		unset($mm['nodes'][$cid]);
	}
}


// }}}
// {{{ focus

function toggle_focus_lock()
{
	global $mm;
	$mm['focus_lock'] = !$mm['focus_lock'];

	message($mm, $mm['focus_lock'] ? 'Focus locked' : 'Focus unlocked');

	build_map($mm);
	display($mm);
}


function focus()
{
	global $mm;
	focus_vh($mm);
	build_map($mm);
	display($mm,true);
}

function focus_vh(&$mm)
{
	collapse_siblings($mm, $mm['active_node']);
	expand_siblings($mm, $mm['active_node']);
}


// }}}
// {{{ collapse and expand

function expand_all()
{
	global $mm;
	foreach ($mm['nodes'] as $id=>$node)
		$mm['nodes'][$id]['collapsed'] = false;

	build_map($mm);
	center_active_node_vh();
	display($mm);
}


function collapse_siblings(&$mm, $id)
{
	if ($id <= $mm['root_id'])
		return;

	$parent_id = $mm['nodes'][$id]['parent'];

	foreach ($mm['nodes'][$parent_id]['children'] as $cid)
		if ($cid!=$id)
			$mm['nodes'][$cid]['collapsed'] = true;

	collapse_siblings($mm, $parent_id);
}


function expand_siblings(&$mm, $id)
{
	if ($mm['nodes'][$id]['is_leaf'])
		return;

	$mm['nodes'][$id]['collapsed'] = false;
	foreach ($mm['nodes'][$id]['children'] as $cid)
		expand_siblings($mm, $cid);
}


function collapse_other_branches()
{
	global $mm;

	if ($mm['active_node'] == $mm['root_id'])
		return;

	$branch = find_branch($mm, $mm['active_node']);

	foreach ($mm['nodes'][ $mm['root_id'] ]['children'] as $bid)
		if ($bid != $branch)
			$mm['nodes'][$bid]['collapsed'] = true;

	build_map($mm);
	center_active_node_vh();
	display($mm);
}


function collapse_inner()
{
	global $mm;

	foreach ($mm['nodes'][ $mm['active_node'] ]['children'] as $cid)
		$mm['nodes'][$cid]['collapsed'] = true;

	$mm['nodes'][ $mm['active_node'] ]['collapsed'] = false;

	build_map($mm);
	center_active_node_vh();
	display($mm);
}


function find_branch(&$mm, $cid)
{
	if ($mm['nodes'][$cid]['parent'] == $mm['root_id'])
		return $cid;
	else
		return find_branch($mm, $mm['nodes'][$cid]['parent']);
}


function collapse_all()
{
	global $mm;

	foreach ($mm['nodes'] as $id=>$node)
		if (!$node['is_leaf'] && $id!=0 && $id!=$mm['root_id'])
			$mm['nodes'][$id]['collapsed'] = true;

	$mm['active_node'] = $mm['root_id'];

	build_map($mm);
	center_active_node_vh();
	display($mm);
}


function collapse_children()
{
	global $mm;

	foreach ($mm['nodes'][ $mm['active_node'] ]['children'] as $cid)
		if (!$mm['nodes'][$cid]['is_leaf'])
			$mm['nodes'][$cid]['collapsed'] = true;

	build_map($mm);
	center_active_node_vh();
	display($mm);
}


function collapse(&$mm, $id, $keep)
{
	if ($mm['nodes'][$id]['is_leaf']) return;

	if ($keep<=0)
		$mm['nodes'][$id]['collapsed'] = true;
	else
	{
		$mm['nodes'][$id]['collapsed'] = false;
		foreach ($mm['nodes'][$id]['children'] as $cid)
			collapse($mm, $cid, $keep-1);
	}
}

function collapse_level_1() { global $mm; collapse_level($mm, 1); }
function collapse_level_2() { global $mm; collapse_level($mm, 2); }
function collapse_level_3() { global $mm; collapse_level($mm, 3); }
function collapse_level_4() { global $mm; collapse_level($mm, 4); }
function collapse_level_5() { global $mm; collapse_level($mm, 5); }
function collapse_level_6() { global $mm; collapse_level($mm, 6); }
function collapse_level_7() { global $mm; collapse_level($mm, 7); }
function collapse_level_8() { global $mm; collapse_level($mm, 8); }
function collapse_level_9() { global $mm; collapse_level($mm, 9); }

function collapse_level(&$mm, $level, $no_display = false)
{
	collapse($mm, $mm['root_id'], $level);

	$id_collapsed = [];
	$current = $mm['active_node'];
	while ($current != $mm['root_id'])
	{
		$id_collapsed[$current] = $mm['nodes'][$current]['collapsed'];
		$current = $mm['nodes'][$current]['parent'];
	}

	$id_collapsed = array_reverse( $id_collapsed, true);
	foreach ($id_collapsed as $id=>$collapsed)
		if ($collapsed)
		{
			$mm['active_node'] = $id;
			break;
		}

	if ($no_display) return;

	build_map($mm);
	center_active_node_vh();
	display($mm);
}


// }}}
// {{{ display

function display(&$mm, $force_center = false)
{
	if ($mm['focus_lock'])
	{
		focus_vh($mm);
		build_map($mm);
	}

	if ($mm['center_lock'] || $force_center)
		center_active_node_vh();
	else
		move_window($mm);

	$mm['terminal_width']  = (int)exec('tput cols');
	$mm['terminal_height'] = (int)exec('tput lines');

	$blank = str_repeat(' ', $mm['terminal_width']);


	// calculating the coordinates of the active node

	$x1 =
		max
		(
			 0
			,$mm['nodes'][ $mm['active_node'] ]['x'] + $mm['nodes'][ $mm['active_node'] ]['xo']
			-1
			-$mm['viewport_left']
		)
	;

	$x2
		= $mm['nodes'][ $mm['active_node'] ]['wl']
		+ $x1
		+ 2
		- ($mm['active_node']==0 && left_padding==0)
	;

	$y1 =
		max
		(
			  0
			, $mm['nodes'][ $mm['active_node'] ]['y']
			+ $mm['nodes'][ $mm['active_node'] ]['yo']
			- $mm['viewport_top']
		)
	;

	$y2
		= $mm['nodes'][ $mm['active_node'] ]['lh']
		+ $y1
	;

	// building the output

	$output = '';

	for ( $y = 0 ; $y < $mm['terminal_height'] ; $y++ )
	{
		if (isset($mm['map'][$y+$mm['viewport_top']]))
			$line =
				mb_substr(
					$mm['map'][$y+$mm['viewport_top']],
					$mm['viewport_left'],
					$mm['terminal_width']
				)
			;
		else
			$line = $blank;


		// ensuring that the line is long enough even if the map line is
		// shorter than the terminal width
		if (mb_strwidth($line) < $mm['terminal_width'])
			$line .= str_repeat(' ', $mm['terminal_width'] - mb_strwidth($line));

		// this one really depends on (x,y), but after this, the
		// coordinates are not reliable anymore because of the
		// added escape codes.

		if ( $y >= $y1 && $y < $y2 )
			$line =
				 mb_substr($line, 0, $x1)
				.$mm['active_node_color']
				.mb_substr($line, $x1, $x2-$x1)
				.reset_color
				.mb_substr($line, $x2)
			;

		// styling the codes when the node is not active
		// with "else", the downside is that other codes
		// with the same "y" will not be styled.
		// Without the "else", the downside is that the
		// rest of the line in the active node won't be bold.
		// between these two, I think the former is better.

		else
			$line =
				mb_ereg_replace
				(
					'\b(.?\d+)\. '
					,dim_on.'\\1. '.dim_off
					,$line
				)
			;

		// styling the search results

		if ($mm['query'] ?? '' != '')
			$line =
				str_ireplace
				(
					$mm['query']
					,invert_on.$mm['query'].invert_off
					,$line
				)
			;

		// styling the collapsed symbol

		$line =
			str_replace
			(
				 ' [+]'
				,' '
				.collapsed_symbol_on
				.'[+]'
				.collapsed_symbol_off
				,$line
			)
		;

		// styling the lines

		$line =
			mb_ereg_replace
			(
				'([─-╱]+)'
				,line_on.'\\1'.line_off
				,$line
			)
		;

		// styling "(?)

		$line =
			str_replace
			(
				 '(?)'
				,$mm['doubt_color'].'(?)'.default_color
				,$line
			);

		// styling "???"

		$line =
			str_replace
			(
				 '???'
				,$mm['doubt_color'].'???'.default_color
				,$line
			);

		// dimming {meta}s

		$line =
			str_replace
			(
				'{'
				,dim_on.'{'
				,$line
			);

		$line =
			str_replace
			(
				 '}'
				,'}'.dim_off
				,$line
			);

		// done!
		$output .= $line;
	}


	echo reset_page.reset_color.$output;


	// showing the logo :)

	if ($mm['show_logo'])
	{
		$ll = $mm['terminal_width'] - 14;
		echo "\033[1;{$ll}f\033[38;5;237m ┌────────────┐ ";
		echo "\033[2;{$ll}f\033[38;5;237m │     ╭─ m   │ ";
		echo "\033[3;{$ll}f\033[38;5;237m │ h ──┤      │ ";
		echo "\033[4;{$ll}f\033[38;5;237m │     ╰─── m │ ";
		echo "\033[5;{$ll}f\033[38;5;237m └────────────┘ ";
	}

}


function mmput(&$mm,$x,$y,$s)
{
	$y = round($y);

	$mm['map'][$y]
		= mb_substr( $mm['map'][$y], 0, $x)
		. $s
		. mb_substr( $mm['map'][$y], $x + mb_strwidth($s) );
}


// }}}
// {{{ rank

function increase_positive_rank() { global $mm; rank($mm, +1,  0); }
function decrease_positive_rank() { global $mm; rank($mm, -1,  0); }
function increase_negative_rank() { global $mm; rank($mm,  0, +1); }
function decrease_negative_rank() { global $mm; rank($mm,  0, -1); }

function rank(&$mm, $add_positive, $add_negative)
{

	$negative = 0;
	$positive = 0;
	$existing = [];

	if (mb_ereg('^\((\d+)\+,(\d+)\-\)', $mm['nodes'][ $mm['active_node'] ]['title'], $existing))
	{
		$positive = $existing[1];
		$negative = $existing[2];
		$mm['nodes'][ $mm['active_node'] ]['title'] =
			mb_ereg_replace('^\(\d+\+,\d+\-\) *', '', $mm['nodes'][ $mm['active_node'] ]['title']);
	}

	$negative = max(0, $negative + $add_negative);
	$positive = max(0, $positive + $add_positive);

	$mm['nodes'][ $mm['active_node'] ]['title'] =
		"({$positive}+,{$negative}-) "
		.$mm['nodes'][ $mm['active_node'] ]['title']
	;

	push_change($mm);
	build_map($mm);
	display($mm);
}


// }}}
// {{{ open link

function open_link()
{
	global $mm;
	message($mm,'Opening the node with xdg-open...');
	exec('xdg-open "'.$mm['nodes'][ $mm['active_node'] ]['title'].'" >/dev/null 2>&1 &', $output, $result);
	display($mm);
}


// }}}
// {{{ sort

function sort_siblings()
{
	global $mm;

	if ($mm['active_node'] <= $mm['root_id'])
		return;

	$siblings = [];
	$sibling_ids = $mm['nodes'][ $mm['nodes'][ $mm['active_node'] ]['parent'] ]['children'];

	if (empty($sibling_ids))
		return;

	foreach ($sibling_ids as $sid)
		if (mb_ereg('^\((\d+)\+,(\d+)\-\)', $mm['nodes'][$sid]['title'], $values))
			$siblings
			[
				(9000000 - $values[1] + $values[2])
				.'.'
				.$sid 
			]
			= $sid;
		else
			$siblings
			[
				mb_ereg_replace
				(
					'^\[HIDDEN\] |^'.$mm['symbol1'].' |^'.$mm['symbol2'].' '
					,''
					,$mm['nodes'][$sid]['title']
				)
				.'.'
				.$sid
			] 
			= $sid;

	ksort($siblings, SORT_NATURAL);

	$mm['nodes'][ $mm['nodes'][ $mm['active_node'] ]['parent'] ]['children'] = $siblings;

	push_change($mm);
	build_map($mm);
	display($mm);
}


// }}}
// {{{ monitor key presses

function monitor_key_presses(&$mm)
{
	global $keybindings;
	stream_set_blocking(STDIN,false);

	while(true)
	{
		usleep(20000);
		$in = fread(STDIN, 16);

		if (empty($in))
			continue;

		if (isset($keybindings[$in]))
			call_user_func($keybindings[$in]);

		if ($mm['echo_keys'])
		{
			echo "\033[1;1f";
			for ($i=0; $i<strlen($in); $i++)
			  echo base_convert(ord($in[$i]),10,8).' ';
			echo '                    ';
		}
	}
}

// }}}
// {{{ change window title

function change_window_title($title)
{
	echo "\033]2;".( $title == '' ? ' ' : 'h-m-m -- '.str_replace('.hmm','',basename($title)) )."\007";
}


// }}}
// {{{ main

check_required_extensions();
check_the_available_clipboard_tool($mm);

enable_alternate_screen();
load_file($mm);

collapse_all($mm);
collapse_level($mm, $mm['initial_depth'], false);

$mm['show_logo'] = false;
monitor_key_presses($mm);

// }}}