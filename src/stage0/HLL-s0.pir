# $Id$

=head1 NAME

HLL - Parrot HLL library

=head1 DESCRIPTION

This file brings together the various modules needed for HLL::Compiler
and HLL::Grammar.

=over 4

=cut

.HLL 'nqp'
.loadlib "nqp_group"
.loadlib "nqp_ops"

.sub '' :anon :load :init
    load_bytecode 'Regex.pbc'
.end

.include 'cclass.pasm'
### .include 'src/Regex/constants.pir'
.const int CURSOR_FAIL = -1
.const int CURSOR_FAIL_GROUP = -2
.const int CURSOR_FAIL_RULE = -3
.const int CURSOR_FAIL_MATCH = -4

.const int CURSOR_TYPE_SCAN = 1
.const int CURSOR_TYPE_PEEK = 2
### .include 'src/cheats/hll-compiler.pir'
# This sub serves as a cumulative "outer context" for code
# executed in HLL::Compiler's interactive REPL.  It's invoked
# exactly once upon load/init to obtain a context, and its
# default LexPad is replaced with a Hash that we can use to
# cumulatively store outer context information.  Both the
# context and hash are then made available via package
# variables.
.namespace []
.sub '&interactive_outer' :lex :init :load
    .local pmc ctx, pad
    $P0 = getinterp
    ctx = $P0['context']
    set_global ['HLL';'Compiler'], '$interactive_ctx', ctx
    pad = getattribute ctx, 'lex_pad'
    $P1 = new ['Hash']
    copy pad, $P1
    set_global ['HLL';'Compiler'], '%interactive_pad', pad
.end
### .include 'src/cheats/parrot-callcontext.pir'
# This adds to a Parrot PMC, so need to switch to that HLL for this
# file.
.HLL 'parrot'
.namespace ['CallContext']
.sub 'lexpad_full' :method
    .local pmc ctx, lexall, lexpad, lexpad_it
    ctx = self
    lexall = root_new ['parrot';'Hash']

  context_loop:
    if null ctx goto context_done
    lexpad = getattribute ctx, 'lex_pad'
    if null lexpad goto lexpad_done
    lexpad_it = iter lexpad
  lexpad_loop:
    unless lexpad_it goto lexpad_done
    $S0 = shift lexpad_it
    $I0 = exists lexall[$S0]
    if $I0 goto lexpad_loop
    $P0 = lexpad[$S0]
    lexall[$S0] = $P0
    goto lexpad_loop
  lexpad_done:
    ctx = getattribute ctx, 'outer_ctx'
    goto context_loop
  context_done:
    .return (lexall)
.end
.HLL 'nqp'
### .include 'gen/hllgrammar-grammar.pir'

.HLL "nqp"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.namespace []
.sub "_block11"  :anon :subid("10_1299602516.087")
.annotate 'line', 0
    get_hll_global $P18, ["HLL";"Grammar"], "_block17" 
    capture_lex $P18
.annotate 'line', 1
    getinterp $P13
    get_class $P14, "LexPad"
    get_class $P15, "NQPLexPad"
    $P13."hll_map"($P14, $P15)
    get_hll_global $P16, ["HLL"], "Grammar"
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
.annotate 'line', 3
    get_hll_global $P18, ["HLL";"Grammar"], "_block17" 
    capture_lex $P18
    $P684 = $P18()
.annotate 'line', 1
    .return ($P684)
    .const 'Sub' $P686 = "121_1299602516.087" 
    .return ($P686)
.end


.HLL "nqp"

.namespace []
.sub "" :load :init :subid("post122") :outer("10_1299602516.087")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1299602516.087" 
    .local pmc block
    set block, $P12
    nqp_get_sc $P690, "1299602513.563"
    isnull $I691, $P690
    if $I691, if_689
    goto if_689_end
  if_689:
    nqp_dynop_setup 
    load_bytecode "nqpmo.pbc"
    nqp_create_sc $P692, "1299602513.563"
    .local pmc cur_sc
    set cur_sc, $P692
    load_bytecode "SettingManager.pbc"
    get_hll_global $P693, ["HLL"], "SettingManager"
    $P694 = $P693."load_setting"("NQPCORE")
    block."set_outer_ctx"($P694)
    get_hll_global $P695, "NQPClassHOW"
    $P696 = $P695."new_type"("HLL::Grammar" :named("name"))
    nqp_set_sc_for_object $P696, cur_sc
    nqp_set_sc_object "1299602513.563", 0, $P696
  if_689_end:
.end


.HLL "nqp"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.namespace ["HLL";"Grammar"]
.sub "_block17"  :subid("11_1299602516.087") :outer("10_1299602516.087")
.annotate 'line', 3
    .const 'Sub' $P472 = "120_1299602516.087" 
    capture_lex $P472
    .const 'Sub' $P439 = "118_1299602516.087" 
    capture_lex $P439
    .const 'Sub' $P434 = "117_1299602516.087" 
    capture_lex $P434
    .const 'Sub' $P419 = "116_1299602516.087" 
    capture_lex $P419
    .const 'Sub' $P409 = "115_1299602516.087" 
    capture_lex $P409
    .const 'Sub' $P405 = "114_1299602516.087" 
    capture_lex $P405
    .const 'Sub' $P401 = "113_1299602516.087" 
    capture_lex $P401
    .const 'Sub' $P398 = "112_1299602516.087" 
    capture_lex $P398
    .const 'Sub' $P396 = "111_1299602516.087" 
    capture_lex $P396
    .const 'Sub' $P394 = "110_1299602516.087" 
    capture_lex $P394
    .const 'Sub' $P388 = "109_1299602516.087" 
    capture_lex $P388
    .const 'Sub' $P385 = "108_1299602516.087" 
    capture_lex $P385
    .const 'Sub' $P381 = "107_1299602516.087" 
    capture_lex $P381
    .const 'Sub' $P353 = "106_1299602516.087" 
    capture_lex $P353
    .const 'Sub' $P348 = "105_1299602516.087" 
    capture_lex $P348
    .const 'Sub' $P339 = "103_1299602516.087" 
    capture_lex $P339
    .const 'Sub' $P333 = "101_1299602516.087" 
    capture_lex $P333
    .const 'Sub' $P320 = "98_1299602516.087" 
    capture_lex $P320
    .const 'Sub' $P288 = "93_1299602516.087" 
    capture_lex $P288
    .const 'Sub' $P282 = "91_1299602516.087" 
    capture_lex $P282
    .const 'Sub' $P277 = "89_1299602516.087" 
    capture_lex $P277
    .const 'Sub' $P271 = "87_1299602516.087" 
    capture_lex $P271
    .const 'Sub' $P265 = "85_1299602516.087" 
    capture_lex $P265
    .const 'Sub' $P260 = "83_1299602516.087" 
    capture_lex $P260
    .const 'Sub' $P255 = "81_1299602516.087" 
    capture_lex $P255
    .const 'Sub' $P250 = "79_1299602516.087" 
    capture_lex $P250
    .const 'Sub' $P245 = "77_1299602516.087" 
    capture_lex $P245
    .const 'Sub' $P240 = "75_1299602516.087" 
    capture_lex $P240
    .const 'Sub' $P235 = "73_1299602516.087" 
    capture_lex $P235
    .const 'Sub' $P230 = "71_1299602516.087" 
    capture_lex $P230
    .const 'Sub' $P225 = "69_1299602516.087" 
    capture_lex $P225
    .const 'Sub' $P213 = "65_1299602516.087" 
    capture_lex $P213
    .const 'Sub' $P200 = "63_1299602516.087" 
    capture_lex $P200
    .const 'Sub' $P188 = "61_1299602516.087" 
    capture_lex $P188
    .const 'Sub' $P182 = "59_1299602516.087" 
    capture_lex $P182
    .const 'Sub' $P175 = "57_1299602516.087" 
    capture_lex $P175
    .const 'Sub' $P169 = "55_1299602516.087" 
    capture_lex $P169
    .const 'Sub' $P162 = "53_1299602516.087" 
    capture_lex $P162
    .const 'Sub' $P156 = "51_1299602516.087" 
    capture_lex $P156
    .const 'Sub' $P149 = "49_1299602516.087" 
    capture_lex $P149
    .const 'Sub' $P143 = "47_1299602516.087" 
    capture_lex $P143
    .const 'Sub' $P137 = "45_1299602516.087" 
    capture_lex $P137
    .const 'Sub' $P128 = "43_1299602516.087" 
    capture_lex $P128
    .const 'Sub' $P120 = "41_1299602516.087" 
    capture_lex $P120
    .const 'Sub' $P112 = "40_1299602516.087" 
    capture_lex $P112
    .const 'Sub' $P106 = "38_1299602516.087" 
    capture_lex $P106
    .const 'Sub' $P101 = "36_1299602516.087" 
    capture_lex $P101
    .const 'Sub' $P93 = "34_1299602516.087" 
    capture_lex $P93
    .const 'Sub' $P87 = "32_1299602516.087" 
    capture_lex $P87
    .const 'Sub' $P81 = "30_1299602516.087" 
    capture_lex $P81
    .const 'Sub' $P75 = "28_1299602516.087" 
    capture_lex $P75
    .const 'Sub' $P30 = "14_1299602516.087" 
    capture_lex $P30
    .const 'Sub' $P23 = "12_1299602516.087" 
    capture_lex $P23
    get_global $P19, "$?CLASS"
    getinterp $P20
    get_class $P21, "LexPad"
    get_class $P22, "NQPLexPad"
    $P20."hll_map"($P21, $P22)
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
.annotate 'line', 832
    .const 'Sub' $P439 = "118_1299602516.087" 
    newclosure $P458, $P439
.annotate 'line', 3
    .return ($P458)
    .const 'Sub' $P460 = "119_1299602516.087" 
    .return ($P460)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "" :load :init :subid("post123") :outer("11_1299602516.087")
.annotate 'line', 3
    get_hll_global $P18, ["HLL";"Grammar"], "_block17" 
    .local pmc block
    set block, $P18
    nqp_get_sc $P464, "1299602513.563"
    isnull $I465, $P464
    if $I465, if_463
    goto if_463_end
  if_463:
    nqp_dynop_setup 
    load_bytecode "nqpmo.pbc"
    nqp_create_sc $P466, "1299602513.563"
    .local pmc cur_sc
    set cur_sc, $P466
    load_bytecode "SettingManager.pbc"
    get_hll_global $P467, ["HLL"], "SettingManager"
    $P468 = $P467."load_setting"("NQPCORE")
    block."set_outer_ctx"($P468)
    get_hll_global $P469, "NQPClassHOW"
    $P470 = $P469."new_type"("HLL::Grammar" :named("name"))
    nqp_set_sc_for_object $P470, cur_sc
    nqp_set_sc_object "1299602513.563", 0, $P470
  if_463_end:
    .const 'Sub' $P472 = "120_1299602516.087" 
    capture_lex $P472
    $P472()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "_block471"  :anon :subid("120_1299602516.087") :outer("11_1299602516.087")
.annotate 'line', 3
    nqp_get_sc_object $P473, "1299602513.563", 0
    .local pmc type_obj
    set type_obj, $P473
    set_hll_global ["HLL"], "Grammar", type_obj
    set_global "$?CLASS", type_obj
    get_how $P474, type_obj
    .const 'Sub' $P475 = "12_1299602516.087" 
    $P474."add_method"(type_obj, "ws", $P475)
    get_how $P476, type_obj
    get_global $P477, "!PREFIX__ws"
    $P476."add_method"(type_obj, "!PREFIX__ws", $P477)
    get_how $P478, type_obj
    .const 'Sub' $P479 = "14_1299602516.087" 
    $P478."add_method"(type_obj, "termish", $P479)
    get_how $P480, type_obj
    get_global $P481, "!PREFIX__termish"
    $P480."add_method"(type_obj, "!PREFIX__termish", $P481)
    get_how $P482, type_obj
    .const 'Sub' $P483 = "16_1299602516.087" 
    $P482."add_method"(type_obj, "term", $P483)
    get_how $P484, type_obj
    .const 'Sub' $P485 = "17_1299602516.087" 
    $P484."add_method"(type_obj, "!PREFIX__term", $P485)
    get_how $P486, type_obj
    .const 'Sub' $P487 = "18_1299602516.087" 
    $P486."add_method"(type_obj, "infix", $P487)
    get_how $P488, type_obj
    .const 'Sub' $P489 = "19_1299602516.087" 
    $P488."add_method"(type_obj, "!PREFIX__infix", $P489)
    get_how $P490, type_obj
    .const 'Sub' $P491 = "20_1299602516.087" 
    $P490."add_method"(type_obj, "prefix", $P491)
    get_how $P492, type_obj
    .const 'Sub' $P493 = "21_1299602516.087" 
    $P492."add_method"(type_obj, "!PREFIX__prefix", $P493)
    get_how $P494, type_obj
    .const 'Sub' $P495 = "22_1299602516.087" 
    $P494."add_method"(type_obj, "postfix", $P495)
    get_how $P496, type_obj
    .const 'Sub' $P497 = "23_1299602516.087" 
    $P496."add_method"(type_obj, "!PREFIX__postfix", $P497)
    get_how $P498, type_obj
    .const 'Sub' $P499 = "24_1299602516.087" 
    $P498."add_method"(type_obj, "circumfix", $P499)
    get_how $P500, type_obj
    .const 'Sub' $P501 = "25_1299602516.087" 
    $P500."add_method"(type_obj, "!PREFIX__circumfix", $P501)
    get_how $P502, type_obj
    .const 'Sub' $P503 = "26_1299602516.087" 
    $P502."add_method"(type_obj, "postcircumfix", $P503)
    get_how $P504, type_obj
    .const 'Sub' $P505 = "27_1299602516.087" 
    $P504."add_method"(type_obj, "!PREFIX__postcircumfix", $P505)
    get_how $P506, type_obj
    .const 'Sub' $P507 = "28_1299602516.087" 
    $P506."add_method"(type_obj, "term:sym<circumfix>", $P507)
    get_how $P508, type_obj
    get_global $P509, "!PREFIX__term:sym<circumfix>"
    $P508."add_method"(type_obj, "!PREFIX__term:sym<circumfix>", $P509)
    get_how $P510, type_obj
    .const 'Sub' $P511 = "30_1299602516.087" 
    $P510."add_method"(type_obj, "infixish", $P511)
    get_how $P512, type_obj
    get_global $P513, "!PREFIX__infixish"
    $P512."add_method"(type_obj, "!PREFIX__infixish", $P513)
    get_how $P514, type_obj
    .const 'Sub' $P515 = "32_1299602516.087" 
    $P514."add_method"(type_obj, "prefixish", $P515)
    get_how $P516, type_obj
    get_global $P517, "!PREFIX__prefixish"
    $P516."add_method"(type_obj, "!PREFIX__prefixish", $P517)
    get_how $P518, type_obj
    .const 'Sub' $P519 = "34_1299602516.087" 
    $P518."add_method"(type_obj, "postfixish", $P519)
    get_how $P520, type_obj
    get_global $P521, "!PREFIX__postfixish"
    $P520."add_method"(type_obj, "!PREFIX__postfixish", $P521)
    get_how $P522, type_obj
    .const 'Sub' $P523 = "36_1299602516.087" 
    $P522."add_method"(type_obj, "nullterm", $P523)
    get_how $P524, type_obj
    get_global $P525, "!PREFIX__nullterm"
    $P524."add_method"(type_obj, "!PREFIX__nullterm", $P525)
    get_how $P526, type_obj
    .const 'Sub' $P527 = "38_1299602516.087" 
    $P526."add_method"(type_obj, "nullterm_alt", $P527)
    get_how $P528, type_obj
    get_global $P529, "!PREFIX__nullterm_alt"
    $P528."add_method"(type_obj, "!PREFIX__nullterm_alt", $P529)
    get_how $P530, type_obj
    .const 'Sub' $P531 = "40_1299602516.087" 
    $P530."add_method"(type_obj, "nulltermish", $P531)
    get_how $P532, type_obj
    .const 'Sub' $P533 = "41_1299602516.087" 
    $P532."add_method"(type_obj, "quote_delimited", $P533)
    get_how $P534, type_obj
    get_global $P535, "!PREFIX__quote_delimited"
    $P534."add_method"(type_obj, "!PREFIX__quote_delimited", $P535)
    get_how $P536, type_obj
    .const 'Sub' $P537 = "43_1299602516.087" 
    $P536."add_method"(type_obj, "quote_atom", $P537)
    get_how $P538, type_obj
    get_global $P539, "!PREFIX__quote_atom"
    $P538."add_method"(type_obj, "!PREFIX__quote_atom", $P539)
    get_how $P540, type_obj
    .const 'Sub' $P541 = "45_1299602516.087" 
    $P540."add_method"(type_obj, "decint", $P541)
    get_how $P542, type_obj
    get_global $P543, "!PREFIX__decint"
    $P542."add_method"(type_obj, "!PREFIX__decint", $P543)
    get_how $P544, type_obj
    .const 'Sub' $P545 = "47_1299602516.087" 
    $P544."add_method"(type_obj, "decints", $P545)
    get_how $P546, type_obj
    get_global $P547, "!PREFIX__decints"
    $P546."add_method"(type_obj, "!PREFIX__decints", $P547)
    get_how $P548, type_obj
    .const 'Sub' $P549 = "49_1299602516.087" 
    $P548."add_method"(type_obj, "hexint", $P549)
    get_how $P550, type_obj
    get_global $P551, "!PREFIX__hexint"
    $P550."add_method"(type_obj, "!PREFIX__hexint", $P551)
    get_how $P552, type_obj
    .const 'Sub' $P553 = "51_1299602516.087" 
    $P552."add_method"(type_obj, "hexints", $P553)
    get_how $P554, type_obj
    get_global $P555, "!PREFIX__hexints"
    $P554."add_method"(type_obj, "!PREFIX__hexints", $P555)
    get_how $P556, type_obj
    .const 'Sub' $P557 = "53_1299602516.087" 
    $P556."add_method"(type_obj, "octint", $P557)
    get_how $P558, type_obj
    get_global $P559, "!PREFIX__octint"
    $P558."add_method"(type_obj, "!PREFIX__octint", $P559)
    get_how $P560, type_obj
    .const 'Sub' $P561 = "55_1299602516.087" 
    $P560."add_method"(type_obj, "octints", $P561)
    get_how $P562, type_obj
    get_global $P563, "!PREFIX__octints"
    $P562."add_method"(type_obj, "!PREFIX__octints", $P563)
    get_how $P564, type_obj
    .const 'Sub' $P565 = "57_1299602516.087" 
    $P564."add_method"(type_obj, "binint", $P565)
    get_how $P566, type_obj
    get_global $P567, "!PREFIX__binint"
    $P566."add_method"(type_obj, "!PREFIX__binint", $P567)
    get_how $P568, type_obj
    .const 'Sub' $P569 = "59_1299602516.087" 
    $P568."add_method"(type_obj, "binints", $P569)
    get_how $P570, type_obj
    get_global $P571, "!PREFIX__binints"
    $P570."add_method"(type_obj, "!PREFIX__binints", $P571)
    get_how $P572, type_obj
    .const 'Sub' $P573 = "61_1299602516.087" 
    $P572."add_method"(type_obj, "integer", $P573)
    get_how $P574, type_obj
    get_global $P575, "!PREFIX__integer"
    $P574."add_method"(type_obj, "!PREFIX__integer", $P575)
    get_how $P576, type_obj
    .const 'Sub' $P577 = "63_1299602516.087" 
    $P576."add_method"(type_obj, "dec_number", $P577)
    get_how $P578, type_obj
    get_global $P579, "!PREFIX__dec_number"
    $P578."add_method"(type_obj, "!PREFIX__dec_number", $P579)
    get_how $P580, type_obj
    .const 'Sub' $P581 = "65_1299602516.087" 
    $P580."add_method"(type_obj, "escale", $P581)
    get_how $P582, type_obj
    get_global $P583, "!PREFIX__escale"
    $P582."add_method"(type_obj, "!PREFIX__escale", $P583)
    get_how $P584, type_obj
    .const 'Sub' $P585 = "67_1299602516.087" 
    $P584."add_method"(type_obj, "quote_escape", $P585)
    get_how $P586, type_obj
    .const 'Sub' $P587 = "68_1299602516.087" 
    $P586."add_method"(type_obj, "!PREFIX__quote_escape", $P587)
    get_how $P588, type_obj
    .const 'Sub' $P589 = "69_1299602516.087" 
    $P588."add_method"(type_obj, "quote_escape:sym<backslash>", $P589)
    get_how $P590, type_obj
    get_global $P591, "!PREFIX__quote_escape:sym<backslash>"
    $P590."add_method"(type_obj, "!PREFIX__quote_escape:sym<backslash>", $P591)
    get_how $P592, type_obj
    .const 'Sub' $P593 = "71_1299602516.087" 
    $P592."add_method"(type_obj, "quote_escape:sym<stopper>", $P593)
    get_how $P594, type_obj
    get_global $P595, "!PREFIX__quote_escape:sym<stopper>"
    $P594."add_method"(type_obj, "!PREFIX__quote_escape:sym<stopper>", $P595)
    get_how $P596, type_obj
    .const 'Sub' $P597 = "73_1299602516.087" 
    $P596."add_method"(type_obj, "quote_escape:sym<bs>", $P597)
    get_how $P598, type_obj
    get_global $P599, "!PREFIX__quote_escape:sym<bs>"
    $P598."add_method"(type_obj, "!PREFIX__quote_escape:sym<bs>", $P599)
    get_how $P600, type_obj
    .const 'Sub' $P601 = "75_1299602516.087" 
    $P600."add_method"(type_obj, "quote_escape:sym<nl>", $P601)
    get_how $P602, type_obj
    get_global $P603, "!PREFIX__quote_escape:sym<nl>"
    $P602."add_method"(type_obj, "!PREFIX__quote_escape:sym<nl>", $P603)
    get_how $P604, type_obj
    .const 'Sub' $P605 = "77_1299602516.087" 
    $P604."add_method"(type_obj, "quote_escape:sym<cr>", $P605)
    get_how $P606, type_obj
    get_global $P607, "!PREFIX__quote_escape:sym<cr>"
    $P606."add_method"(type_obj, "!PREFIX__quote_escape:sym<cr>", $P607)
    get_how $P608, type_obj
    .const 'Sub' $P609 = "79_1299602516.087" 
    $P608."add_method"(type_obj, "quote_escape:sym<tab>", $P609)
    get_how $P610, type_obj
    get_global $P611, "!PREFIX__quote_escape:sym<tab>"
    $P610."add_method"(type_obj, "!PREFIX__quote_escape:sym<tab>", $P611)
    get_how $P612, type_obj
    .const 'Sub' $P613 = "81_1299602516.087" 
    $P612."add_method"(type_obj, "quote_escape:sym<ff>", $P613)
    get_how $P614, type_obj
    get_global $P615, "!PREFIX__quote_escape:sym<ff>"
    $P614."add_method"(type_obj, "!PREFIX__quote_escape:sym<ff>", $P615)
    get_how $P616, type_obj
    .const 'Sub' $P617 = "83_1299602516.087" 
    $P616."add_method"(type_obj, "quote_escape:sym<esc>", $P617)
    get_how $P618, type_obj
    get_global $P619, "!PREFIX__quote_escape:sym<esc>"
    $P618."add_method"(type_obj, "!PREFIX__quote_escape:sym<esc>", $P619)
    get_how $P620, type_obj
    .const 'Sub' $P621 = "85_1299602516.087" 
    $P620."add_method"(type_obj, "quote_escape:sym<hex>", $P621)
    get_how $P622, type_obj
    get_global $P623, "!PREFIX__quote_escape:sym<hex>"
    $P622."add_method"(type_obj, "!PREFIX__quote_escape:sym<hex>", $P623)
    get_how $P624, type_obj
    .const 'Sub' $P625 = "87_1299602516.087" 
    $P624."add_method"(type_obj, "quote_escape:sym<oct>", $P625)
    get_how $P626, type_obj
    get_global $P627, "!PREFIX__quote_escape:sym<oct>"
    $P626."add_method"(type_obj, "!PREFIX__quote_escape:sym<oct>", $P627)
    get_how $P628, type_obj
    .const 'Sub' $P629 = "89_1299602516.087" 
    $P628."add_method"(type_obj, "quote_escape:sym<chr>", $P629)
    get_how $P630, type_obj
    get_global $P631, "!PREFIX__quote_escape:sym<chr>"
    $P630."add_method"(type_obj, "!PREFIX__quote_escape:sym<chr>", $P631)
    get_how $P632, type_obj
    .const 'Sub' $P633 = "91_1299602516.087" 
    $P632."add_method"(type_obj, "quote_escape:sym<0>", $P633)
    get_how $P634, type_obj
    get_global $P635, "!PREFIX__quote_escape:sym<0>"
    $P634."add_method"(type_obj, "!PREFIX__quote_escape:sym<0>", $P635)
    get_how $P636, type_obj
    .const 'Sub' $P637 = "93_1299602516.087" 
    $P636."add_method"(type_obj, "quote_escape:sym<misc>", $P637)
    get_how $P638, type_obj
    get_global $P639, "!PREFIX__quote_escape:sym<misc>"
    $P638."add_method"(type_obj, "!PREFIX__quote_escape:sym<misc>", $P639)
    get_how $P640, type_obj
    .const 'Sub' $P641 = "98_1299602516.087" 
    $P640."add_method"(type_obj, "charname", $P641)
    get_how $P642, type_obj
    get_global $P643, "!PREFIX__charname"
    $P642."add_method"(type_obj, "!PREFIX__charname", $P643)
    get_how $P644, type_obj
    .const 'Sub' $P645 = "101_1299602516.087" 
    $P644."add_method"(type_obj, "charnames", $P645)
    get_how $P646, type_obj
    get_global $P647, "!PREFIX__charnames"
    $P646."add_method"(type_obj, "!PREFIX__charnames", $P647)
    get_how $P648, type_obj
    .const 'Sub' $P649 = "103_1299602516.087" 
    $P648."add_method"(type_obj, "charspec", $P649)
    get_how $P650, type_obj
    get_global $P651, "!PREFIX__charspec"
    $P650."add_method"(type_obj, "!PREFIX__charspec", $P651)
    get_how $P652, type_obj
    .const 'Sub' $P653 = "105_1299602516.087" 
    $P652."add_method"(type_obj, "O", $P653)
    get_how $P654, type_obj
    .const 'Sub' $P655 = "106_1299602516.087" 
    $P654."add_method"(type_obj, "panic", $P655)
    get_how $P656, type_obj
    .const 'Sub' $P657 = "107_1299602516.087" 
    $P656."add_method"(type_obj, "peek_delimiters", $P657)
    get_how $P658, type_obj
    .const 'Sub' $P659 = "108_1299602516.087" 
    $P658."add_method"(type_obj, "quote_EXPR", $P659)
    get_how $P660, type_obj
    .const 'Sub' $P661 = "109_1299602516.087" 
    $P660."add_method"(type_obj, "quotemod_check", $P661)
    get_how $P662, type_obj
    .const 'Sub' $P663 = "110_1299602516.087" 
    $P662."add_method"(type_obj, "starter", $P663)
    get_how $P664, type_obj
    .const 'Sub' $P665 = "111_1299602516.087" 
    $P664."add_method"(type_obj, "stopper", $P665)
    get_how $P666, type_obj
    .const 'Sub' $P667 = "112_1299602516.087" 
    $P666."add_method"(type_obj, "split_words", $P667)
    get_how $P668, type_obj
    .const 'Sub' $P669 = "113_1299602516.087" 
    $P668."add_method"(type_obj, "EXPR", $P669)
    get_how $P670, type_obj
    .const 'Sub' $P671 = "114_1299602516.087" 
    $P670."add_method"(type_obj, "EXPR_reduce", $P671)
    get_how $P672, type_obj
    .const 'Sub' $P673 = "115_1299602516.087" 
    $P672."add_method"(type_obj, "ternary", $P673)
    get_how $P674, type_obj
    .const 'Sub' $P675 = "116_1299602516.087" 
    $P674."add_method"(type_obj, "MARKER", $P675)
    get_how $P676, type_obj
    .const 'Sub' $P677 = "117_1299602516.087" 
    $P676."add_method"(type_obj, "MARKED", $P677)
    get_how $P678, type_obj
    .const 'Sub' $P679 = "118_1299602516.087" 
    $P678."add_method"(type_obj, "LANG", $P679)
    get_how $P680, type_obj
    get_hll_global $P681, ["Regex"], "Cursor"
    $P680."add_parent"(type_obj, $P681)
    get_how $P682, type_obj
    $P683 = $P682."compose"(type_obj)
    .return ($P683)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "ws"  :subid("12_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx24_tgt
    .local int rx24_pos
    .local int rx24_off
    .local int rx24_eos
    .local int rx24_rep
    .local pmc rx24_cur
    .local pmc rx24_debug
    (rx24_cur, rx24_pos, rx24_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx24_cur
    .local pmc match
    .lex "$/", match
    length rx24_eos, rx24_tgt
    gt rx24_pos, rx24_eos, rx24_done
    set rx24_off, 0
    lt rx24_pos, 2, rx24_start
    sub rx24_off, rx24_pos, 1
    substr rx24_tgt, rx24_tgt, rx24_off
  rx24_start:
    eq $I10, 1, rx24_restart
    if_null rx24_debug, debug_124
    rx24_cur."!cursor_debug"("START", "ws")
  debug_124:
    $I10 = self.'from'()
    ne $I10, -1, rxscan27_done
    goto rxscan27_scan
  rxscan27_loop:
    (rx24_pos) = rx24_cur."from"()
    inc rx24_pos
    rx24_cur."!cursor_from"(rx24_pos)
    ge rx24_pos, rx24_eos, rxscan27_done
  rxscan27_scan:
    set_addr $I10, rxscan27_loop
    rx24_cur."!mark_push"(0, rx24_pos, $I10)
  rxscan27_done:
  # rx subrule "ww" subtype=zerowidth negate=1
    rx24_cur."!cursor_pos"(rx24_pos)
    $P10 = rx24_cur."ww"()
    if $P10, rx24_fail
  # rx rxquantr28 ** 0..*
    set_addr $I10, rxquantr28_done
    rx24_cur."!mark_push"(0, rx24_pos, $I10)
  rxquantr28_loop:
  alt29_0:
    set_addr $I10, alt29_1
    rx24_cur."!mark_push"(0, rx24_pos, $I10)
  # rx charclass_q s r 1..-1
    sub $I10, rx24_pos, rx24_off
    find_not_cclass $I11, 32, rx24_tgt, $I10, rx24_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx24_fail
    add rx24_pos, rx24_off, $I11
    goto alt29_end
  alt29_1:
  # rx literal  "#"
    add $I11, rx24_pos, 1
    gt $I11, rx24_eos, rx24_fail
    sub $I11, rx24_pos, rx24_off
    ord $I11, rx24_tgt, $I11
    ne $I11, 35, rx24_fail
    add rx24_pos, 1
  # rx charclass_q N r 0..-1
    sub $I10, rx24_pos, rx24_off
    find_cclass $I11, 4096, rx24_tgt, $I10, rx24_eos
    add rx24_pos, rx24_off, $I11
  alt29_end:
    set_addr $I10, rxquantr28_done
    (rx24_rep) = rx24_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr28_done
    rx24_cur."!mark_push"(rx24_rep, rx24_pos, $I10)
    goto rxquantr28_loop
  rxquantr28_done:
  # rx pass
    rx24_cur."!cursor_pass"(rx24_pos, "ws")
    if_null rx24_debug, debug_125
    rx24_cur."!cursor_debug"("PASS", "ws", " at pos=", rx24_pos)
  debug_125:
    .return (rx24_cur)
  rx24_restart:
    if_null rx24_debug, debug_126
    rx24_cur."!cursor_debug"("NEXT", "ws")
  debug_126:
  rx24_fail:
    (rx24_rep, rx24_pos, $I10, $P10) = rx24_cur."!mark_fail"(0)
    lt rx24_pos, -1, rx24_done
    eq rx24_pos, -1, rx24_fail
    jump $I10
  rx24_done:
    rx24_cur."!cursor_fail"()
    if_null rx24_debug, debug_127
    rx24_cur."!cursor_debug"("FAIL", "ws")
  debug_127:
    .return (rx24_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__ws"  :nsentry("!PREFIX__ws") :subid("13_1299602516.087") :method
.annotate 'line', 3
    new $P26, "ResizablePMCArray"
    push $P26, ""
    .return ($P26)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "termish"  :subid("14_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx31_tgt
    .local int rx31_pos
    .local int rx31_off
    .local int rx31_eos
    .local int rx31_rep
    .local pmc rx31_cur
    .local pmc rx31_debug
    (rx31_cur, rx31_pos, rx31_tgt, $I10) = self."!cursor_start"()
    rx31_cur."!cursor_caparray"("prefixish", "postfixish")
    .lex unicode:"$\x{a2}", rx31_cur
    .local pmc match
    .lex "$/", match
    length rx31_eos, rx31_tgt
    gt rx31_pos, rx31_eos, rx31_done
    set rx31_off, 0
    lt rx31_pos, 2, rx31_start
    sub rx31_off, rx31_pos, 1
    substr rx31_tgt, rx31_tgt, rx31_off
  rx31_start:
    eq $I10, 1, rx31_restart
    if_null rx31_debug, debug_128
    rx31_cur."!cursor_debug"("START", "termish")
  debug_128:
    $I10 = self.'from'()
    ne $I10, -1, rxscan34_done
    goto rxscan34_scan
  rxscan34_loop:
    (rx31_pos) = rx31_cur."from"()
    inc rx31_pos
    rx31_cur."!cursor_from"(rx31_pos)
    ge rx31_pos, rx31_eos, rxscan34_done
  rxscan34_scan:
    set_addr $I10, rxscan34_loop
    rx31_cur."!mark_push"(0, rx31_pos, $I10)
  rxscan34_done:
.annotate 'line', 6
  # rx rxquantr35 ** 0..*
    set_addr $I10, rxquantr35_done
    rx31_cur."!mark_push"(0, rx31_pos, $I10)
  rxquantr35_loop:
  # rx subrule "prefixish" subtype=capture negate=
    rx31_cur."!cursor_pos"(rx31_pos)
    $P10 = rx31_cur."prefixish"()
    unless $P10, rx31_fail
    goto rxsubrule36_pass
  rxsubrule36_back:
    $P10 = $P10."!cursor_next"()
    unless $P10, rx31_fail
  rxsubrule36_pass:
    set_addr $I10, rxsubrule36_back
    rx31_cur."!mark_push"(0, rx31_pos, $I10, $P10)
    $P10."!cursor_names"("prefixish")
    rx31_pos = $P10."pos"()
    set_addr $I10, rxquantr35_done
    (rx31_rep) = rx31_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr35_done
    rx31_cur."!mark_push"(rx31_rep, rx31_pos, $I10)
    goto rxquantr35_loop
  rxquantr35_done:
.annotate 'line', 7
  # rx subrule "term" subtype=capture negate=
    rx31_cur."!cursor_pos"(rx31_pos)
    $P10 = rx31_cur."term"()
    unless $P10, rx31_fail
    rx31_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("term")
    rx31_pos = $P10."pos"()
.annotate 'line', 8
  # rx rxquantr37 ** 0..*
    set_addr $I10, rxquantr37_done
    rx31_cur."!mark_push"(0, rx31_pos, $I10)
  rxquantr37_loop:
  # rx subrule "postfixish" subtype=capture negate=
    rx31_cur."!cursor_pos"(rx31_pos)
    $P10 = rx31_cur."postfixish"()
    unless $P10, rx31_fail
    goto rxsubrule38_pass
  rxsubrule38_back:
    $P10 = $P10."!cursor_next"()
    unless $P10, rx31_fail
  rxsubrule38_pass:
    set_addr $I10, rxsubrule38_back
    rx31_cur."!mark_push"(0, rx31_pos, $I10, $P10)
    $P10."!cursor_names"("postfixish")
    rx31_pos = $P10."pos"()
    set_addr $I10, rxquantr37_done
    (rx31_rep) = rx31_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr37_done
    rx31_cur."!mark_push"(rx31_rep, rx31_pos, $I10)
    goto rxquantr37_loop
  rxquantr37_done:
.annotate 'line', 5
  # rx pass
    rx31_cur."!cursor_pass"(rx31_pos, "termish")
    if_null rx31_debug, debug_129
    rx31_cur."!cursor_debug"("PASS", "termish", " at pos=", rx31_pos)
  debug_129:
    .return (rx31_cur)
  rx31_restart:
.annotate 'line', 3
    if_null rx31_debug, debug_130
    rx31_cur."!cursor_debug"("NEXT", "termish")
  debug_130:
  rx31_fail:
    (rx31_rep, rx31_pos, $I10, $P10) = rx31_cur."!mark_fail"(0)
    lt rx31_pos, -1, rx31_done
    eq rx31_pos, -1, rx31_fail
    jump $I10
  rx31_done:
    rx31_cur."!cursor_fail"()
    if_null rx31_debug, debug_131
    rx31_cur."!cursor_debug"("FAIL", "termish")
  debug_131:
    .return (rx31_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__termish"  :nsentry("!PREFIX__termish") :subid("15_1299602516.087") :method
.annotate 'line', 3
    new $P33, "ResizablePMCArray"
    push $P33, ""
    .return ($P33)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "term"  :subid("16_1299602516.087")
    .param pmc param_40
.annotate 'line', 11
    .lex "self", param_40
    $P41 = param_40."!protoregex"("term")
    .return ($P41)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__term"  :subid("17_1299602516.087")
    .param pmc param_43
.annotate 'line', 11
    .lex "self", param_43
    $P44 = param_43."!PREFIX__!protoregex"("term")
    .return ($P44)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "infix"  :subid("18_1299602516.087")
    .param pmc param_46
.annotate 'line', 12
    .lex "self", param_46
    $P47 = param_46."!protoregex"("infix")
    .return ($P47)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__infix"  :subid("19_1299602516.087")
    .param pmc param_49
.annotate 'line', 12
    .lex "self", param_49
    $P50 = param_49."!PREFIX__!protoregex"("infix")
    .return ($P50)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "prefix"  :subid("20_1299602516.087")
    .param pmc param_52
.annotate 'line', 13
    .lex "self", param_52
    $P53 = param_52."!protoregex"("prefix")
    .return ($P53)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__prefix"  :subid("21_1299602516.087")
    .param pmc param_55
.annotate 'line', 13
    .lex "self", param_55
    $P56 = param_55."!PREFIX__!protoregex"("prefix")
    .return ($P56)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "postfix"  :subid("22_1299602516.087")
    .param pmc param_58
.annotate 'line', 14
    .lex "self", param_58
    $P59 = param_58."!protoregex"("postfix")
    .return ($P59)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__postfix"  :subid("23_1299602516.087")
    .param pmc param_61
.annotate 'line', 14
    .lex "self", param_61
    $P62 = param_61."!PREFIX__!protoregex"("postfix")
    .return ($P62)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "circumfix"  :subid("24_1299602516.087")
    .param pmc param_64
.annotate 'line', 15
    .lex "self", param_64
    $P65 = param_64."!protoregex"("circumfix")
    .return ($P65)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__circumfix"  :subid("25_1299602516.087")
    .param pmc param_67
.annotate 'line', 15
    .lex "self", param_67
    $P68 = param_67."!PREFIX__!protoregex"("circumfix")
    .return ($P68)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "postcircumfix"  :subid("26_1299602516.087")
    .param pmc param_70
.annotate 'line', 16
    .lex "self", param_70
    $P71 = param_70."!protoregex"("postcircumfix")
    .return ($P71)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__postcircumfix"  :subid("27_1299602516.087")
    .param pmc param_73
.annotate 'line', 16
    .lex "self", param_73
    $P74 = param_73."!PREFIX__!protoregex"("postcircumfix")
    .return ($P74)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "term:sym<circumfix>"  :subid("28_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx76_tgt
    .local int rx76_pos
    .local int rx76_off
    .local int rx76_eos
    .local int rx76_rep
    .local pmc rx76_cur
    .local pmc rx76_debug
    (rx76_cur, rx76_pos, rx76_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx76_cur
    .local pmc match
    .lex "$/", match
    length rx76_eos, rx76_tgt
    gt rx76_pos, rx76_eos, rx76_done
    set rx76_off, 0
    lt rx76_pos, 2, rx76_start
    sub rx76_off, rx76_pos, 1
    substr rx76_tgt, rx76_tgt, rx76_off
  rx76_start:
    eq $I10, 1, rx76_restart
    if_null rx76_debug, debug_132
    rx76_cur."!cursor_debug"("START", "term:sym<circumfix>")
  debug_132:
    $I10 = self.'from'()
    ne $I10, -1, rxscan80_done
    goto rxscan80_scan
  rxscan80_loop:
    (rx76_pos) = rx76_cur."from"()
    inc rx76_pos
    rx76_cur."!cursor_from"(rx76_pos)
    ge rx76_pos, rx76_eos, rxscan80_done
  rxscan80_scan:
    set_addr $I10, rxscan80_loop
    rx76_cur."!mark_push"(0, rx76_pos, $I10)
  rxscan80_done:
.annotate 'line', 18
  # rx subrule "circumfix" subtype=capture negate=
    rx76_cur."!cursor_pos"(rx76_pos)
    $P10 = rx76_cur."circumfix"()
    unless $P10, rx76_fail
    rx76_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("circumfix")
    rx76_pos = $P10."pos"()
  # rx pass
    rx76_cur."!cursor_pass"(rx76_pos, "term:sym<circumfix>")
    if_null rx76_debug, debug_133
    rx76_cur."!cursor_debug"("PASS", "term:sym<circumfix>", " at pos=", rx76_pos)
  debug_133:
    .return (rx76_cur)
  rx76_restart:
.annotate 'line', 3
    if_null rx76_debug, debug_134
    rx76_cur."!cursor_debug"("NEXT", "term:sym<circumfix>")
  debug_134:
  rx76_fail:
    (rx76_rep, rx76_pos, $I10, $P10) = rx76_cur."!mark_fail"(0)
    lt rx76_pos, -1, rx76_done
    eq rx76_pos, -1, rx76_fail
    jump $I10
  rx76_done:
    rx76_cur."!cursor_fail"()
    if_null rx76_debug, debug_135
    rx76_cur."!cursor_debug"("FAIL", "term:sym<circumfix>")
  debug_135:
    .return (rx76_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__term:sym<circumfix>"  :nsentry("!PREFIX__term:sym<circumfix>") :subid("29_1299602516.087") :method
.annotate 'line', 3
    $P78 = self."!PREFIX__!subrule"("circumfix", "")
    new $P79, "ResizablePMCArray"
    push $P79, $P78
    .return ($P79)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "infixish"  :subid("30_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx82_tgt
    .local int rx82_pos
    .local int rx82_off
    .local int rx82_eos
    .local int rx82_rep
    .local pmc rx82_cur
    .local pmc rx82_debug
    (rx82_cur, rx82_pos, rx82_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx82_cur
    .local pmc match
    .lex "$/", match
    length rx82_eos, rx82_tgt
    gt rx82_pos, rx82_eos, rx82_done
    set rx82_off, 0
    lt rx82_pos, 2, rx82_start
    sub rx82_off, rx82_pos, 1
    substr rx82_tgt, rx82_tgt, rx82_off
  rx82_start:
    eq $I10, 1, rx82_restart
    if_null rx82_debug, debug_136
    rx82_cur."!cursor_debug"("START", "infixish")
  debug_136:
    $I10 = self.'from'()
    ne $I10, -1, rxscan86_done
    goto rxscan86_scan
  rxscan86_loop:
    (rx82_pos) = rx82_cur."from"()
    inc rx82_pos
    rx82_cur."!cursor_from"(rx82_pos)
    ge rx82_pos, rx82_eos, rxscan86_done
  rxscan86_scan:
    set_addr $I10, rxscan86_loop
    rx82_cur."!mark_push"(0, rx82_pos, $I10)
  rxscan86_done:
.annotate 'line', 20
  # rx subrule "infix" subtype=capture negate=
    rx82_cur."!cursor_pos"(rx82_pos)
    $P10 = rx82_cur."infix"()
    unless $P10, rx82_fail
    rx82_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("OPER=infix")
    rx82_pos = $P10."pos"()
  # rx pass
    rx82_cur."!cursor_pass"(rx82_pos, "infixish")
    if_null rx82_debug, debug_137
    rx82_cur."!cursor_debug"("PASS", "infixish", " at pos=", rx82_pos)
  debug_137:
    .return (rx82_cur)
  rx82_restart:
.annotate 'line', 3
    if_null rx82_debug, debug_138
    rx82_cur."!cursor_debug"("NEXT", "infixish")
  debug_138:
  rx82_fail:
    (rx82_rep, rx82_pos, $I10, $P10) = rx82_cur."!mark_fail"(0)
    lt rx82_pos, -1, rx82_done
    eq rx82_pos, -1, rx82_fail
    jump $I10
  rx82_done:
    rx82_cur."!cursor_fail"()
    if_null rx82_debug, debug_139
    rx82_cur."!cursor_debug"("FAIL", "infixish")
  debug_139:
    .return (rx82_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__infixish"  :nsentry("!PREFIX__infixish") :subid("31_1299602516.087") :method
.annotate 'line', 3
    $P84 = self."!PREFIX__!subrule"("infix", "")
    new $P85, "ResizablePMCArray"
    push $P85, $P84
    .return ($P85)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "prefixish"  :subid("32_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx88_tgt
    .local int rx88_pos
    .local int rx88_off
    .local int rx88_eos
    .local int rx88_rep
    .local pmc rx88_cur
    .local pmc rx88_debug
    (rx88_cur, rx88_pos, rx88_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx88_cur
    .local pmc match
    .lex "$/", match
    length rx88_eos, rx88_tgt
    gt rx88_pos, rx88_eos, rx88_done
    set rx88_off, 0
    lt rx88_pos, 2, rx88_start
    sub rx88_off, rx88_pos, 1
    substr rx88_tgt, rx88_tgt, rx88_off
  rx88_start:
    eq $I10, 1, rx88_restart
    if_null rx88_debug, debug_140
    rx88_cur."!cursor_debug"("START", "prefixish")
  debug_140:
    $I10 = self.'from'()
    ne $I10, -1, rxscan92_done
    goto rxscan92_scan
  rxscan92_loop:
    (rx88_pos) = rx88_cur."from"()
    inc rx88_pos
    rx88_cur."!cursor_from"(rx88_pos)
    ge rx88_pos, rx88_eos, rxscan92_done
  rxscan92_scan:
    set_addr $I10, rxscan92_loop
    rx88_cur."!mark_push"(0, rx88_pos, $I10)
  rxscan92_done:
.annotate 'line', 21
  # rx subrule "prefix" subtype=capture negate=
    rx88_cur."!cursor_pos"(rx88_pos)
    $P10 = rx88_cur."prefix"()
    unless $P10, rx88_fail
    rx88_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("OPER=prefix")
    rx88_pos = $P10."pos"()
  # rx subrule "ws" subtype=method negate=
    rx88_cur."!cursor_pos"(rx88_pos)
    $P10 = rx88_cur."ws"()
    unless $P10, rx88_fail
    rx88_pos = $P10."pos"()
  # rx pass
    rx88_cur."!cursor_pass"(rx88_pos, "prefixish")
    if_null rx88_debug, debug_141
    rx88_cur."!cursor_debug"("PASS", "prefixish", " at pos=", rx88_pos)
  debug_141:
    .return (rx88_cur)
  rx88_restart:
.annotate 'line', 3
    if_null rx88_debug, debug_142
    rx88_cur."!cursor_debug"("NEXT", "prefixish")
  debug_142:
  rx88_fail:
    (rx88_rep, rx88_pos, $I10, $P10) = rx88_cur."!mark_fail"(0)
    lt rx88_pos, -1, rx88_done
    eq rx88_pos, -1, rx88_fail
    jump $I10
  rx88_done:
    rx88_cur."!cursor_fail"()
    if_null rx88_debug, debug_143
    rx88_cur."!cursor_debug"("FAIL", "prefixish")
  debug_143:
    .return (rx88_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__prefixish"  :nsentry("!PREFIX__prefixish") :subid("33_1299602516.087") :method
.annotate 'line', 3
    $P90 = self."!PREFIX__!subrule"("prefix", "")
    new $P91, "ResizablePMCArray"
    push $P91, $P90
    .return ($P91)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "postfixish"  :subid("34_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx94_tgt
    .local int rx94_pos
    .local int rx94_off
    .local int rx94_eos
    .local int rx94_rep
    .local pmc rx94_cur
    .local pmc rx94_debug
    (rx94_cur, rx94_pos, rx94_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx94_cur
    .local pmc match
    .lex "$/", match
    length rx94_eos, rx94_tgt
    gt rx94_pos, rx94_eos, rx94_done
    set rx94_off, 0
    lt rx94_pos, 2, rx94_start
    sub rx94_off, rx94_pos, 1
    substr rx94_tgt, rx94_tgt, rx94_off
  rx94_start:
    eq $I10, 1, rx94_restart
    if_null rx94_debug, debug_144
    rx94_cur."!cursor_debug"("START", "postfixish")
  debug_144:
    $I10 = self.'from'()
    ne $I10, -1, rxscan99_done
    goto rxscan99_scan
  rxscan99_loop:
    (rx94_pos) = rx94_cur."from"()
    inc rx94_pos
    rx94_cur."!cursor_from"(rx94_pos)
    ge rx94_pos, rx94_eos, rxscan99_done
  rxscan99_scan:
    set_addr $I10, rxscan99_loop
    rx94_cur."!mark_push"(0, rx94_pos, $I10)
  rxscan99_done:
  alt100_0:
.annotate 'line', 22
    set_addr $I10, alt100_1
    rx94_cur."!mark_push"(0, rx94_pos, $I10)
.annotate 'line', 23
  # rx subrule "postfix" subtype=capture negate=
    rx94_cur."!cursor_pos"(rx94_pos)
    $P10 = rx94_cur."postfix"()
    unless $P10, rx94_fail
    rx94_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("OPER=postfix")
    rx94_pos = $P10."pos"()
    goto alt100_end
  alt100_1:
.annotate 'line', 24
  # rx subrule "postcircumfix" subtype=capture negate=
    rx94_cur."!cursor_pos"(rx94_pos)
    $P10 = rx94_cur."postcircumfix"()
    unless $P10, rx94_fail
    rx94_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("OPER=postcircumfix")
    rx94_pos = $P10."pos"()
  alt100_end:
.annotate 'line', 22
  # rx pass
    rx94_cur."!cursor_pass"(rx94_pos, "postfixish")
    if_null rx94_debug, debug_145
    rx94_cur."!cursor_debug"("PASS", "postfixish", " at pos=", rx94_pos)
  debug_145:
    .return (rx94_cur)
  rx94_restart:
.annotate 'line', 3
    if_null rx94_debug, debug_146
    rx94_cur."!cursor_debug"("NEXT", "postfixish")
  debug_146:
  rx94_fail:
    (rx94_rep, rx94_pos, $I10, $P10) = rx94_cur."!mark_fail"(0)
    lt rx94_pos, -1, rx94_done
    eq rx94_pos, -1, rx94_fail
    jump $I10
  rx94_done:
    rx94_cur."!cursor_fail"()
    if_null rx94_debug, debug_147
    rx94_cur."!cursor_debug"("FAIL", "postfixish")
  debug_147:
    .return (rx94_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__postfixish"  :nsentry("!PREFIX__postfixish") :subid("35_1299602516.087") :method
.annotate 'line', 3
    $P96 = self."!PREFIX__!subrule"("postcircumfix", "")
    $P97 = self."!PREFIX__!subrule"("postfix", "")
    new $P98, "ResizablePMCArray"
    push $P98, $P96
    push $P98, $P97
    .return ($P98)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "nullterm"  :subid("36_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx102_tgt
    .local int rx102_pos
    .local int rx102_off
    .local int rx102_eos
    .local int rx102_rep
    .local pmc rx102_cur
    .local pmc rx102_debug
    (rx102_cur, rx102_pos, rx102_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx102_cur
    .local pmc match
    .lex "$/", match
    length rx102_eos, rx102_tgt
    gt rx102_pos, rx102_eos, rx102_done
    set rx102_off, 0
    lt rx102_pos, 2, rx102_start
    sub rx102_off, rx102_pos, 1
    substr rx102_tgt, rx102_tgt, rx102_off
  rx102_start:
    eq $I10, 1, rx102_restart
    if_null rx102_debug, debug_148
    rx102_cur."!cursor_debug"("START", "nullterm")
  debug_148:
    $I10 = self.'from'()
    ne $I10, -1, rxscan105_done
    goto rxscan105_scan
  rxscan105_loop:
    (rx102_pos) = rx102_cur."from"()
    inc rx102_pos
    rx102_cur."!cursor_from"(rx102_pos)
    ge rx102_pos, rx102_eos, rxscan105_done
  rxscan105_scan:
    set_addr $I10, rxscan105_loop
    rx102_cur."!mark_push"(0, rx102_pos, $I10)
  rxscan105_done:
.annotate 'line', 27
  # rx pass
    rx102_cur."!cursor_pass"(rx102_pos, "nullterm")
    if_null rx102_debug, debug_149
    rx102_cur."!cursor_debug"("PASS", "nullterm", " at pos=", rx102_pos)
  debug_149:
    .return (rx102_cur)
  rx102_restart:
.annotate 'line', 3
    if_null rx102_debug, debug_150
    rx102_cur."!cursor_debug"("NEXT", "nullterm")
  debug_150:
  rx102_fail:
    (rx102_rep, rx102_pos, $I10, $P10) = rx102_cur."!mark_fail"(0)
    lt rx102_pos, -1, rx102_done
    eq rx102_pos, -1, rx102_fail
    jump $I10
  rx102_done:
    rx102_cur."!cursor_fail"()
    if_null rx102_debug, debug_151
    rx102_cur."!cursor_debug"("FAIL", "nullterm")
  debug_151:
    .return (rx102_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__nullterm"  :nsentry("!PREFIX__nullterm") :subid("37_1299602516.087") :method
.annotate 'line', 3
    new $P104, "ResizablePMCArray"
    push $P104, ""
    .return ($P104)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "nullterm_alt"  :subid("38_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 3
    .local string rx107_tgt
    .local int rx107_pos
    .local int rx107_off
    .local int rx107_eos
    .local int rx107_rep
    .local pmc rx107_cur
    .local pmc rx107_debug
    (rx107_cur, rx107_pos, rx107_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx107_cur
    .local pmc match
    .lex "$/", match
    length rx107_eos, rx107_tgt
    gt rx107_pos, rx107_eos, rx107_done
    set rx107_off, 0
    lt rx107_pos, 2, rx107_start
    sub rx107_off, rx107_pos, 1
    substr rx107_tgt, rx107_tgt, rx107_off
  rx107_start:
    eq $I10, 1, rx107_restart
    if_null rx107_debug, debug_152
    rx107_cur."!cursor_debug"("START", "nullterm_alt")
  debug_152:
    $I10 = self.'from'()
    ne $I10, -1, rxscan111_done
    goto rxscan111_scan
  rxscan111_loop:
    (rx107_pos) = rx107_cur."from"()
    inc rx107_pos
    rx107_cur."!cursor_from"(rx107_pos)
    ge rx107_pos, rx107_eos, rxscan111_done
  rxscan111_scan:
    set_addr $I10, rxscan111_loop
    rx107_cur."!mark_push"(0, rx107_pos, $I10)
  rxscan111_done:
.annotate 'line', 28
  # rx subrule "nullterm" subtype=capture negate=
    rx107_cur."!cursor_pos"(rx107_pos)
    $P10 = rx107_cur."nullterm"()
    unless $P10, rx107_fail
    rx107_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("term")
    rx107_pos = $P10."pos"()
  # rx pass
    rx107_cur."!cursor_pass"(rx107_pos, "nullterm_alt")
    if_null rx107_debug, debug_153
    rx107_cur."!cursor_debug"("PASS", "nullterm_alt", " at pos=", rx107_pos)
  debug_153:
    .return (rx107_cur)
  rx107_restart:
.annotate 'line', 3
    if_null rx107_debug, debug_154
    rx107_cur."!cursor_debug"("NEXT", "nullterm_alt")
  debug_154:
  rx107_fail:
    (rx107_rep, rx107_pos, $I10, $P10) = rx107_cur."!mark_fail"(0)
    lt rx107_pos, -1, rx107_done
    eq rx107_pos, -1, rx107_fail
    jump $I10
  rx107_done:
    rx107_cur."!cursor_fail"()
    if_null rx107_debug, debug_155
    rx107_cur."!cursor_debug"("FAIL", "nullterm_alt")
  debug_155:
    .return (rx107_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__nullterm_alt"  :nsentry("!PREFIX__nullterm_alt") :subid("39_1299602516.087") :method
.annotate 'line', 3
    $P109 = self."!PREFIX__!subrule"("nullterm", "")
    new $P110, "ResizablePMCArray"
    push $P110, $P109
    .return ($P110)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "nulltermish"  :subid("40_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_113
.annotate 'line', 31
    .lex "self", param_113
    find_lex $P116, "self"
    $P117 = $P116."termish"()
    unless $P117, unless_115
    set $P114, $P117
    goto unless_115_end
  unless_115:
    find_lex $P118, "self"
    $P119 = $P118."nullterm_alt"()
    set $P114, $P119
  unless_115_end:
    .return ($P114)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_delimited"  :subid("41_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx121_tgt
    .local int rx121_pos
    .local int rx121_off
    .local int rx121_eos
    .local int rx121_rep
    .local pmc rx121_cur
    .local pmc rx121_debug
    (rx121_cur, rx121_pos, rx121_tgt, $I10) = self."!cursor_start"()
    rx121_cur."!cursor_caparray"("quote_atom")
    .lex unicode:"$\x{a2}", rx121_cur
    .local pmc match
    .lex "$/", match
    length rx121_eos, rx121_tgt
    gt rx121_pos, rx121_eos, rx121_done
    set rx121_off, 0
    lt rx121_pos, 2, rx121_start
    sub rx121_off, rx121_pos, 1
    substr rx121_tgt, rx121_tgt, rx121_off
  rx121_start:
    eq $I10, 1, rx121_restart
    if_null rx121_debug, debug_156
    rx121_cur."!cursor_debug"("START", "quote_delimited")
  debug_156:
    $I10 = self.'from'()
    ne $I10, -1, rxscan125_done
    goto rxscan125_scan
  rxscan125_loop:
    (rx121_pos) = rx121_cur."from"()
    inc rx121_pos
    rx121_cur."!cursor_from"(rx121_pos)
    ge rx121_pos, rx121_eos, rxscan125_done
  rxscan125_scan:
    set_addr $I10, rxscan125_loop
    rx121_cur."!mark_push"(0, rx121_pos, $I10)
  rxscan125_done:
.annotate 'line', 35
  # rx subrule "starter" subtype=capture negate=
    rx121_cur."!cursor_pos"(rx121_pos)
    $P10 = rx121_cur."starter"()
    unless $P10, rx121_fail
    rx121_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("starter")
    rx121_pos = $P10."pos"()
  # rx rxquantr126 ** 0..*
    set_addr $I10, rxquantr126_done
    rx121_cur."!mark_push"(0, rx121_pos, $I10)
  rxquantr126_loop:
  # rx subrule "quote_atom" subtype=capture negate=
    rx121_cur."!cursor_pos"(rx121_pos)
    $P10 = rx121_cur."quote_atom"()
    unless $P10, rx121_fail
    goto rxsubrule127_pass
  rxsubrule127_back:
    $P10 = $P10."!cursor_next"()
    unless $P10, rx121_fail
  rxsubrule127_pass:
    set_addr $I10, rxsubrule127_back
    rx121_cur."!mark_push"(0, rx121_pos, $I10, $P10)
    $P10."!cursor_names"("quote_atom")
    rx121_pos = $P10."pos"()
    set_addr $I10, rxquantr126_done
    (rx121_rep) = rx121_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr126_done
    rx121_cur."!mark_push"(rx121_rep, rx121_pos, $I10)
    goto rxquantr126_loop
  rxquantr126_done:
  # rx subrule "stopper" subtype=capture negate=
    rx121_cur."!cursor_pos"(rx121_pos)
    $P10 = rx121_cur."stopper"()
    unless $P10, rx121_fail
    rx121_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("stopper")
    rx121_pos = $P10."pos"()
.annotate 'line', 34
  # rx pass
    rx121_cur."!cursor_pass"(rx121_pos, "quote_delimited")
    if_null rx121_debug, debug_157
    rx121_cur."!cursor_debug"("PASS", "quote_delimited", " at pos=", rx121_pos)
  debug_157:
    .return (rx121_cur)
  rx121_restart:
.annotate 'line', 31
    if_null rx121_debug, debug_158
    rx121_cur."!cursor_debug"("NEXT", "quote_delimited")
  debug_158:
  rx121_fail:
    (rx121_rep, rx121_pos, $I10, $P10) = rx121_cur."!mark_fail"(0)
    lt rx121_pos, -1, rx121_done
    eq rx121_pos, -1, rx121_fail
    jump $I10
  rx121_done:
    rx121_cur."!cursor_fail"()
    if_null rx121_debug, debug_159
    rx121_cur."!cursor_debug"("FAIL", "quote_delimited")
  debug_159:
    .return (rx121_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_delimited"  :nsentry("!PREFIX__quote_delimited") :subid("42_1299602516.087") :method
.annotate 'line', 31
    $P123 = self."!PREFIX__!subrule"("starter", "")
    new $P124, "ResizablePMCArray"
    push $P124, $P123
    .return ($P124)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_atom"  :subid("43_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx129_tgt
    .local int rx129_pos
    .local int rx129_off
    .local int rx129_eos
    .local int rx129_rep
    .local pmc rx129_cur
    .local pmc rx129_debug
    (rx129_cur, rx129_pos, rx129_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx129_cur
    .local pmc match
    .lex "$/", match
    length rx129_eos, rx129_tgt
    gt rx129_pos, rx129_eos, rx129_done
    set rx129_off, 0
    lt rx129_pos, 2, rx129_start
    sub rx129_off, rx129_pos, 1
    substr rx129_tgt, rx129_tgt, rx129_off
  rx129_start:
    eq $I10, 1, rx129_restart
    if_null rx129_debug, debug_160
    rx129_cur."!cursor_debug"("START", "quote_atom")
  debug_160:
    $I10 = self.'from'()
    ne $I10, -1, rxscan132_done
    goto rxscan132_scan
  rxscan132_loop:
    (rx129_pos) = rx129_cur."from"()
    inc rx129_pos
    rx129_cur."!cursor_from"(rx129_pos)
    ge rx129_pos, rx129_eos, rxscan132_done
  rxscan132_scan:
    set_addr $I10, rxscan132_loop
    rx129_cur."!mark_push"(0, rx129_pos, $I10)
  rxscan132_done:
.annotate 'line', 39
  # rx subrule "stopper" subtype=zerowidth negate=1
    rx129_cur."!cursor_pos"(rx129_pos)
    $P10 = rx129_cur."stopper"()
    if $P10, rx129_fail
  alt133_0:
.annotate 'line', 40
    set_addr $I10, alt133_1
    rx129_cur."!mark_push"(0, rx129_pos, $I10)
.annotate 'line', 41
  # rx subrule "quote_escape" subtype=capture negate=
    rx129_cur."!cursor_pos"(rx129_pos)
    $P10 = rx129_cur."quote_escape"()
    unless $P10, rx129_fail
    rx129_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("quote_escape")
    rx129_pos = $P10."pos"()
    goto alt133_end
  alt133_1:
.annotate 'line', 42
  # rx rxquantr134 ** 1..*
    set_addr $I10, rxquantr134_done
    rx129_cur."!mark_push"(0, -1, $I10)
  rxquantr134_loop:
  # rx subrule "stopper" subtype=zerowidth negate=1
    rx129_cur."!cursor_pos"(rx129_pos)
    $P10 = rx129_cur."stopper"()
    if $P10, rx129_fail
  # rx subrule "quote_escape" subtype=zerowidth negate=1
    rx129_cur."!cursor_pos"(rx129_pos)
    $P10 = rx129_cur."quote_escape"()
    if $P10, rx129_fail
  # rx charclass .
    ge rx129_pos, rx129_eos, rx129_fail
    inc rx129_pos
    set_addr $I10, rxquantr134_done
    (rx129_rep) = rx129_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr134_done
    rx129_cur."!mark_push"(rx129_rep, rx129_pos, $I10)
    goto rxquantr134_loop
  rxquantr134_done:
  alt133_end:
.annotate 'line', 38
  # rx pass
    rx129_cur."!cursor_pass"(rx129_pos, "quote_atom")
    if_null rx129_debug, debug_161
    rx129_cur."!cursor_debug"("PASS", "quote_atom", " at pos=", rx129_pos)
  debug_161:
    .return (rx129_cur)
  rx129_restart:
.annotate 'line', 31
    if_null rx129_debug, debug_162
    rx129_cur."!cursor_debug"("NEXT", "quote_atom")
  debug_162:
  rx129_fail:
    (rx129_rep, rx129_pos, $I10, $P10) = rx129_cur."!mark_fail"(0)
    lt rx129_pos, -1, rx129_done
    eq rx129_pos, -1, rx129_fail
    jump $I10
  rx129_done:
    rx129_cur."!cursor_fail"()
    if_null rx129_debug, debug_163
    rx129_cur."!cursor_debug"("FAIL", "quote_atom")
  debug_163:
    .return (rx129_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_atom"  :nsentry("!PREFIX__quote_atom") :subid("44_1299602516.087") :method
.annotate 'line', 31
    new $P131, "ResizablePMCArray"
    push $P131, ""
    .return ($P131)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "decint"  :subid("45_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx138_tgt
    .local int rx138_pos
    .local int rx138_off
    .local int rx138_eos
    .local int rx138_rep
    .local pmc rx138_cur
    .local pmc rx138_debug
    (rx138_cur, rx138_pos, rx138_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx138_cur
    .local pmc match
    .lex "$/", match
    length rx138_eos, rx138_tgt
    gt rx138_pos, rx138_eos, rx138_done
    set rx138_off, 0
    lt rx138_pos, 2, rx138_start
    sub rx138_off, rx138_pos, 1
    substr rx138_tgt, rx138_tgt, rx138_off
  rx138_start:
    eq $I10, 1, rx138_restart
    if_null rx138_debug, debug_164
    rx138_cur."!cursor_debug"("START", "decint")
  debug_164:
    $I10 = self.'from'()
    ne $I10, -1, rxscan141_done
    goto rxscan141_scan
  rxscan141_loop:
    (rx138_pos) = rx138_cur."from"()
    inc rx138_pos
    rx138_cur."!cursor_from"(rx138_pos)
    ge rx138_pos, rx138_eos, rxscan141_done
  rxscan141_scan:
    set_addr $I10, rxscan141_loop
    rx138_cur."!mark_push"(0, rx138_pos, $I10)
  rxscan141_done:
.annotate 'line', 46
  # rx rxquantr142 ** 1..*
    set_addr $I10, rxquantr142_done
    rx138_cur."!mark_push"(0, -1, $I10)
  rxquantr142_loop:
  # rx charclass_q d r 1..-1
    sub $I10, rx138_pos, rx138_off
    find_not_cclass $I11, 8, rx138_tgt, $I10, rx138_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx138_fail
    add rx138_pos, rx138_off, $I11
    set_addr $I10, rxquantr142_done
    (rx138_rep) = rx138_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr142_done
    rx138_cur."!mark_push"(rx138_rep, rx138_pos, $I10)
  # rx literal  "_"
    add $I11, rx138_pos, 1
    gt $I11, rx138_eos, rx138_fail
    sub $I11, rx138_pos, rx138_off
    ord $I11, rx138_tgt, $I11
    ne $I11, 95, rx138_fail
    add rx138_pos, 1
    goto rxquantr142_loop
  rxquantr142_done:
  # rx pass
    rx138_cur."!cursor_pass"(rx138_pos, "decint")
    if_null rx138_debug, debug_165
    rx138_cur."!cursor_debug"("PASS", "decint", " at pos=", rx138_pos)
  debug_165:
    .return (rx138_cur)
  rx138_restart:
.annotate 'line', 31
    if_null rx138_debug, debug_166
    rx138_cur."!cursor_debug"("NEXT", "decint")
  debug_166:
  rx138_fail:
    (rx138_rep, rx138_pos, $I10, $P10) = rx138_cur."!mark_fail"(0)
    lt rx138_pos, -1, rx138_done
    eq rx138_pos, -1, rx138_fail
    jump $I10
  rx138_done:
    rx138_cur."!cursor_fail"()
    if_null rx138_debug, debug_167
    rx138_cur."!cursor_debug"("FAIL", "decint")
  debug_167:
    .return (rx138_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__decint"  :nsentry("!PREFIX__decint") :subid("46_1299602516.087") :method
.annotate 'line', 31
    new $P140, "ResizablePMCArray"
    push $P140, ""
    .return ($P140)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "decints"  :subid("47_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx144_tgt
    .local int rx144_pos
    .local int rx144_off
    .local int rx144_eos
    .local int rx144_rep
    .local pmc rx144_cur
    .local pmc rx144_debug
    (rx144_cur, rx144_pos, rx144_tgt, $I10) = self."!cursor_start"()
    rx144_cur."!cursor_caparray"("decint")
    .lex unicode:"$\x{a2}", rx144_cur
    .local pmc match
    .lex "$/", match
    length rx144_eos, rx144_tgt
    gt rx144_pos, rx144_eos, rx144_done
    set rx144_off, 0
    lt rx144_pos, 2, rx144_start
    sub rx144_off, rx144_pos, 1
    substr rx144_tgt, rx144_tgt, rx144_off
  rx144_start:
    eq $I10, 1, rx144_restart
    if_null rx144_debug, debug_168
    rx144_cur."!cursor_debug"("START", "decints")
  debug_168:
    $I10 = self.'from'()
    ne $I10, -1, rxscan147_done
    goto rxscan147_scan
  rxscan147_loop:
    (rx144_pos) = rx144_cur."from"()
    inc rx144_pos
    rx144_cur."!cursor_from"(rx144_pos)
    ge rx144_pos, rx144_eos, rxscan147_done
  rxscan147_scan:
    set_addr $I10, rxscan147_loop
    rx144_cur."!mark_push"(0, rx144_pos, $I10)
  rxscan147_done:
.annotate 'line', 47
  # rx rxquantr148 ** 1..*
    set_addr $I10, rxquantr148_done
    rx144_cur."!mark_push"(0, -1, $I10)
  rxquantr148_loop:
  # rx subrule "ws" subtype=method negate=
    rx144_cur."!cursor_pos"(rx144_pos)
    $P10 = rx144_cur."ws"()
    unless $P10, rx144_fail
    rx144_pos = $P10."pos"()
  # rx subrule "decint" subtype=capture negate=
    rx144_cur."!cursor_pos"(rx144_pos)
    $P10 = rx144_cur."decint"()
    unless $P10, rx144_fail
    rx144_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("decint")
    rx144_pos = $P10."pos"()
  # rx subrule "ws" subtype=method negate=
    rx144_cur."!cursor_pos"(rx144_pos)
    $P10 = rx144_cur."ws"()
    unless $P10, rx144_fail
    rx144_pos = $P10."pos"()
    set_addr $I10, rxquantr148_done
    (rx144_rep) = rx144_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr148_done
    rx144_cur."!mark_push"(rx144_rep, rx144_pos, $I10)
  # rx literal  ","
    add $I11, rx144_pos, 1
    gt $I11, rx144_eos, rx144_fail
    sub $I11, rx144_pos, rx144_off
    ord $I11, rx144_tgt, $I11
    ne $I11, 44, rx144_fail
    add rx144_pos, 1
    goto rxquantr148_loop
  rxquantr148_done:
  # rx pass
    rx144_cur."!cursor_pass"(rx144_pos, "decints")
    if_null rx144_debug, debug_169
    rx144_cur."!cursor_debug"("PASS", "decints", " at pos=", rx144_pos)
  debug_169:
    .return (rx144_cur)
  rx144_restart:
.annotate 'line', 31
    if_null rx144_debug, debug_170
    rx144_cur."!cursor_debug"("NEXT", "decints")
  debug_170:
  rx144_fail:
    (rx144_rep, rx144_pos, $I10, $P10) = rx144_cur."!mark_fail"(0)
    lt rx144_pos, -1, rx144_done
    eq rx144_pos, -1, rx144_fail
    jump $I10
  rx144_done:
    rx144_cur."!cursor_fail"()
    if_null rx144_debug, debug_171
    rx144_cur."!cursor_debug"("FAIL", "decints")
  debug_171:
    .return (rx144_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__decints"  :nsentry("!PREFIX__decints") :subid("48_1299602516.087") :method
.annotate 'line', 31
    new $P146, "ResizablePMCArray"
    push $P146, ""
    .return ($P146)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "hexint"  :subid("49_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx150_tgt
    .local int rx150_pos
    .local int rx150_off
    .local int rx150_eos
    .local int rx150_rep
    .local pmc rx150_cur
    .local pmc rx150_debug
    (rx150_cur, rx150_pos, rx150_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx150_cur
    .local pmc match
    .lex "$/", match
    length rx150_eos, rx150_tgt
    gt rx150_pos, rx150_eos, rx150_done
    set rx150_off, 0
    lt rx150_pos, 2, rx150_start
    sub rx150_off, rx150_pos, 1
    substr rx150_tgt, rx150_tgt, rx150_off
  rx150_start:
    eq $I10, 1, rx150_restart
    if_null rx150_debug, debug_172
    rx150_cur."!cursor_debug"("START", "hexint")
  debug_172:
    $I10 = self.'from'()
    ne $I10, -1, rxscan153_done
    goto rxscan153_scan
  rxscan153_loop:
    (rx150_pos) = rx150_cur."from"()
    inc rx150_pos
    rx150_cur."!cursor_from"(rx150_pos)
    ge rx150_pos, rx150_eos, rxscan153_done
  rxscan153_scan:
    set_addr $I10, rxscan153_loop
    rx150_cur."!mark_push"(0, rx150_pos, $I10)
  rxscan153_done:
.annotate 'line', 49
  # rx rxquantr154 ** 1..*
    set_addr $I10, rxquantr154_done
    rx150_cur."!mark_push"(0, -1, $I10)
  rxquantr154_loop:
  # rx enumcharlist_q negate=0  r 1..-1
    sub $I10, rx150_pos, rx150_off
    set rx150_rep, 0
    sub $I12, rx150_eos, rx150_pos
  rxenumcharlistq155_loop:
    le $I12, 0, rxenumcharlistq155_done
    substr $S10, rx150_tgt, $I10, 1
    index $I11, "0123456789abcdefABCDEF", $S10
    lt $I11, 0, rxenumcharlistq155_done
    inc rx150_rep
    inc $I10
    dec $I12
    goto rxenumcharlistq155_loop
  rxenumcharlistq155_done:
    lt rx150_rep, 1, rx150_fail
    add rx150_pos, rx150_pos, rx150_rep
    set_addr $I10, rxquantr154_done
    (rx150_rep) = rx150_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr154_done
    rx150_cur."!mark_push"(rx150_rep, rx150_pos, $I10)
  # rx literal  "_"
    add $I11, rx150_pos, 1
    gt $I11, rx150_eos, rx150_fail
    sub $I11, rx150_pos, rx150_off
    ord $I11, rx150_tgt, $I11
    ne $I11, 95, rx150_fail
    add rx150_pos, 1
    goto rxquantr154_loop
  rxquantr154_done:
  # rx pass
    rx150_cur."!cursor_pass"(rx150_pos, "hexint")
    if_null rx150_debug, debug_173
    rx150_cur."!cursor_debug"("PASS", "hexint", " at pos=", rx150_pos)
  debug_173:
    .return (rx150_cur)
  rx150_restart:
.annotate 'line', 31
    if_null rx150_debug, debug_174
    rx150_cur."!cursor_debug"("NEXT", "hexint")
  debug_174:
  rx150_fail:
    (rx150_rep, rx150_pos, $I10, $P10) = rx150_cur."!mark_fail"(0)
    lt rx150_pos, -1, rx150_done
    eq rx150_pos, -1, rx150_fail
    jump $I10
  rx150_done:
    rx150_cur."!cursor_fail"()
    if_null rx150_debug, debug_175
    rx150_cur."!cursor_debug"("FAIL", "hexint")
  debug_175:
    .return (rx150_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__hexint"  :nsentry("!PREFIX__hexint") :subid("50_1299602516.087") :method
.annotate 'line', 31
    new $P152, "ResizablePMCArray"
    push $P152, ""
    .return ($P152)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "hexints"  :subid("51_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx157_tgt
    .local int rx157_pos
    .local int rx157_off
    .local int rx157_eos
    .local int rx157_rep
    .local pmc rx157_cur
    .local pmc rx157_debug
    (rx157_cur, rx157_pos, rx157_tgt, $I10) = self."!cursor_start"()
    rx157_cur."!cursor_caparray"("hexint")
    .lex unicode:"$\x{a2}", rx157_cur
    .local pmc match
    .lex "$/", match
    length rx157_eos, rx157_tgt
    gt rx157_pos, rx157_eos, rx157_done
    set rx157_off, 0
    lt rx157_pos, 2, rx157_start
    sub rx157_off, rx157_pos, 1
    substr rx157_tgt, rx157_tgt, rx157_off
  rx157_start:
    eq $I10, 1, rx157_restart
    if_null rx157_debug, debug_176
    rx157_cur."!cursor_debug"("START", "hexints")
  debug_176:
    $I10 = self.'from'()
    ne $I10, -1, rxscan160_done
    goto rxscan160_scan
  rxscan160_loop:
    (rx157_pos) = rx157_cur."from"()
    inc rx157_pos
    rx157_cur."!cursor_from"(rx157_pos)
    ge rx157_pos, rx157_eos, rxscan160_done
  rxscan160_scan:
    set_addr $I10, rxscan160_loop
    rx157_cur."!mark_push"(0, rx157_pos, $I10)
  rxscan160_done:
.annotate 'line', 50
  # rx rxquantr161 ** 1..*
    set_addr $I10, rxquantr161_done
    rx157_cur."!mark_push"(0, -1, $I10)
  rxquantr161_loop:
  # rx subrule "ws" subtype=method negate=
    rx157_cur."!cursor_pos"(rx157_pos)
    $P10 = rx157_cur."ws"()
    unless $P10, rx157_fail
    rx157_pos = $P10."pos"()
  # rx subrule "hexint" subtype=capture negate=
    rx157_cur."!cursor_pos"(rx157_pos)
    $P10 = rx157_cur."hexint"()
    unless $P10, rx157_fail
    rx157_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("hexint")
    rx157_pos = $P10."pos"()
  # rx subrule "ws" subtype=method negate=
    rx157_cur."!cursor_pos"(rx157_pos)
    $P10 = rx157_cur."ws"()
    unless $P10, rx157_fail
    rx157_pos = $P10."pos"()
    set_addr $I10, rxquantr161_done
    (rx157_rep) = rx157_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr161_done
    rx157_cur."!mark_push"(rx157_rep, rx157_pos, $I10)
  # rx literal  ","
    add $I11, rx157_pos, 1
    gt $I11, rx157_eos, rx157_fail
    sub $I11, rx157_pos, rx157_off
    ord $I11, rx157_tgt, $I11
    ne $I11, 44, rx157_fail
    add rx157_pos, 1
    goto rxquantr161_loop
  rxquantr161_done:
  # rx pass
    rx157_cur."!cursor_pass"(rx157_pos, "hexints")
    if_null rx157_debug, debug_177
    rx157_cur."!cursor_debug"("PASS", "hexints", " at pos=", rx157_pos)
  debug_177:
    .return (rx157_cur)
  rx157_restart:
.annotate 'line', 31
    if_null rx157_debug, debug_178
    rx157_cur."!cursor_debug"("NEXT", "hexints")
  debug_178:
  rx157_fail:
    (rx157_rep, rx157_pos, $I10, $P10) = rx157_cur."!mark_fail"(0)
    lt rx157_pos, -1, rx157_done
    eq rx157_pos, -1, rx157_fail
    jump $I10
  rx157_done:
    rx157_cur."!cursor_fail"()
    if_null rx157_debug, debug_179
    rx157_cur."!cursor_debug"("FAIL", "hexints")
  debug_179:
    .return (rx157_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__hexints"  :nsentry("!PREFIX__hexints") :subid("52_1299602516.087") :method
.annotate 'line', 31
    new $P159, "ResizablePMCArray"
    push $P159, ""
    .return ($P159)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "octint"  :subid("53_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx163_tgt
    .local int rx163_pos
    .local int rx163_off
    .local int rx163_eos
    .local int rx163_rep
    .local pmc rx163_cur
    .local pmc rx163_debug
    (rx163_cur, rx163_pos, rx163_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx163_cur
    .local pmc match
    .lex "$/", match
    length rx163_eos, rx163_tgt
    gt rx163_pos, rx163_eos, rx163_done
    set rx163_off, 0
    lt rx163_pos, 2, rx163_start
    sub rx163_off, rx163_pos, 1
    substr rx163_tgt, rx163_tgt, rx163_off
  rx163_start:
    eq $I10, 1, rx163_restart
    if_null rx163_debug, debug_180
    rx163_cur."!cursor_debug"("START", "octint")
  debug_180:
    $I10 = self.'from'()
    ne $I10, -1, rxscan166_done
    goto rxscan166_scan
  rxscan166_loop:
    (rx163_pos) = rx163_cur."from"()
    inc rx163_pos
    rx163_cur."!cursor_from"(rx163_pos)
    ge rx163_pos, rx163_eos, rxscan166_done
  rxscan166_scan:
    set_addr $I10, rxscan166_loop
    rx163_cur."!mark_push"(0, rx163_pos, $I10)
  rxscan166_done:
.annotate 'line', 52
  # rx rxquantr167 ** 1..*
    set_addr $I10, rxquantr167_done
    rx163_cur."!mark_push"(0, -1, $I10)
  rxquantr167_loop:
  # rx enumcharlist_q negate=0  r 1..-1
    sub $I10, rx163_pos, rx163_off
    set rx163_rep, 0
    sub $I12, rx163_eos, rx163_pos
  rxenumcharlistq168_loop:
    le $I12, 0, rxenumcharlistq168_done
    substr $S10, rx163_tgt, $I10, 1
    index $I11, "01234567", $S10
    lt $I11, 0, rxenumcharlistq168_done
    inc rx163_rep
    inc $I10
    dec $I12
    goto rxenumcharlistq168_loop
  rxenumcharlistq168_done:
    lt rx163_rep, 1, rx163_fail
    add rx163_pos, rx163_pos, rx163_rep
    set_addr $I10, rxquantr167_done
    (rx163_rep) = rx163_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr167_done
    rx163_cur."!mark_push"(rx163_rep, rx163_pos, $I10)
  # rx literal  "_"
    add $I11, rx163_pos, 1
    gt $I11, rx163_eos, rx163_fail
    sub $I11, rx163_pos, rx163_off
    ord $I11, rx163_tgt, $I11
    ne $I11, 95, rx163_fail
    add rx163_pos, 1
    goto rxquantr167_loop
  rxquantr167_done:
  # rx pass
    rx163_cur."!cursor_pass"(rx163_pos, "octint")
    if_null rx163_debug, debug_181
    rx163_cur."!cursor_debug"("PASS", "octint", " at pos=", rx163_pos)
  debug_181:
    .return (rx163_cur)
  rx163_restart:
.annotate 'line', 31
    if_null rx163_debug, debug_182
    rx163_cur."!cursor_debug"("NEXT", "octint")
  debug_182:
  rx163_fail:
    (rx163_rep, rx163_pos, $I10, $P10) = rx163_cur."!mark_fail"(0)
    lt rx163_pos, -1, rx163_done
    eq rx163_pos, -1, rx163_fail
    jump $I10
  rx163_done:
    rx163_cur."!cursor_fail"()
    if_null rx163_debug, debug_183
    rx163_cur."!cursor_debug"("FAIL", "octint")
  debug_183:
    .return (rx163_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__octint"  :nsentry("!PREFIX__octint") :subid("54_1299602516.087") :method
.annotate 'line', 31
    new $P165, "ResizablePMCArray"
    push $P165, ""
    .return ($P165)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "octints"  :subid("55_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx170_tgt
    .local int rx170_pos
    .local int rx170_off
    .local int rx170_eos
    .local int rx170_rep
    .local pmc rx170_cur
    .local pmc rx170_debug
    (rx170_cur, rx170_pos, rx170_tgt, $I10) = self."!cursor_start"()
    rx170_cur."!cursor_caparray"("octint")
    .lex unicode:"$\x{a2}", rx170_cur
    .local pmc match
    .lex "$/", match
    length rx170_eos, rx170_tgt
    gt rx170_pos, rx170_eos, rx170_done
    set rx170_off, 0
    lt rx170_pos, 2, rx170_start
    sub rx170_off, rx170_pos, 1
    substr rx170_tgt, rx170_tgt, rx170_off
  rx170_start:
    eq $I10, 1, rx170_restart
    if_null rx170_debug, debug_184
    rx170_cur."!cursor_debug"("START", "octints")
  debug_184:
    $I10 = self.'from'()
    ne $I10, -1, rxscan173_done
    goto rxscan173_scan
  rxscan173_loop:
    (rx170_pos) = rx170_cur."from"()
    inc rx170_pos
    rx170_cur."!cursor_from"(rx170_pos)
    ge rx170_pos, rx170_eos, rxscan173_done
  rxscan173_scan:
    set_addr $I10, rxscan173_loop
    rx170_cur."!mark_push"(0, rx170_pos, $I10)
  rxscan173_done:
.annotate 'line', 53
  # rx rxquantr174 ** 1..*
    set_addr $I10, rxquantr174_done
    rx170_cur."!mark_push"(0, -1, $I10)
  rxquantr174_loop:
  # rx subrule "ws" subtype=method negate=
    rx170_cur."!cursor_pos"(rx170_pos)
    $P10 = rx170_cur."ws"()
    unless $P10, rx170_fail
    rx170_pos = $P10."pos"()
  # rx subrule "octint" subtype=capture negate=
    rx170_cur."!cursor_pos"(rx170_pos)
    $P10 = rx170_cur."octint"()
    unless $P10, rx170_fail
    rx170_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("octint")
    rx170_pos = $P10."pos"()
  # rx subrule "ws" subtype=method negate=
    rx170_cur."!cursor_pos"(rx170_pos)
    $P10 = rx170_cur."ws"()
    unless $P10, rx170_fail
    rx170_pos = $P10."pos"()
    set_addr $I10, rxquantr174_done
    (rx170_rep) = rx170_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr174_done
    rx170_cur."!mark_push"(rx170_rep, rx170_pos, $I10)
  # rx literal  ","
    add $I11, rx170_pos, 1
    gt $I11, rx170_eos, rx170_fail
    sub $I11, rx170_pos, rx170_off
    ord $I11, rx170_tgt, $I11
    ne $I11, 44, rx170_fail
    add rx170_pos, 1
    goto rxquantr174_loop
  rxquantr174_done:
  # rx pass
    rx170_cur."!cursor_pass"(rx170_pos, "octints")
    if_null rx170_debug, debug_185
    rx170_cur."!cursor_debug"("PASS", "octints", " at pos=", rx170_pos)
  debug_185:
    .return (rx170_cur)
  rx170_restart:
.annotate 'line', 31
    if_null rx170_debug, debug_186
    rx170_cur."!cursor_debug"("NEXT", "octints")
  debug_186:
  rx170_fail:
    (rx170_rep, rx170_pos, $I10, $P10) = rx170_cur."!mark_fail"(0)
    lt rx170_pos, -1, rx170_done
    eq rx170_pos, -1, rx170_fail
    jump $I10
  rx170_done:
    rx170_cur."!cursor_fail"()
    if_null rx170_debug, debug_187
    rx170_cur."!cursor_debug"("FAIL", "octints")
  debug_187:
    .return (rx170_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__octints"  :nsentry("!PREFIX__octints") :subid("56_1299602516.087") :method
.annotate 'line', 31
    new $P172, "ResizablePMCArray"
    push $P172, ""
    .return ($P172)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "binint"  :subid("57_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx176_tgt
    .local int rx176_pos
    .local int rx176_off
    .local int rx176_eos
    .local int rx176_rep
    .local pmc rx176_cur
    .local pmc rx176_debug
    (rx176_cur, rx176_pos, rx176_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx176_cur
    .local pmc match
    .lex "$/", match
    length rx176_eos, rx176_tgt
    gt rx176_pos, rx176_eos, rx176_done
    set rx176_off, 0
    lt rx176_pos, 2, rx176_start
    sub rx176_off, rx176_pos, 1
    substr rx176_tgt, rx176_tgt, rx176_off
  rx176_start:
    eq $I10, 1, rx176_restart
    if_null rx176_debug, debug_188
    rx176_cur."!cursor_debug"("START", "binint")
  debug_188:
    $I10 = self.'from'()
    ne $I10, -1, rxscan179_done
    goto rxscan179_scan
  rxscan179_loop:
    (rx176_pos) = rx176_cur."from"()
    inc rx176_pos
    rx176_cur."!cursor_from"(rx176_pos)
    ge rx176_pos, rx176_eos, rxscan179_done
  rxscan179_scan:
    set_addr $I10, rxscan179_loop
    rx176_cur."!mark_push"(0, rx176_pos, $I10)
  rxscan179_done:
.annotate 'line', 55
  # rx rxquantr180 ** 1..*
    set_addr $I10, rxquantr180_done
    rx176_cur."!mark_push"(0, -1, $I10)
  rxquantr180_loop:
  # rx enumcharlist_q negate=0  r 1..-1
    sub $I10, rx176_pos, rx176_off
    set rx176_rep, 0
    sub $I12, rx176_eos, rx176_pos
  rxenumcharlistq181_loop:
    le $I12, 0, rxenumcharlistq181_done
    substr $S10, rx176_tgt, $I10, 1
    index $I11, "01", $S10
    lt $I11, 0, rxenumcharlistq181_done
    inc rx176_rep
    inc $I10
    dec $I12
    goto rxenumcharlistq181_loop
  rxenumcharlistq181_done:
    lt rx176_rep, 1, rx176_fail
    add rx176_pos, rx176_pos, rx176_rep
    set_addr $I10, rxquantr180_done
    (rx176_rep) = rx176_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr180_done
    rx176_cur."!mark_push"(rx176_rep, rx176_pos, $I10)
  # rx literal  "_"
    add $I11, rx176_pos, 1
    gt $I11, rx176_eos, rx176_fail
    sub $I11, rx176_pos, rx176_off
    ord $I11, rx176_tgt, $I11
    ne $I11, 95, rx176_fail
    add rx176_pos, 1
    goto rxquantr180_loop
  rxquantr180_done:
  # rx pass
    rx176_cur."!cursor_pass"(rx176_pos, "binint")
    if_null rx176_debug, debug_189
    rx176_cur."!cursor_debug"("PASS", "binint", " at pos=", rx176_pos)
  debug_189:
    .return (rx176_cur)
  rx176_restart:
.annotate 'line', 31
    if_null rx176_debug, debug_190
    rx176_cur."!cursor_debug"("NEXT", "binint")
  debug_190:
  rx176_fail:
    (rx176_rep, rx176_pos, $I10, $P10) = rx176_cur."!mark_fail"(0)
    lt rx176_pos, -1, rx176_done
    eq rx176_pos, -1, rx176_fail
    jump $I10
  rx176_done:
    rx176_cur."!cursor_fail"()
    if_null rx176_debug, debug_191
    rx176_cur."!cursor_debug"("FAIL", "binint")
  debug_191:
    .return (rx176_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__binint"  :nsentry("!PREFIX__binint") :subid("58_1299602516.087") :method
.annotate 'line', 31
    new $P178, "ResizablePMCArray"
    push $P178, ""
    .return ($P178)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "binints"  :subid("59_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx183_tgt
    .local int rx183_pos
    .local int rx183_off
    .local int rx183_eos
    .local int rx183_rep
    .local pmc rx183_cur
    .local pmc rx183_debug
    (rx183_cur, rx183_pos, rx183_tgt, $I10) = self."!cursor_start"()
    rx183_cur."!cursor_caparray"("binint")
    .lex unicode:"$\x{a2}", rx183_cur
    .local pmc match
    .lex "$/", match
    length rx183_eos, rx183_tgt
    gt rx183_pos, rx183_eos, rx183_done
    set rx183_off, 0
    lt rx183_pos, 2, rx183_start
    sub rx183_off, rx183_pos, 1
    substr rx183_tgt, rx183_tgt, rx183_off
  rx183_start:
    eq $I10, 1, rx183_restart
    if_null rx183_debug, debug_192
    rx183_cur."!cursor_debug"("START", "binints")
  debug_192:
    $I10 = self.'from'()
    ne $I10, -1, rxscan186_done
    goto rxscan186_scan
  rxscan186_loop:
    (rx183_pos) = rx183_cur."from"()
    inc rx183_pos
    rx183_cur."!cursor_from"(rx183_pos)
    ge rx183_pos, rx183_eos, rxscan186_done
  rxscan186_scan:
    set_addr $I10, rxscan186_loop
    rx183_cur."!mark_push"(0, rx183_pos, $I10)
  rxscan186_done:
.annotate 'line', 56
  # rx rxquantr187 ** 1..*
    set_addr $I10, rxquantr187_done
    rx183_cur."!mark_push"(0, -1, $I10)
  rxquantr187_loop:
  # rx subrule "ws" subtype=method negate=
    rx183_cur."!cursor_pos"(rx183_pos)
    $P10 = rx183_cur."ws"()
    unless $P10, rx183_fail
    rx183_pos = $P10."pos"()
  # rx subrule "binint" subtype=capture negate=
    rx183_cur."!cursor_pos"(rx183_pos)
    $P10 = rx183_cur."binint"()
    unless $P10, rx183_fail
    rx183_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("binint")
    rx183_pos = $P10."pos"()
  # rx subrule "ws" subtype=method negate=
    rx183_cur."!cursor_pos"(rx183_pos)
    $P10 = rx183_cur."ws"()
    unless $P10, rx183_fail
    rx183_pos = $P10."pos"()
    set_addr $I10, rxquantr187_done
    (rx183_rep) = rx183_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr187_done
    rx183_cur."!mark_push"(rx183_rep, rx183_pos, $I10)
  # rx literal  ","
    add $I11, rx183_pos, 1
    gt $I11, rx183_eos, rx183_fail
    sub $I11, rx183_pos, rx183_off
    ord $I11, rx183_tgt, $I11
    ne $I11, 44, rx183_fail
    add rx183_pos, 1
    goto rxquantr187_loop
  rxquantr187_done:
  # rx pass
    rx183_cur."!cursor_pass"(rx183_pos, "binints")
    if_null rx183_debug, debug_193
    rx183_cur."!cursor_debug"("PASS", "binints", " at pos=", rx183_pos)
  debug_193:
    .return (rx183_cur)
  rx183_restart:
.annotate 'line', 31
    if_null rx183_debug, debug_194
    rx183_cur."!cursor_debug"("NEXT", "binints")
  debug_194:
  rx183_fail:
    (rx183_rep, rx183_pos, $I10, $P10) = rx183_cur."!mark_fail"(0)
    lt rx183_pos, -1, rx183_done
    eq rx183_pos, -1, rx183_fail
    jump $I10
  rx183_done:
    rx183_cur."!cursor_fail"()
    if_null rx183_debug, debug_195
    rx183_cur."!cursor_debug"("FAIL", "binints")
  debug_195:
    .return (rx183_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__binints"  :nsentry("!PREFIX__binints") :subid("60_1299602516.087") :method
.annotate 'line', 31
    new $P185, "ResizablePMCArray"
    push $P185, ""
    .return ($P185)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "integer"  :subid("61_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx189_tgt
    .local int rx189_pos
    .local int rx189_off
    .local int rx189_eos
    .local int rx189_rep
    .local pmc rx189_cur
    .local pmc rx189_debug
    (rx189_cur, rx189_pos, rx189_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx189_cur
    .local pmc match
    .lex "$/", match
    length rx189_eos, rx189_tgt
    gt rx189_pos, rx189_eos, rx189_done
    set rx189_off, 0
    lt rx189_pos, 2, rx189_start
    sub rx189_off, rx189_pos, 1
    substr rx189_tgt, rx189_tgt, rx189_off
  rx189_start:
    eq $I10, 1, rx189_restart
    if_null rx189_debug, debug_196
    rx189_cur."!cursor_debug"("START", "integer")
  debug_196:
    $I10 = self.'from'()
    ne $I10, -1, rxscan197_done
    goto rxscan197_scan
  rxscan197_loop:
    (rx189_pos) = rx189_cur."from"()
    inc rx189_pos
    rx189_cur."!cursor_from"(rx189_pos)
    ge rx189_pos, rx189_eos, rxscan197_done
  rxscan197_scan:
    set_addr $I10, rxscan197_loop
    rx189_cur."!mark_push"(0, rx189_pos, $I10)
  rxscan197_done:
  alt198_0:
.annotate 'line', 59
    set_addr $I10, alt198_1
    rx189_cur."!mark_push"(0, rx189_pos, $I10)
.annotate 'line', 60
  # rx literal  "0"
    add $I11, rx189_pos, 1
    gt $I11, rx189_eos, rx189_fail
    sub $I11, rx189_pos, rx189_off
    ord $I11, rx189_tgt, $I11
    ne $I11, 48, rx189_fail
    add rx189_pos, 1
  alt199_0:
    set_addr $I10, alt199_1
    rx189_cur."!mark_push"(0, rx189_pos, $I10)
  # rx literal  "b"
    add $I11, rx189_pos, 1
    gt $I11, rx189_eos, rx189_fail
    sub $I11, rx189_pos, rx189_off
    ord $I11, rx189_tgt, $I11
    ne $I11, 98, rx189_fail
    add rx189_pos, 1
  # rx subrule "binint" subtype=capture negate=
    rx189_cur."!cursor_pos"(rx189_pos)
    $P10 = rx189_cur."binint"()
    unless $P10, rx189_fail
    rx189_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("VALUE=binint")
    rx189_pos = $P10."pos"()
    goto alt199_end
  alt199_1:
    set_addr $I10, alt199_2
    rx189_cur."!mark_push"(0, rx189_pos, $I10)
.annotate 'line', 61
  # rx literal  "o"
    add $I11, rx189_pos, 1
    gt $I11, rx189_eos, rx189_fail
    sub $I11, rx189_pos, rx189_off
    ord $I11, rx189_tgt, $I11
    ne $I11, 111, rx189_fail
    add rx189_pos, 1
  # rx subrule "octint" subtype=capture negate=
    rx189_cur."!cursor_pos"(rx189_pos)
    $P10 = rx189_cur."octint"()
    unless $P10, rx189_fail
    rx189_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("VALUE=octint")
    rx189_pos = $P10."pos"()
    goto alt199_end
  alt199_2:
    set_addr $I10, alt199_3
    rx189_cur."!mark_push"(0, rx189_pos, $I10)
.annotate 'line', 62
  # rx literal  "x"
    add $I11, rx189_pos, 1
    gt $I11, rx189_eos, rx189_fail
    sub $I11, rx189_pos, rx189_off
    ord $I11, rx189_tgt, $I11
    ne $I11, 120, rx189_fail
    add rx189_pos, 1
  # rx subrule "hexint" subtype=capture negate=
    rx189_cur."!cursor_pos"(rx189_pos)
    $P10 = rx189_cur."hexint"()
    unless $P10, rx189_fail
    rx189_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("VALUE=hexint")
    rx189_pos = $P10."pos"()
    goto alt199_end
  alt199_3:
.annotate 'line', 63
  # rx literal  "d"
    add $I11, rx189_pos, 1
    gt $I11, rx189_eos, rx189_fail
    sub $I11, rx189_pos, rx189_off
    ord $I11, rx189_tgt, $I11
    ne $I11, 100, rx189_fail
    add rx189_pos, 1
  # rx subrule "decint" subtype=capture negate=
    rx189_cur."!cursor_pos"(rx189_pos)
    $P10 = rx189_cur."decint"()
    unless $P10, rx189_fail
    rx189_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("VALUE=decint")
    rx189_pos = $P10."pos"()
  alt199_end:
.annotate 'line', 60
    goto alt198_end
  alt198_1:
.annotate 'line', 65
  # rx subrule "decint" subtype=capture negate=
    rx189_cur."!cursor_pos"(rx189_pos)
    $P10 = rx189_cur."decint"()
    unless $P10, rx189_fail
    rx189_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("VALUE=decint")
    rx189_pos = $P10."pos"()
  alt198_end:
.annotate 'line', 58
  # rx pass
    rx189_cur."!cursor_pass"(rx189_pos, "integer")
    if_null rx189_debug, debug_197
    rx189_cur."!cursor_debug"("PASS", "integer", " at pos=", rx189_pos)
  debug_197:
    .return (rx189_cur)
  rx189_restart:
.annotate 'line', 31
    if_null rx189_debug, debug_198
    rx189_cur."!cursor_debug"("NEXT", "integer")
  debug_198:
  rx189_fail:
    (rx189_rep, rx189_pos, $I10, $P10) = rx189_cur."!mark_fail"(0)
    lt rx189_pos, -1, rx189_done
    eq rx189_pos, -1, rx189_fail
    jump $I10
  rx189_done:
    rx189_cur."!cursor_fail"()
    if_null rx189_debug, debug_199
    rx189_cur."!cursor_debug"("FAIL", "integer")
  debug_199:
    .return (rx189_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__integer"  :nsentry("!PREFIX__integer") :subid("62_1299602516.087") :method
.annotate 'line', 31
    $P191 = self."!PREFIX__!subrule"("decint", "")
    $P192 = self."!PREFIX__!subrule"("decint", "0d")
    $P193 = self."!PREFIX__!subrule"("hexint", "0x")
    $P194 = self."!PREFIX__!subrule"("octint", "0o")
    $P195 = self."!PREFIX__!subrule"("binint", "0b")
    new $P196, "ResizablePMCArray"
    push $P196, $P191
    push $P196, $P192
    push $P196, $P193
    push $P196, $P194
    push $P196, $P195
    .return ($P196)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "dec_number"  :subid("63_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx201_tgt
    .local int rx201_pos
    .local int rx201_off
    .local int rx201_eos
    .local int rx201_rep
    .local pmc rx201_cur
    .local pmc rx201_debug
    (rx201_cur, rx201_pos, rx201_tgt, $I10) = self."!cursor_start"()
    rx201_cur."!cursor_caparray"("escale")
    .lex unicode:"$\x{a2}", rx201_cur
    .local pmc match
    .lex "$/", match
    length rx201_eos, rx201_tgt
    gt rx201_pos, rx201_eos, rx201_done
    set rx201_off, 0
    lt rx201_pos, 2, rx201_start
    sub rx201_off, rx201_pos, 1
    substr rx201_tgt, rx201_tgt, rx201_off
  rx201_start:
    eq $I10, 1, rx201_restart
    if_null rx201_debug, debug_200
    rx201_cur."!cursor_debug"("START", "dec_number")
  debug_200:
    $I10 = self.'from'()
    ne $I10, -1, rxscan204_done
    goto rxscan204_scan
  rxscan204_loop:
    (rx201_pos) = rx201_cur."from"()
    inc rx201_pos
    rx201_cur."!cursor_from"(rx201_pos)
    ge rx201_pos, rx201_eos, rxscan204_done
  rxscan204_scan:
    set_addr $I10, rxscan204_loop
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
  rxscan204_done:
  alt205_0:
.annotate 'line', 69
    set_addr $I10, alt205_1
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
.annotate 'line', 70
  # rx subcapture "coeff"
    set_addr $I10, rxcap_206_fail
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
  # rx literal  "."
    add $I11, rx201_pos, 1
    gt $I11, rx201_eos, rx201_fail
    sub $I11, rx201_pos, rx201_off
    ord $I11, rx201_tgt, $I11
    ne $I11, 46, rx201_fail
    add rx201_pos, 1
  # rx charclass_q d r 1..-1
    sub $I10, rx201_pos, rx201_off
    find_not_cclass $I11, 8, rx201_tgt, $I10, rx201_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx201_fail
    add rx201_pos, rx201_off, $I11
    set_addr $I10, rxcap_206_fail
    ($I12, $I11) = rx201_cur."!mark_peek"($I10)
    rx201_cur."!cursor_pos"($I11)
    ($P10) = rx201_cur."!cursor_start"()
    $P10."!cursor_pass"(rx201_pos, "")
    rx201_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("coeff")
    goto rxcap_206_done
  rxcap_206_fail:
    goto rx201_fail
  rxcap_206_done:
  # rx rxquantr207 ** 0..1
    set_addr $I10, rxquantr207_done
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
  rxquantr207_loop:
  # rx subrule "escale" subtype=capture negate=
    rx201_cur."!cursor_pos"(rx201_pos)
    $P10 = rx201_cur."escale"()
    unless $P10, rx201_fail
    goto rxsubrule208_pass
  rxsubrule208_back:
    $P10 = $P10."!cursor_next"()
    unless $P10, rx201_fail
  rxsubrule208_pass:
    set_addr $I10, rxsubrule208_back
    rx201_cur."!mark_push"(0, rx201_pos, $I10, $P10)
    $P10."!cursor_names"("escale")
    rx201_pos = $P10."pos"()
    set_addr $I10, rxquantr207_done
    (rx201_rep) = rx201_cur."!mark_commit"($I10)
  rxquantr207_done:
    goto alt205_end
  alt205_1:
    set_addr $I10, alt205_2
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
.annotate 'line', 71
  # rx subcapture "coeff"
    set_addr $I10, rxcap_209_fail
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
  # rx charclass_q d r 1..-1
    sub $I10, rx201_pos, rx201_off
    find_not_cclass $I11, 8, rx201_tgt, $I10, rx201_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx201_fail
    add rx201_pos, rx201_off, $I11
  # rx literal  "."
    add $I11, rx201_pos, 1
    gt $I11, rx201_eos, rx201_fail
    sub $I11, rx201_pos, rx201_off
    ord $I11, rx201_tgt, $I11
    ne $I11, 46, rx201_fail
    add rx201_pos, 1
  # rx charclass_q d r 1..-1
    sub $I10, rx201_pos, rx201_off
    find_not_cclass $I11, 8, rx201_tgt, $I10, rx201_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx201_fail
    add rx201_pos, rx201_off, $I11
    set_addr $I10, rxcap_209_fail
    ($I12, $I11) = rx201_cur."!mark_peek"($I10)
    rx201_cur."!cursor_pos"($I11)
    ($P10) = rx201_cur."!cursor_start"()
    $P10."!cursor_pass"(rx201_pos, "")
    rx201_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("coeff")
    goto rxcap_209_done
  rxcap_209_fail:
    goto rx201_fail
  rxcap_209_done:
  # rx rxquantr210 ** 0..1
    set_addr $I10, rxquantr210_done
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
  rxquantr210_loop:
  # rx subrule "escale" subtype=capture negate=
    rx201_cur."!cursor_pos"(rx201_pos)
    $P10 = rx201_cur."escale"()
    unless $P10, rx201_fail
    goto rxsubrule211_pass
  rxsubrule211_back:
    $P10 = $P10."!cursor_next"()
    unless $P10, rx201_fail
  rxsubrule211_pass:
    set_addr $I10, rxsubrule211_back
    rx201_cur."!mark_push"(0, rx201_pos, $I10, $P10)
    $P10."!cursor_names"("escale")
    rx201_pos = $P10."pos"()
    set_addr $I10, rxquantr210_done
    (rx201_rep) = rx201_cur."!mark_commit"($I10)
  rxquantr210_done:
    goto alt205_end
  alt205_2:
.annotate 'line', 72
  # rx subcapture "coeff"
    set_addr $I10, rxcap_212_fail
    rx201_cur."!mark_push"(0, rx201_pos, $I10)
  # rx charclass_q d r 1..-1
    sub $I10, rx201_pos, rx201_off
    find_not_cclass $I11, 8, rx201_tgt, $I10, rx201_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx201_fail
    add rx201_pos, rx201_off, $I11
    set_addr $I10, rxcap_212_fail
    ($I12, $I11) = rx201_cur."!mark_peek"($I10)
    rx201_cur."!cursor_pos"($I11)
    ($P10) = rx201_cur."!cursor_start"()
    $P10."!cursor_pass"(rx201_pos, "")
    rx201_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("coeff")
    goto rxcap_212_done
  rxcap_212_fail:
    goto rx201_fail
  rxcap_212_done:
  # rx subrule "escale" subtype=capture negate=
    rx201_cur."!cursor_pos"(rx201_pos)
    $P10 = rx201_cur."escale"()
    unless $P10, rx201_fail
    rx201_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("escale")
    rx201_pos = $P10."pos"()
  alt205_end:
.annotate 'line', 69
  # rx pass
    rx201_cur."!cursor_pass"(rx201_pos, "dec_number")
    if_null rx201_debug, debug_201
    rx201_cur."!cursor_debug"("PASS", "dec_number", " at pos=", rx201_pos)
  debug_201:
    .return (rx201_cur)
  rx201_restart:
.annotate 'line', 31
    if_null rx201_debug, debug_202
    rx201_cur."!cursor_debug"("NEXT", "dec_number")
  debug_202:
  rx201_fail:
    (rx201_rep, rx201_pos, $I10, $P10) = rx201_cur."!mark_fail"(0)
    lt rx201_pos, -1, rx201_done
    eq rx201_pos, -1, rx201_fail
    jump $I10
  rx201_done:
    rx201_cur."!cursor_fail"()
    if_null rx201_debug, debug_203
    rx201_cur."!cursor_debug"("FAIL", "dec_number")
  debug_203:
    .return (rx201_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__dec_number"  :nsentry("!PREFIX__dec_number") :subid("64_1299602516.087") :method
.annotate 'line', 31
    new $P203, "ResizablePMCArray"
    push $P203, ""
    push $P203, ""
    push $P203, "."
    .return ($P203)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "escale"  :subid("65_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx214_tgt
    .local int rx214_pos
    .local int rx214_off
    .local int rx214_eos
    .local int rx214_rep
    .local pmc rx214_cur
    .local pmc rx214_debug
    (rx214_cur, rx214_pos, rx214_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx214_cur
    .local pmc match
    .lex "$/", match
    length rx214_eos, rx214_tgt
    gt rx214_pos, rx214_eos, rx214_done
    set rx214_off, 0
    lt rx214_pos, 2, rx214_start
    sub rx214_off, rx214_pos, 1
    substr rx214_tgt, rx214_tgt, rx214_off
  rx214_start:
    eq $I10, 1, rx214_restart
    if_null rx214_debug, debug_204
    rx214_cur."!cursor_debug"("START", "escale")
  debug_204:
    $I10 = self.'from'()
    ne $I10, -1, rxscan217_done
    goto rxscan217_scan
  rxscan217_loop:
    (rx214_pos) = rx214_cur."from"()
    inc rx214_pos
    rx214_cur."!cursor_from"(rx214_pos)
    ge rx214_pos, rx214_eos, rxscan217_done
  rxscan217_scan:
    set_addr $I10, rxscan217_loop
    rx214_cur."!mark_push"(0, rx214_pos, $I10)
  rxscan217_done:
.annotate 'line', 75
  # rx enumcharlist negate=0 
    ge rx214_pos, rx214_eos, rx214_fail
    sub $I10, rx214_pos, rx214_off
    substr $S10, rx214_tgt, $I10, 1
    index $I11, "Ee", $S10
    lt $I11, 0, rx214_fail
    inc rx214_pos
  # rx enumcharlist_q negate=0  r 0..1
    sub $I10, rx214_pos, rx214_off
    set rx214_rep, 0
    sub $I12, rx214_eos, rx214_pos
    le $I12, 1, rxenumcharlistq218_loop
    set $I12, 1
  rxenumcharlistq218_loop:
    le $I12, 0, rxenumcharlistq218_done
    substr $S10, rx214_tgt, $I10, 1
    index $I11, "+-", $S10
    lt $I11, 0, rxenumcharlistq218_done
    inc rx214_rep
  rxenumcharlistq218_done:
    add rx214_pos, rx214_pos, rx214_rep
  # rx charclass_q d r 1..-1
    sub $I10, rx214_pos, rx214_off
    find_not_cclass $I11, 8, rx214_tgt, $I10, rx214_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx214_fail
    add rx214_pos, rx214_off, $I11
  # rx pass
    rx214_cur."!cursor_pass"(rx214_pos, "escale")
    if_null rx214_debug, debug_205
    rx214_cur."!cursor_debug"("PASS", "escale", " at pos=", rx214_pos)
  debug_205:
    .return (rx214_cur)
  rx214_restart:
.annotate 'line', 31
    if_null rx214_debug, debug_206
    rx214_cur."!cursor_debug"("NEXT", "escale")
  debug_206:
  rx214_fail:
    (rx214_rep, rx214_pos, $I10, $P10) = rx214_cur."!mark_fail"(0)
    lt rx214_pos, -1, rx214_done
    eq rx214_pos, -1, rx214_fail
    jump $I10
  rx214_done:
    rx214_cur."!cursor_fail"()
    if_null rx214_debug, debug_207
    rx214_cur."!cursor_debug"("FAIL", "escale")
  debug_207:
    .return (rx214_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__escale"  :nsentry("!PREFIX__escale") :subid("66_1299602516.087") :method
.annotate 'line', 31
    new $P216, "ResizablePMCArray"
    push $P216, "e"
    push $P216, "E"
    .return ($P216)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape"  :subid("67_1299602516.087")
    .param pmc param_220
.annotate 'line', 77
    .lex "self", param_220
    $P221 = param_220."!protoregex"("quote_escape")
    .return ($P221)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape"  :subid("68_1299602516.087")
    .param pmc param_223
.annotate 'line', 77
    .lex "self", param_223
    $P224 = param_223."!PREFIX__!protoregex"("quote_escape")
    .return ($P224)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<backslash>"  :subid("69_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx226_tgt
    .local int rx226_pos
    .local int rx226_off
    .local int rx226_eos
    .local int rx226_rep
    .local pmc rx226_cur
    .local pmc rx226_debug
    (rx226_cur, rx226_pos, rx226_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx226_cur
    .local pmc match
    .lex "$/", match
    length rx226_eos, rx226_tgt
    gt rx226_pos, rx226_eos, rx226_done
    set rx226_off, 0
    lt rx226_pos, 2, rx226_start
    sub rx226_off, rx226_pos, 1
    substr rx226_tgt, rx226_tgt, rx226_off
  rx226_start:
    eq $I10, 1, rx226_restart
    if_null rx226_debug, debug_208
    rx226_cur."!cursor_debug"("START", "quote_escape:sym<backslash>")
  debug_208:
    $I10 = self.'from'()
    ne $I10, -1, rxscan229_done
    goto rxscan229_scan
  rxscan229_loop:
    (rx226_pos) = rx226_cur."from"()
    inc rx226_pos
    rx226_cur."!cursor_from"(rx226_pos)
    ge rx226_pos, rx226_eos, rxscan229_done
  rxscan229_scan:
    set_addr $I10, rxscan229_loop
    rx226_cur."!mark_push"(0, rx226_pos, $I10)
  rxscan229_done:
.annotate 'line', 78
  # rx literal  "\\\\"
    add $I11, rx226_pos, 2
    gt $I11, rx226_eos, rx226_fail
    sub $I11, rx226_pos, rx226_off
    substr $S10, rx226_tgt, $I11, 2
    ne $S10, "\\\\", rx226_fail
    add rx226_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx226_cur."!cursor_pos"(rx226_pos)
    $P10 = rx226_cur."quotemod_check"("q")
    unless $P10, rx226_fail
  # rx pass
    rx226_cur."!cursor_pass"(rx226_pos, "quote_escape:sym<backslash>")
    if_null rx226_debug, debug_209
    rx226_cur."!cursor_debug"("PASS", "quote_escape:sym<backslash>", " at pos=", rx226_pos)
  debug_209:
    .return (rx226_cur)
  rx226_restart:
.annotate 'line', 31
    if_null rx226_debug, debug_210
    rx226_cur."!cursor_debug"("NEXT", "quote_escape:sym<backslash>")
  debug_210:
  rx226_fail:
    (rx226_rep, rx226_pos, $I10, $P10) = rx226_cur."!mark_fail"(0)
    lt rx226_pos, -1, rx226_done
    eq rx226_pos, -1, rx226_fail
    jump $I10
  rx226_done:
    rx226_cur."!cursor_fail"()
    if_null rx226_debug, debug_211
    rx226_cur."!cursor_debug"("FAIL", "quote_escape:sym<backslash>")
  debug_211:
    .return (rx226_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<backslash>"  :nsentry("!PREFIX__quote_escape:sym<backslash>") :subid("70_1299602516.087") :method
.annotate 'line', 31
    new $P228, "ResizablePMCArray"
    push $P228, "\\\\"
    .return ($P228)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<stopper>"  :subid("71_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx231_tgt
    .local int rx231_pos
    .local int rx231_off
    .local int rx231_eos
    .local int rx231_rep
    .local pmc rx231_cur
    .local pmc rx231_debug
    (rx231_cur, rx231_pos, rx231_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx231_cur
    .local pmc match
    .lex "$/", match
    length rx231_eos, rx231_tgt
    gt rx231_pos, rx231_eos, rx231_done
    set rx231_off, 0
    lt rx231_pos, 2, rx231_start
    sub rx231_off, rx231_pos, 1
    substr rx231_tgt, rx231_tgt, rx231_off
  rx231_start:
    eq $I10, 1, rx231_restart
    if_null rx231_debug, debug_212
    rx231_cur."!cursor_debug"("START", "quote_escape:sym<stopper>")
  debug_212:
    $I10 = self.'from'()
    ne $I10, -1, rxscan234_done
    goto rxscan234_scan
  rxscan234_loop:
    (rx231_pos) = rx231_cur."from"()
    inc rx231_pos
    rx231_cur."!cursor_from"(rx231_pos)
    ge rx231_pos, rx231_eos, rxscan234_done
  rxscan234_scan:
    set_addr $I10, rxscan234_loop
    rx231_cur."!mark_push"(0, rx231_pos, $I10)
  rxscan234_done:
.annotate 'line', 79
  # rx literal  "\\"
    add $I11, rx231_pos, 1
    gt $I11, rx231_eos, rx231_fail
    sub $I11, rx231_pos, rx231_off
    ord $I11, rx231_tgt, $I11
    ne $I11, 92, rx231_fail
    add rx231_pos, 1
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx231_cur."!cursor_pos"(rx231_pos)
    $P10 = rx231_cur."quotemod_check"("q")
    unless $P10, rx231_fail
  # rx subrule "stopper" subtype=capture negate=
    rx231_cur."!cursor_pos"(rx231_pos)
    $P10 = rx231_cur."stopper"()
    unless $P10, rx231_fail
    rx231_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("stopper")
    rx231_pos = $P10."pos"()
  # rx pass
    rx231_cur."!cursor_pass"(rx231_pos, "quote_escape:sym<stopper>")
    if_null rx231_debug, debug_213
    rx231_cur."!cursor_debug"("PASS", "quote_escape:sym<stopper>", " at pos=", rx231_pos)
  debug_213:
    .return (rx231_cur)
  rx231_restart:
.annotate 'line', 31
    if_null rx231_debug, debug_214
    rx231_cur."!cursor_debug"("NEXT", "quote_escape:sym<stopper>")
  debug_214:
  rx231_fail:
    (rx231_rep, rx231_pos, $I10, $P10) = rx231_cur."!mark_fail"(0)
    lt rx231_pos, -1, rx231_done
    eq rx231_pos, -1, rx231_fail
    jump $I10
  rx231_done:
    rx231_cur."!cursor_fail"()
    if_null rx231_debug, debug_215
    rx231_cur."!cursor_debug"("FAIL", "quote_escape:sym<stopper>")
  debug_215:
    .return (rx231_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<stopper>"  :nsentry("!PREFIX__quote_escape:sym<stopper>") :subid("72_1299602516.087") :method
.annotate 'line', 31
    new $P233, "ResizablePMCArray"
    push $P233, "\\"
    .return ($P233)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<bs>"  :subid("73_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx236_tgt
    .local int rx236_pos
    .local int rx236_off
    .local int rx236_eos
    .local int rx236_rep
    .local pmc rx236_cur
    .local pmc rx236_debug
    (rx236_cur, rx236_pos, rx236_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx236_cur
    .local pmc match
    .lex "$/", match
    length rx236_eos, rx236_tgt
    gt rx236_pos, rx236_eos, rx236_done
    set rx236_off, 0
    lt rx236_pos, 2, rx236_start
    sub rx236_off, rx236_pos, 1
    substr rx236_tgt, rx236_tgt, rx236_off
  rx236_start:
    eq $I10, 1, rx236_restart
    if_null rx236_debug, debug_216
    rx236_cur."!cursor_debug"("START", "quote_escape:sym<bs>")
  debug_216:
    $I10 = self.'from'()
    ne $I10, -1, rxscan239_done
    goto rxscan239_scan
  rxscan239_loop:
    (rx236_pos) = rx236_cur."from"()
    inc rx236_pos
    rx236_cur."!cursor_from"(rx236_pos)
    ge rx236_pos, rx236_eos, rxscan239_done
  rxscan239_scan:
    set_addr $I10, rxscan239_loop
    rx236_cur."!mark_push"(0, rx236_pos, $I10)
  rxscan239_done:
.annotate 'line', 81
  # rx literal  "\\b"
    add $I11, rx236_pos, 2
    gt $I11, rx236_eos, rx236_fail
    sub $I11, rx236_pos, rx236_off
    substr $S10, rx236_tgt, $I11, 2
    ne $S10, "\\b", rx236_fail
    add rx236_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx236_cur."!cursor_pos"(rx236_pos)
    $P10 = rx236_cur."quotemod_check"("b")
    unless $P10, rx236_fail
  # rx pass
    rx236_cur."!cursor_pass"(rx236_pos, "quote_escape:sym<bs>")
    if_null rx236_debug, debug_217
    rx236_cur."!cursor_debug"("PASS", "quote_escape:sym<bs>", " at pos=", rx236_pos)
  debug_217:
    .return (rx236_cur)
  rx236_restart:
.annotate 'line', 31
    if_null rx236_debug, debug_218
    rx236_cur."!cursor_debug"("NEXT", "quote_escape:sym<bs>")
  debug_218:
  rx236_fail:
    (rx236_rep, rx236_pos, $I10, $P10) = rx236_cur."!mark_fail"(0)
    lt rx236_pos, -1, rx236_done
    eq rx236_pos, -1, rx236_fail
    jump $I10
  rx236_done:
    rx236_cur."!cursor_fail"()
    if_null rx236_debug, debug_219
    rx236_cur."!cursor_debug"("FAIL", "quote_escape:sym<bs>")
  debug_219:
    .return (rx236_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<bs>"  :nsentry("!PREFIX__quote_escape:sym<bs>") :subid("74_1299602516.087") :method
.annotate 'line', 31
    new $P238, "ResizablePMCArray"
    push $P238, "\\b"
    .return ($P238)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<nl>"  :subid("75_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx241_tgt
    .local int rx241_pos
    .local int rx241_off
    .local int rx241_eos
    .local int rx241_rep
    .local pmc rx241_cur
    .local pmc rx241_debug
    (rx241_cur, rx241_pos, rx241_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx241_cur
    .local pmc match
    .lex "$/", match
    length rx241_eos, rx241_tgt
    gt rx241_pos, rx241_eos, rx241_done
    set rx241_off, 0
    lt rx241_pos, 2, rx241_start
    sub rx241_off, rx241_pos, 1
    substr rx241_tgt, rx241_tgt, rx241_off
  rx241_start:
    eq $I10, 1, rx241_restart
    if_null rx241_debug, debug_220
    rx241_cur."!cursor_debug"("START", "quote_escape:sym<nl>")
  debug_220:
    $I10 = self.'from'()
    ne $I10, -1, rxscan244_done
    goto rxscan244_scan
  rxscan244_loop:
    (rx241_pos) = rx241_cur."from"()
    inc rx241_pos
    rx241_cur."!cursor_from"(rx241_pos)
    ge rx241_pos, rx241_eos, rxscan244_done
  rxscan244_scan:
    set_addr $I10, rxscan244_loop
    rx241_cur."!mark_push"(0, rx241_pos, $I10)
  rxscan244_done:
.annotate 'line', 82
  # rx literal  "\\n"
    add $I11, rx241_pos, 2
    gt $I11, rx241_eos, rx241_fail
    sub $I11, rx241_pos, rx241_off
    substr $S10, rx241_tgt, $I11, 2
    ne $S10, "\\n", rx241_fail
    add rx241_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx241_cur."!cursor_pos"(rx241_pos)
    $P10 = rx241_cur."quotemod_check"("b")
    unless $P10, rx241_fail
  # rx pass
    rx241_cur."!cursor_pass"(rx241_pos, "quote_escape:sym<nl>")
    if_null rx241_debug, debug_221
    rx241_cur."!cursor_debug"("PASS", "quote_escape:sym<nl>", " at pos=", rx241_pos)
  debug_221:
    .return (rx241_cur)
  rx241_restart:
.annotate 'line', 31
    if_null rx241_debug, debug_222
    rx241_cur."!cursor_debug"("NEXT", "quote_escape:sym<nl>")
  debug_222:
  rx241_fail:
    (rx241_rep, rx241_pos, $I10, $P10) = rx241_cur."!mark_fail"(0)
    lt rx241_pos, -1, rx241_done
    eq rx241_pos, -1, rx241_fail
    jump $I10
  rx241_done:
    rx241_cur."!cursor_fail"()
    if_null rx241_debug, debug_223
    rx241_cur."!cursor_debug"("FAIL", "quote_escape:sym<nl>")
  debug_223:
    .return (rx241_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<nl>"  :nsentry("!PREFIX__quote_escape:sym<nl>") :subid("76_1299602516.087") :method
.annotate 'line', 31
    new $P243, "ResizablePMCArray"
    push $P243, "\\n"
    .return ($P243)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<cr>"  :subid("77_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx246_tgt
    .local int rx246_pos
    .local int rx246_off
    .local int rx246_eos
    .local int rx246_rep
    .local pmc rx246_cur
    .local pmc rx246_debug
    (rx246_cur, rx246_pos, rx246_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx246_cur
    .local pmc match
    .lex "$/", match
    length rx246_eos, rx246_tgt
    gt rx246_pos, rx246_eos, rx246_done
    set rx246_off, 0
    lt rx246_pos, 2, rx246_start
    sub rx246_off, rx246_pos, 1
    substr rx246_tgt, rx246_tgt, rx246_off
  rx246_start:
    eq $I10, 1, rx246_restart
    if_null rx246_debug, debug_224
    rx246_cur."!cursor_debug"("START", "quote_escape:sym<cr>")
  debug_224:
    $I10 = self.'from'()
    ne $I10, -1, rxscan249_done
    goto rxscan249_scan
  rxscan249_loop:
    (rx246_pos) = rx246_cur."from"()
    inc rx246_pos
    rx246_cur."!cursor_from"(rx246_pos)
    ge rx246_pos, rx246_eos, rxscan249_done
  rxscan249_scan:
    set_addr $I10, rxscan249_loop
    rx246_cur."!mark_push"(0, rx246_pos, $I10)
  rxscan249_done:
.annotate 'line', 83
  # rx literal  "\\r"
    add $I11, rx246_pos, 2
    gt $I11, rx246_eos, rx246_fail
    sub $I11, rx246_pos, rx246_off
    substr $S10, rx246_tgt, $I11, 2
    ne $S10, "\\r", rx246_fail
    add rx246_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx246_cur."!cursor_pos"(rx246_pos)
    $P10 = rx246_cur."quotemod_check"("b")
    unless $P10, rx246_fail
  # rx pass
    rx246_cur."!cursor_pass"(rx246_pos, "quote_escape:sym<cr>")
    if_null rx246_debug, debug_225
    rx246_cur."!cursor_debug"("PASS", "quote_escape:sym<cr>", " at pos=", rx246_pos)
  debug_225:
    .return (rx246_cur)
  rx246_restart:
.annotate 'line', 31
    if_null rx246_debug, debug_226
    rx246_cur."!cursor_debug"("NEXT", "quote_escape:sym<cr>")
  debug_226:
  rx246_fail:
    (rx246_rep, rx246_pos, $I10, $P10) = rx246_cur."!mark_fail"(0)
    lt rx246_pos, -1, rx246_done
    eq rx246_pos, -1, rx246_fail
    jump $I10
  rx246_done:
    rx246_cur."!cursor_fail"()
    if_null rx246_debug, debug_227
    rx246_cur."!cursor_debug"("FAIL", "quote_escape:sym<cr>")
  debug_227:
    .return (rx246_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<cr>"  :nsentry("!PREFIX__quote_escape:sym<cr>") :subid("78_1299602516.087") :method
.annotate 'line', 31
    new $P248, "ResizablePMCArray"
    push $P248, "\\r"
    .return ($P248)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<tab>"  :subid("79_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx251_tgt
    .local int rx251_pos
    .local int rx251_off
    .local int rx251_eos
    .local int rx251_rep
    .local pmc rx251_cur
    .local pmc rx251_debug
    (rx251_cur, rx251_pos, rx251_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx251_cur
    .local pmc match
    .lex "$/", match
    length rx251_eos, rx251_tgt
    gt rx251_pos, rx251_eos, rx251_done
    set rx251_off, 0
    lt rx251_pos, 2, rx251_start
    sub rx251_off, rx251_pos, 1
    substr rx251_tgt, rx251_tgt, rx251_off
  rx251_start:
    eq $I10, 1, rx251_restart
    if_null rx251_debug, debug_228
    rx251_cur."!cursor_debug"("START", "quote_escape:sym<tab>")
  debug_228:
    $I10 = self.'from'()
    ne $I10, -1, rxscan254_done
    goto rxscan254_scan
  rxscan254_loop:
    (rx251_pos) = rx251_cur."from"()
    inc rx251_pos
    rx251_cur."!cursor_from"(rx251_pos)
    ge rx251_pos, rx251_eos, rxscan254_done
  rxscan254_scan:
    set_addr $I10, rxscan254_loop
    rx251_cur."!mark_push"(0, rx251_pos, $I10)
  rxscan254_done:
.annotate 'line', 84
  # rx literal  "\\t"
    add $I11, rx251_pos, 2
    gt $I11, rx251_eos, rx251_fail
    sub $I11, rx251_pos, rx251_off
    substr $S10, rx251_tgt, $I11, 2
    ne $S10, "\\t", rx251_fail
    add rx251_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx251_cur."!cursor_pos"(rx251_pos)
    $P10 = rx251_cur."quotemod_check"("b")
    unless $P10, rx251_fail
  # rx pass
    rx251_cur."!cursor_pass"(rx251_pos, "quote_escape:sym<tab>")
    if_null rx251_debug, debug_229
    rx251_cur."!cursor_debug"("PASS", "quote_escape:sym<tab>", " at pos=", rx251_pos)
  debug_229:
    .return (rx251_cur)
  rx251_restart:
.annotate 'line', 31
    if_null rx251_debug, debug_230
    rx251_cur."!cursor_debug"("NEXT", "quote_escape:sym<tab>")
  debug_230:
  rx251_fail:
    (rx251_rep, rx251_pos, $I10, $P10) = rx251_cur."!mark_fail"(0)
    lt rx251_pos, -1, rx251_done
    eq rx251_pos, -1, rx251_fail
    jump $I10
  rx251_done:
    rx251_cur."!cursor_fail"()
    if_null rx251_debug, debug_231
    rx251_cur."!cursor_debug"("FAIL", "quote_escape:sym<tab>")
  debug_231:
    .return (rx251_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<tab>"  :nsentry("!PREFIX__quote_escape:sym<tab>") :subid("80_1299602516.087") :method
.annotate 'line', 31
    new $P253, "ResizablePMCArray"
    push $P253, "\\t"
    .return ($P253)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<ff>"  :subid("81_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx256_tgt
    .local int rx256_pos
    .local int rx256_off
    .local int rx256_eos
    .local int rx256_rep
    .local pmc rx256_cur
    .local pmc rx256_debug
    (rx256_cur, rx256_pos, rx256_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx256_cur
    .local pmc match
    .lex "$/", match
    length rx256_eos, rx256_tgt
    gt rx256_pos, rx256_eos, rx256_done
    set rx256_off, 0
    lt rx256_pos, 2, rx256_start
    sub rx256_off, rx256_pos, 1
    substr rx256_tgt, rx256_tgt, rx256_off
  rx256_start:
    eq $I10, 1, rx256_restart
    if_null rx256_debug, debug_232
    rx256_cur."!cursor_debug"("START", "quote_escape:sym<ff>")
  debug_232:
    $I10 = self.'from'()
    ne $I10, -1, rxscan259_done
    goto rxscan259_scan
  rxscan259_loop:
    (rx256_pos) = rx256_cur."from"()
    inc rx256_pos
    rx256_cur."!cursor_from"(rx256_pos)
    ge rx256_pos, rx256_eos, rxscan259_done
  rxscan259_scan:
    set_addr $I10, rxscan259_loop
    rx256_cur."!mark_push"(0, rx256_pos, $I10)
  rxscan259_done:
.annotate 'line', 85
  # rx literal  "\\f"
    add $I11, rx256_pos, 2
    gt $I11, rx256_eos, rx256_fail
    sub $I11, rx256_pos, rx256_off
    substr $S10, rx256_tgt, $I11, 2
    ne $S10, "\\f", rx256_fail
    add rx256_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx256_cur."!cursor_pos"(rx256_pos)
    $P10 = rx256_cur."quotemod_check"("b")
    unless $P10, rx256_fail
  # rx pass
    rx256_cur."!cursor_pass"(rx256_pos, "quote_escape:sym<ff>")
    if_null rx256_debug, debug_233
    rx256_cur."!cursor_debug"("PASS", "quote_escape:sym<ff>", " at pos=", rx256_pos)
  debug_233:
    .return (rx256_cur)
  rx256_restart:
.annotate 'line', 31
    if_null rx256_debug, debug_234
    rx256_cur."!cursor_debug"("NEXT", "quote_escape:sym<ff>")
  debug_234:
  rx256_fail:
    (rx256_rep, rx256_pos, $I10, $P10) = rx256_cur."!mark_fail"(0)
    lt rx256_pos, -1, rx256_done
    eq rx256_pos, -1, rx256_fail
    jump $I10
  rx256_done:
    rx256_cur."!cursor_fail"()
    if_null rx256_debug, debug_235
    rx256_cur."!cursor_debug"("FAIL", "quote_escape:sym<ff>")
  debug_235:
    .return (rx256_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<ff>"  :nsentry("!PREFIX__quote_escape:sym<ff>") :subid("82_1299602516.087") :method
.annotate 'line', 31
    new $P258, "ResizablePMCArray"
    push $P258, "\\f"
    .return ($P258)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<esc>"  :subid("83_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx261_tgt
    .local int rx261_pos
    .local int rx261_off
    .local int rx261_eos
    .local int rx261_rep
    .local pmc rx261_cur
    .local pmc rx261_debug
    (rx261_cur, rx261_pos, rx261_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx261_cur
    .local pmc match
    .lex "$/", match
    length rx261_eos, rx261_tgt
    gt rx261_pos, rx261_eos, rx261_done
    set rx261_off, 0
    lt rx261_pos, 2, rx261_start
    sub rx261_off, rx261_pos, 1
    substr rx261_tgt, rx261_tgt, rx261_off
  rx261_start:
    eq $I10, 1, rx261_restart
    if_null rx261_debug, debug_236
    rx261_cur."!cursor_debug"("START", "quote_escape:sym<esc>")
  debug_236:
    $I10 = self.'from'()
    ne $I10, -1, rxscan264_done
    goto rxscan264_scan
  rxscan264_loop:
    (rx261_pos) = rx261_cur."from"()
    inc rx261_pos
    rx261_cur."!cursor_from"(rx261_pos)
    ge rx261_pos, rx261_eos, rxscan264_done
  rxscan264_scan:
    set_addr $I10, rxscan264_loop
    rx261_cur."!mark_push"(0, rx261_pos, $I10)
  rxscan264_done:
.annotate 'line', 86
  # rx literal  "\\e"
    add $I11, rx261_pos, 2
    gt $I11, rx261_eos, rx261_fail
    sub $I11, rx261_pos, rx261_off
    substr $S10, rx261_tgt, $I11, 2
    ne $S10, "\\e", rx261_fail
    add rx261_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx261_cur."!cursor_pos"(rx261_pos)
    $P10 = rx261_cur."quotemod_check"("b")
    unless $P10, rx261_fail
  # rx pass
    rx261_cur."!cursor_pass"(rx261_pos, "quote_escape:sym<esc>")
    if_null rx261_debug, debug_237
    rx261_cur."!cursor_debug"("PASS", "quote_escape:sym<esc>", " at pos=", rx261_pos)
  debug_237:
    .return (rx261_cur)
  rx261_restart:
.annotate 'line', 31
    if_null rx261_debug, debug_238
    rx261_cur."!cursor_debug"("NEXT", "quote_escape:sym<esc>")
  debug_238:
  rx261_fail:
    (rx261_rep, rx261_pos, $I10, $P10) = rx261_cur."!mark_fail"(0)
    lt rx261_pos, -1, rx261_done
    eq rx261_pos, -1, rx261_fail
    jump $I10
  rx261_done:
    rx261_cur."!cursor_fail"()
    if_null rx261_debug, debug_239
    rx261_cur."!cursor_debug"("FAIL", "quote_escape:sym<esc>")
  debug_239:
    .return (rx261_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<esc>"  :nsentry("!PREFIX__quote_escape:sym<esc>") :subid("84_1299602516.087") :method
.annotate 'line', 31
    new $P263, "ResizablePMCArray"
    push $P263, "\\e"
    .return ($P263)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<hex>"  :subid("85_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx266_tgt
    .local int rx266_pos
    .local int rx266_off
    .local int rx266_eos
    .local int rx266_rep
    .local pmc rx266_cur
    .local pmc rx266_debug
    (rx266_cur, rx266_pos, rx266_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx266_cur
    .local pmc match
    .lex "$/", match
    length rx266_eos, rx266_tgt
    gt rx266_pos, rx266_eos, rx266_done
    set rx266_off, 0
    lt rx266_pos, 2, rx266_start
    sub rx266_off, rx266_pos, 1
    substr rx266_tgt, rx266_tgt, rx266_off
  rx266_start:
    eq $I10, 1, rx266_restart
    if_null rx266_debug, debug_240
    rx266_cur."!cursor_debug"("START", "quote_escape:sym<hex>")
  debug_240:
    $I10 = self.'from'()
    ne $I10, -1, rxscan269_done
    goto rxscan269_scan
  rxscan269_loop:
    (rx266_pos) = rx266_cur."from"()
    inc rx266_pos
    rx266_cur."!cursor_from"(rx266_pos)
    ge rx266_pos, rx266_eos, rxscan269_done
  rxscan269_scan:
    set_addr $I10, rxscan269_loop
    rx266_cur."!mark_push"(0, rx266_pos, $I10)
  rxscan269_done:
.annotate 'line', 88
  # rx literal  unicode:"\\x"
    add $I11, rx266_pos, 2
    gt $I11, rx266_eos, rx266_fail
    sub $I11, rx266_pos, rx266_off
    substr $S10, rx266_tgt, $I11, 2
    ne $S10, unicode:"\\x", rx266_fail
    add rx266_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx266_cur."!cursor_pos"(rx266_pos)
    $P10 = rx266_cur."quotemod_check"("b")
    unless $P10, rx266_fail
  alt270_0:
.annotate 'line', 89
    set_addr $I10, alt270_1
    rx266_cur."!mark_push"(0, rx266_pos, $I10)
  # rx subrule "hexint" subtype=capture negate=
    rx266_cur."!cursor_pos"(rx266_pos)
    $P10 = rx266_cur."hexint"()
    unless $P10, rx266_fail
    rx266_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("hexint")
    rx266_pos = $P10."pos"()
    goto alt270_end
  alt270_1:
  # rx literal  "["
    add $I11, rx266_pos, 1
    gt $I11, rx266_eos, rx266_fail
    sub $I11, rx266_pos, rx266_off
    ord $I11, rx266_tgt, $I11
    ne $I11, 91, rx266_fail
    add rx266_pos, 1
  # rx subrule "hexints" subtype=capture negate=
    rx266_cur."!cursor_pos"(rx266_pos)
    $P10 = rx266_cur."hexints"()
    unless $P10, rx266_fail
    rx266_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("hexints")
    rx266_pos = $P10."pos"()
  # rx literal  "]"
    add $I11, rx266_pos, 1
    gt $I11, rx266_eos, rx266_fail
    sub $I11, rx266_pos, rx266_off
    ord $I11, rx266_tgt, $I11
    ne $I11, 93, rx266_fail
    add rx266_pos, 1
  alt270_end:
.annotate 'line', 87
  # rx pass
    rx266_cur."!cursor_pass"(rx266_pos, "quote_escape:sym<hex>")
    if_null rx266_debug, debug_241
    rx266_cur."!cursor_debug"("PASS", "quote_escape:sym<hex>", " at pos=", rx266_pos)
  debug_241:
    .return (rx266_cur)
  rx266_restart:
.annotate 'line', 31
    if_null rx266_debug, debug_242
    rx266_cur."!cursor_debug"("NEXT", "quote_escape:sym<hex>")
  debug_242:
  rx266_fail:
    (rx266_rep, rx266_pos, $I10, $P10) = rx266_cur."!mark_fail"(0)
    lt rx266_pos, -1, rx266_done
    eq rx266_pos, -1, rx266_fail
    jump $I10
  rx266_done:
    rx266_cur."!cursor_fail"()
    if_null rx266_debug, debug_243
    rx266_cur."!cursor_debug"("FAIL", "quote_escape:sym<hex>")
  debug_243:
    .return (rx266_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<hex>"  :nsentry("!PREFIX__quote_escape:sym<hex>") :subid("86_1299602516.087") :method
.annotate 'line', 31
    new $P268, "ResizablePMCArray"
    push $P268, unicode:"\\x"
    .return ($P268)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<oct>"  :subid("87_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx272_tgt
    .local int rx272_pos
    .local int rx272_off
    .local int rx272_eos
    .local int rx272_rep
    .local pmc rx272_cur
    .local pmc rx272_debug
    (rx272_cur, rx272_pos, rx272_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx272_cur
    .local pmc match
    .lex "$/", match
    length rx272_eos, rx272_tgt
    gt rx272_pos, rx272_eos, rx272_done
    set rx272_off, 0
    lt rx272_pos, 2, rx272_start
    sub rx272_off, rx272_pos, 1
    substr rx272_tgt, rx272_tgt, rx272_off
  rx272_start:
    eq $I10, 1, rx272_restart
    if_null rx272_debug, debug_244
    rx272_cur."!cursor_debug"("START", "quote_escape:sym<oct>")
  debug_244:
    $I10 = self.'from'()
    ne $I10, -1, rxscan275_done
    goto rxscan275_scan
  rxscan275_loop:
    (rx272_pos) = rx272_cur."from"()
    inc rx272_pos
    rx272_cur."!cursor_from"(rx272_pos)
    ge rx272_pos, rx272_eos, rxscan275_done
  rxscan275_scan:
    set_addr $I10, rxscan275_loop
    rx272_cur."!mark_push"(0, rx272_pos, $I10)
  rxscan275_done:
.annotate 'line', 92
  # rx literal  "\\o"
    add $I11, rx272_pos, 2
    gt $I11, rx272_eos, rx272_fail
    sub $I11, rx272_pos, rx272_off
    substr $S10, rx272_tgt, $I11, 2
    ne $S10, "\\o", rx272_fail
    add rx272_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx272_cur."!cursor_pos"(rx272_pos)
    $P10 = rx272_cur."quotemod_check"("b")
    unless $P10, rx272_fail
  alt276_0:
.annotate 'line', 93
    set_addr $I10, alt276_1
    rx272_cur."!mark_push"(0, rx272_pos, $I10)
  # rx subrule "octint" subtype=capture negate=
    rx272_cur."!cursor_pos"(rx272_pos)
    $P10 = rx272_cur."octint"()
    unless $P10, rx272_fail
    rx272_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("octint")
    rx272_pos = $P10."pos"()
    goto alt276_end
  alt276_1:
  # rx literal  "["
    add $I11, rx272_pos, 1
    gt $I11, rx272_eos, rx272_fail
    sub $I11, rx272_pos, rx272_off
    ord $I11, rx272_tgt, $I11
    ne $I11, 91, rx272_fail
    add rx272_pos, 1
  # rx subrule "octints" subtype=capture negate=
    rx272_cur."!cursor_pos"(rx272_pos)
    $P10 = rx272_cur."octints"()
    unless $P10, rx272_fail
    rx272_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("octints")
    rx272_pos = $P10."pos"()
  # rx literal  "]"
    add $I11, rx272_pos, 1
    gt $I11, rx272_eos, rx272_fail
    sub $I11, rx272_pos, rx272_off
    ord $I11, rx272_tgt, $I11
    ne $I11, 93, rx272_fail
    add rx272_pos, 1
  alt276_end:
.annotate 'line', 91
  # rx pass
    rx272_cur."!cursor_pass"(rx272_pos, "quote_escape:sym<oct>")
    if_null rx272_debug, debug_245
    rx272_cur."!cursor_debug"("PASS", "quote_escape:sym<oct>", " at pos=", rx272_pos)
  debug_245:
    .return (rx272_cur)
  rx272_restart:
.annotate 'line', 31
    if_null rx272_debug, debug_246
    rx272_cur."!cursor_debug"("NEXT", "quote_escape:sym<oct>")
  debug_246:
  rx272_fail:
    (rx272_rep, rx272_pos, $I10, $P10) = rx272_cur."!mark_fail"(0)
    lt rx272_pos, -1, rx272_done
    eq rx272_pos, -1, rx272_fail
    jump $I10
  rx272_done:
    rx272_cur."!cursor_fail"()
    if_null rx272_debug, debug_247
    rx272_cur."!cursor_debug"("FAIL", "quote_escape:sym<oct>")
  debug_247:
    .return (rx272_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<oct>"  :nsentry("!PREFIX__quote_escape:sym<oct>") :subid("88_1299602516.087") :method
.annotate 'line', 31
    new $P274, "ResizablePMCArray"
    push $P274, "\\o"
    .return ($P274)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<chr>"  :subid("89_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx278_tgt
    .local int rx278_pos
    .local int rx278_off
    .local int rx278_eos
    .local int rx278_rep
    .local pmc rx278_cur
    .local pmc rx278_debug
    (rx278_cur, rx278_pos, rx278_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx278_cur
    .local pmc match
    .lex "$/", match
    length rx278_eos, rx278_tgt
    gt rx278_pos, rx278_eos, rx278_done
    set rx278_off, 0
    lt rx278_pos, 2, rx278_start
    sub rx278_off, rx278_pos, 1
    substr rx278_tgt, rx278_tgt, rx278_off
  rx278_start:
    eq $I10, 1, rx278_restart
    if_null rx278_debug, debug_248
    rx278_cur."!cursor_debug"("START", "quote_escape:sym<chr>")
  debug_248:
    $I10 = self.'from'()
    ne $I10, -1, rxscan281_done
    goto rxscan281_scan
  rxscan281_loop:
    (rx278_pos) = rx278_cur."from"()
    inc rx278_pos
    rx278_cur."!cursor_from"(rx278_pos)
    ge rx278_pos, rx278_eos, rxscan281_done
  rxscan281_scan:
    set_addr $I10, rxscan281_loop
    rx278_cur."!mark_push"(0, rx278_pos, $I10)
  rxscan281_done:
.annotate 'line', 95
  # rx literal  "\\c"
    add $I11, rx278_pos, 2
    gt $I11, rx278_eos, rx278_fail
    sub $I11, rx278_pos, rx278_off
    substr $S10, rx278_tgt, $I11, 2
    ne $S10, "\\c", rx278_fail
    add rx278_pos, 2
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx278_cur."!cursor_pos"(rx278_pos)
    $P10 = rx278_cur."quotemod_check"("b")
    unless $P10, rx278_fail
  # rx subrule "charspec" subtype=capture negate=
    rx278_cur."!cursor_pos"(rx278_pos)
    $P10 = rx278_cur."charspec"()
    unless $P10, rx278_fail
    rx278_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("charspec")
    rx278_pos = $P10."pos"()
  # rx pass
    rx278_cur."!cursor_pass"(rx278_pos, "quote_escape:sym<chr>")
    if_null rx278_debug, debug_249
    rx278_cur."!cursor_debug"("PASS", "quote_escape:sym<chr>", " at pos=", rx278_pos)
  debug_249:
    .return (rx278_cur)
  rx278_restart:
.annotate 'line', 31
    if_null rx278_debug, debug_250
    rx278_cur."!cursor_debug"("NEXT", "quote_escape:sym<chr>")
  debug_250:
  rx278_fail:
    (rx278_rep, rx278_pos, $I10, $P10) = rx278_cur."!mark_fail"(0)
    lt rx278_pos, -1, rx278_done
    eq rx278_pos, -1, rx278_fail
    jump $I10
  rx278_done:
    rx278_cur."!cursor_fail"()
    if_null rx278_debug, debug_251
    rx278_cur."!cursor_debug"("FAIL", "quote_escape:sym<chr>")
  debug_251:
    .return (rx278_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<chr>"  :nsentry("!PREFIX__quote_escape:sym<chr>") :subid("90_1299602516.087") :method
.annotate 'line', 31
    new $P280, "ResizablePMCArray"
    push $P280, "\\c"
    .return ($P280)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<0>"  :subid("91_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx283_tgt
    .local int rx283_pos
    .local int rx283_off
    .local int rx283_eos
    .local int rx283_rep
    .local pmc rx283_cur
    .local pmc rx283_debug
    (rx283_cur, rx283_pos, rx283_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx283_cur
    .local pmc match
    .lex "$/", match
    length rx283_eos, rx283_tgt
    gt rx283_pos, rx283_eos, rx283_done
    set rx283_off, 0
    lt rx283_pos, 2, rx283_start
    sub rx283_off, rx283_pos, 1
    substr rx283_tgt, rx283_tgt, rx283_off
  rx283_start:
    eq $I10, 1, rx283_restart
    if_null rx283_debug, debug_252
    rx283_cur."!cursor_debug"("START", "quote_escape:sym<0>")
  debug_252:
    $I10 = self.'from'()
    ne $I10, -1, rxscan286_done
    goto rxscan286_scan
  rxscan286_loop:
    (rx283_pos) = rx283_cur."from"()
    inc rx283_pos
    rx283_cur."!cursor_from"(rx283_pos)
    ge rx283_pos, rx283_eos, rxscan286_done
  rxscan286_scan:
    set_addr $I10, rxscan286_loop
    rx283_cur."!mark_push"(0, rx283_pos, $I10)
  rxscan286_done:
.annotate 'line', 96
  # rx literal  "\\"
    add $I11, rx283_pos, 1
    gt $I11, rx283_eos, rx283_fail
    sub $I11, rx283_pos, rx283_off
    ord $I11, rx283_tgt, $I11
    ne $I11, 92, rx283_fail
    add rx283_pos, 1
  # rx subcapture "sym"
    set_addr $I10, rxcap_287_fail
    rx283_cur."!mark_push"(0, rx283_pos, $I10)
  # rx literal  "0"
    add $I11, rx283_pos, 1
    gt $I11, rx283_eos, rx283_fail
    sub $I11, rx283_pos, rx283_off
    ord $I11, rx283_tgt, $I11
    ne $I11, 48, rx283_fail
    add rx283_pos, 1
    set_addr $I10, rxcap_287_fail
    ($I12, $I11) = rx283_cur."!mark_peek"($I10)
    rx283_cur."!cursor_pos"($I11)
    ($P10) = rx283_cur."!cursor_start"()
    $P10."!cursor_pass"(rx283_pos, "")
    rx283_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("sym")
    goto rxcap_287_done
  rxcap_287_fail:
    goto rx283_fail
  rxcap_287_done:
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx283_cur."!cursor_pos"(rx283_pos)
    $P10 = rx283_cur."quotemod_check"("b")
    unless $P10, rx283_fail
  # rx pass
    rx283_cur."!cursor_pass"(rx283_pos, "quote_escape:sym<0>")
    if_null rx283_debug, debug_253
    rx283_cur."!cursor_debug"("PASS", "quote_escape:sym<0>", " at pos=", rx283_pos)
  debug_253:
    .return (rx283_cur)
  rx283_restart:
.annotate 'line', 31
    if_null rx283_debug, debug_254
    rx283_cur."!cursor_debug"("NEXT", "quote_escape:sym<0>")
  debug_254:
  rx283_fail:
    (rx283_rep, rx283_pos, $I10, $P10) = rx283_cur."!mark_fail"(0)
    lt rx283_pos, -1, rx283_done
    eq rx283_pos, -1, rx283_fail
    jump $I10
  rx283_done:
    rx283_cur."!cursor_fail"()
    if_null rx283_debug, debug_255
    rx283_cur."!cursor_debug"("FAIL", "quote_escape:sym<0>")
  debug_255:
    .return (rx283_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<0>"  :nsentry("!PREFIX__quote_escape:sym<0>") :subid("92_1299602516.087") :method
.annotate 'line', 31
    new $P285, "ResizablePMCArray"
    push $P285, "\\0"
    .return ($P285)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_escape:sym<misc>"  :subid("93_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .const 'Sub' $P308 = "97_1299602516.087" 
    capture_lex $P308
    .const 'Sub' $P301 = "96_1299602516.087" 
    capture_lex $P301
    .const 'Sub' $P296 = "95_1299602516.087" 
    capture_lex $P296
    .local string rx289_tgt
    .local int rx289_pos
    .local int rx289_off
    .local int rx289_eos
    .local int rx289_rep
    .local pmc rx289_cur
    .local pmc rx289_debug
    (rx289_cur, rx289_pos, rx289_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx289_cur
    .local pmc match
    .lex "$/", match
    length rx289_eos, rx289_tgt
    gt rx289_pos, rx289_eos, rx289_done
    set rx289_off, 0
    lt rx289_pos, 2, rx289_start
    sub rx289_off, rx289_pos, 1
    substr rx289_tgt, rx289_tgt, rx289_off
  rx289_start:
    eq $I10, 1, rx289_restart
    if_null rx289_debug, debug_256
    rx289_cur."!cursor_debug"("START", "quote_escape:sym<misc>")
  debug_256:
    $I10 = self.'from'()
    ne $I10, -1, rxscan292_done
    goto rxscan292_scan
  rxscan292_loop:
    (rx289_pos) = rx289_cur."from"()
    inc rx289_pos
    rx289_cur."!cursor_from"(rx289_pos)
    ge rx289_pos, rx289_eos, rxscan292_done
  rxscan292_scan:
    set_addr $I10, rxscan292_loop
    rx289_cur."!mark_push"(0, rx289_pos, $I10)
  rxscan292_done:
.annotate 'line', 98
    rx289_cur."!cursor_pos"(rx289_pos)
    find_lex $P293, unicode:"$\x{a2}"
    $P294 = $P293."MATCH"()
    store_lex "$/", $P294
    .const 'Sub' $P296 = "95_1299602516.087" 
    capture_lex $P296
    $P297 = $P296()
  # rx literal  "\\"
    add $I11, rx289_pos, 1
    gt $I11, rx289_eos, rx289_fail
    sub $I11, rx289_pos, rx289_off
    ord $I11, rx289_tgt, $I11
    ne $I11, 92, rx289_fail
    add rx289_pos, 1
  alt298_0:
.annotate 'line', 99
    set_addr $I10, alt298_1
    rx289_cur."!mark_push"(0, rx289_pos, $I10)
.annotate 'line', 100
  # rx subrule "quotemod_check" subtype=zerowidth negate=
    rx289_cur."!cursor_pos"(rx289_pos)
    $P10 = rx289_cur."quotemod_check"("b")
    unless $P10, rx289_fail
  alt299_0:
.annotate 'line', 101
    set_addr $I10, alt299_1
    rx289_cur."!mark_push"(0, rx289_pos, $I10)
.annotate 'line', 102
  # rx subrule $P301 subtype=capture negate=
    rx289_cur."!cursor_pos"(rx289_pos)
    .const 'Sub' $P301 = "96_1299602516.087" 
    capture_lex $P301
    $P10 = rx289_cur.$P301()
    unless $P10, rx289_fail
    rx289_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("textqq")
    rx289_pos = $P10."pos"()
    goto alt299_end
  alt299_1:
.annotate 'line', 103
  # rx subcapture "x"
    set_addr $I10, rxcap_304_fail
    rx289_cur."!mark_push"(0, rx289_pos, $I10)
  # rx charclass w
    ge rx289_pos, rx289_eos, rx289_fail
    sub $I10, rx289_pos, rx289_off
    is_cclass $I11, 8192, rx289_tgt, $I10
    unless $I11, rx289_fail
    inc rx289_pos
    set_addr $I10, rxcap_304_fail
    ($I12, $I11) = rx289_cur."!mark_peek"($I10)
    rx289_cur."!cursor_pos"($I11)
    ($P10) = rx289_cur."!cursor_start"()
    $P10."!cursor_pass"(rx289_pos, "")
    rx289_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("x")
    goto rxcap_304_done
  rxcap_304_fail:
    goto rx289_fail
  rxcap_304_done:
    rx289_cur."!cursor_pos"(rx289_pos)
    find_lex $P305, unicode:"$\x{a2}"
    $P306 = $P305."MATCH"()
    store_lex "$/", $P306
    .const 'Sub' $P308 = "97_1299602516.087" 
    capture_lex $P308
    $P318 = $P308()
  alt299_end:
.annotate 'line', 100
    goto alt298_end
  alt298_1:
.annotate 'line', 105
  # rx subcapture "textq"
    set_addr $I10, rxcap_319_fail
    rx289_cur."!mark_push"(0, rx289_pos, $I10)
  # rx charclass .
    ge rx289_pos, rx289_eos, rx289_fail
    inc rx289_pos
    set_addr $I10, rxcap_319_fail
    ($I12, $I11) = rx289_cur."!mark_peek"($I10)
    rx289_cur."!cursor_pos"($I11)
    ($P10) = rx289_cur."!cursor_start"()
    $P10."!cursor_pass"(rx289_pos, "")
    rx289_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("textq")
    goto rxcap_319_done
  rxcap_319_fail:
    goto rx289_fail
  rxcap_319_done:
  alt298_end:
.annotate 'line', 97
  # rx pass
    rx289_cur."!cursor_pass"(rx289_pos, "quote_escape:sym<misc>")
    if_null rx289_debug, debug_263
    rx289_cur."!cursor_debug"("PASS", "quote_escape:sym<misc>", " at pos=", rx289_pos)
  debug_263:
    .return (rx289_cur)
  rx289_restart:
.annotate 'line', 31
    if_null rx289_debug, debug_264
    rx289_cur."!cursor_debug"("NEXT", "quote_escape:sym<misc>")
  debug_264:
  rx289_fail:
    (rx289_rep, rx289_pos, $I10, $P10) = rx289_cur."!mark_fail"(0)
    lt rx289_pos, -1, rx289_done
    eq rx289_pos, -1, rx289_fail
    jump $I10
  rx289_done:
    rx289_cur."!cursor_fail"()
    if_null rx289_debug, debug_265
    rx289_cur."!cursor_debug"("FAIL", "quote_escape:sym<misc>")
  debug_265:
    .return (rx289_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__quote_escape:sym<misc>"  :nsentry("!PREFIX__quote_escape:sym<misc>") :subid("94_1299602516.087") :method
.annotate 'line', 31
    new $P291, "ResizablePMCArray"
    push $P291, ""
    .return ($P291)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "_block295"  :anon :subid("95_1299602516.087") :outer("93_1299602516.087")
.annotate 'line', 98
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "_block300"  :anon :subid("96_1299602516.087") :method :outer("93_1299602516.087")
.annotate 'line', 102
    .local string rx302_tgt
    .local int rx302_pos
    .local int rx302_off
    .local int rx302_eos
    .local int rx302_rep
    .local pmc rx302_cur
    .local pmc rx302_debug
    (rx302_cur, rx302_pos, rx302_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx302_cur
    .local pmc match
    .lex "$/", match
    length rx302_eos, rx302_tgt
    gt rx302_pos, rx302_eos, rx302_done
    set rx302_off, 0
    lt rx302_pos, 2, rx302_start
    sub rx302_off, rx302_pos, 1
    substr rx302_tgt, rx302_tgt, rx302_off
  rx302_start:
    eq $I10, 1, rx302_restart
    if_null rx302_debug, debug_257
    rx302_cur."!cursor_debug"("START", "")
  debug_257:
    $I10 = self.'from'()
    ne $I10, -1, rxscan303_done
    goto rxscan303_scan
  rxscan303_loop:
    (rx302_pos) = rx302_cur."from"()
    inc rx302_pos
    rx302_cur."!cursor_from"(rx302_pos)
    ge rx302_pos, rx302_eos, rxscan303_done
  rxscan303_scan:
    set_addr $I10, rxscan303_loop
    rx302_cur."!mark_push"(0, rx302_pos, $I10)
  rxscan303_done:
  # rx charclass W
    ge rx302_pos, rx302_eos, rx302_fail
    sub $I10, rx302_pos, rx302_off
    is_cclass $I11, 8192, rx302_tgt, $I10
    if $I11, rx302_fail
    inc rx302_pos
  # rx pass
    rx302_cur."!cursor_pass"(rx302_pos, "")
    if_null rx302_debug, debug_258
    rx302_cur."!cursor_debug"("PASS", "", " at pos=", rx302_pos)
  debug_258:
    .return (rx302_cur)
  rx302_restart:
    if_null rx302_debug, debug_259
    rx302_cur."!cursor_debug"("NEXT", "")
  debug_259:
  rx302_fail:
    (rx302_rep, rx302_pos, $I10, $P10) = rx302_cur."!mark_fail"(0)
    lt rx302_pos, -1, rx302_done
    eq rx302_pos, -1, rx302_fail
    jump $I10
  rx302_done:
    rx302_cur."!cursor_fail"()
    if_null rx302_debug, debug_260
    rx302_cur."!cursor_debug"("FAIL", "")
  debug_260:
    .return (rx302_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "_block307"  :anon :subid("97_1299602516.087") :outer("93_1299602516.087")
.annotate 'line', 103
    find_lex $P309, "$/"
    $P310 = $P309."CURSOR"()
    new $P311, "String"
    assign $P311, "Unrecognized backslash sequence: '\\"
    find_lex $P312, "$/"
    unless_null $P312, vivify_261
    $P312 = root_new ['parrot';'Hash']
  vivify_261:
    set $P313, $P312["x"]
    unless_null $P313, vivify_262
    new $P313, "Undef"
  vivify_262:
    $S314 = $P313."Str"()
    concat $P315, $P311, $S314
    concat $P316, $P315, "'"
    $P317 = $P310."panic"($P316)
    .return ($P317)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "charname"  :subid("98_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .const 'Sub' $P330 = "100_1299602516.087" 
    capture_lex $P330
    .local string rx321_tgt
    .local int rx321_pos
    .local int rx321_off
    .local int rx321_eos
    .local int rx321_rep
    .local pmc rx321_cur
    .local pmc rx321_debug
    (rx321_cur, rx321_pos, rx321_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx321_cur
    .local pmc match
    .lex "$/", match
    length rx321_eos, rx321_tgt
    gt rx321_pos, rx321_eos, rx321_done
    set rx321_off, 0
    lt rx321_pos, 2, rx321_start
    sub rx321_off, rx321_pos, 1
    substr rx321_tgt, rx321_tgt, rx321_off
  rx321_start:
    eq $I10, 1, rx321_restart
    if_null rx321_debug, debug_266
    rx321_cur."!cursor_debug"("START", "charname")
  debug_266:
    $I10 = self.'from'()
    ne $I10, -1, rxscan325_done
    goto rxscan325_scan
  rxscan325_loop:
    (rx321_pos) = rx321_cur."from"()
    inc rx321_pos
    rx321_cur."!cursor_from"(rx321_pos)
    ge rx321_pos, rx321_eos, rxscan325_done
  rxscan325_scan:
    set_addr $I10, rxscan325_loop
    rx321_cur."!mark_push"(0, rx321_pos, $I10)
  rxscan325_done:
  alt326_0:
.annotate 'line', 109
    set_addr $I10, alt326_1
    rx321_cur."!mark_push"(0, rx321_pos, $I10)
.annotate 'line', 110
  # rx subrule "integer" subtype=capture negate=
    rx321_cur."!cursor_pos"(rx321_pos)
    $P10 = rx321_cur."integer"()
    unless $P10, rx321_fail
    rx321_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("integer")
    rx321_pos = $P10."pos"()
    goto alt326_end
  alt326_1:
.annotate 'line', 111
  # rx enumcharlist negate=0 
    ge rx321_pos, rx321_eos, rx321_fail
    sub $I10, rx321_pos, rx321_off
    substr $S10, rx321_tgt, $I10, 1
    index $I11, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", $S10
    lt $I11, 0, rx321_fail
    inc rx321_pos
  # rx rxquantf327 ** 0..*
    set_addr $I10, rxquantf327_loop
    rx321_cur."!mark_push"(0, rx321_pos, $I10)
    goto rxquantf327_done
  rxquantf327_loop:
  # rx enumcharlist negate=1 
    ge rx321_pos, rx321_eos, rx321_fail
    sub $I10, rx321_pos, rx321_off
    substr $S10, rx321_tgt, $I10, 1
    index $I11, "],#", $S10
    ge $I11, 0, rx321_fail
    inc rx321_pos
    set_addr $I10, rxquantf327_loop
    rx321_cur."!mark_push"(rx321_rep, rx321_pos, $I10)
  rxquantf327_done:
  # rx enumcharlist negate=0 
    ge rx321_pos, rx321_eos, rx321_fail
    sub $I10, rx321_pos, rx321_off
    substr $S10, rx321_tgt, $I10, 1
    index $I11, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)", $S10
    lt $I11, 0, rx321_fail
    inc rx321_pos
.annotate 'line', 112
  # rx subrule "before" subtype=zerowidth negate=
    rx321_cur."!cursor_pos"(rx321_pos)
    .const 'Sub' $P330 = "100_1299602516.087" 
    capture_lex $P330
    $P10 = rx321_cur."before"($P330)
    unless $P10, rx321_fail
  alt326_end:
.annotate 'line', 109
  # rx pass
    rx321_cur."!cursor_pass"(rx321_pos, "charname")
    if_null rx321_debug, debug_271
    rx321_cur."!cursor_debug"("PASS", "charname", " at pos=", rx321_pos)
  debug_271:
    .return (rx321_cur)
  rx321_restart:
.annotate 'line', 31
    if_null rx321_debug, debug_272
    rx321_cur."!cursor_debug"("NEXT", "charname")
  debug_272:
  rx321_fail:
    (rx321_rep, rx321_pos, $I10, $P10) = rx321_cur."!mark_fail"(0)
    lt rx321_pos, -1, rx321_done
    eq rx321_pos, -1, rx321_fail
    jump $I10
  rx321_done:
    rx321_cur."!cursor_fail"()
    if_null rx321_debug, debug_273
    rx321_cur."!cursor_debug"("FAIL", "charname")
  debug_273:
    .return (rx321_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__charname"  :nsentry("!PREFIX__charname") :subid("99_1299602516.087") :method
.annotate 'line', 31
    $P323 = self."!PREFIX__!subrule"("integer", "")
    new $P324, "ResizablePMCArray"
    push $P324, "Z"
    push $P324, "Y"
    push $P324, "X"
    push $P324, "W"
    push $P324, "V"
    push $P324, "U"
    push $P324, "T"
    push $P324, "S"
    push $P324, "R"
    push $P324, "Q"
    push $P324, "P"
    push $P324, "O"
    push $P324, "N"
    push $P324, "M"
    push $P324, "L"
    push $P324, "K"
    push $P324, "J"
    push $P324, "I"
    push $P324, "H"
    push $P324, "G"
    push $P324, "F"
    push $P324, "E"
    push $P324, "D"
    push $P324, "C"
    push $P324, "B"
    push $P324, "A"
    push $P324, "z"
    push $P324, "y"
    push $P324, "x"
    push $P324, "w"
    push $P324, "v"
    push $P324, "u"
    push $P324, "t"
    push $P324, "s"
    push $P324, "r"
    push $P324, "q"
    push $P324, "p"
    push $P324, "o"
    push $P324, "n"
    push $P324, "m"
    push $P324, "l"
    push $P324, "k"
    push $P324, "j"
    push $P324, "i"
    push $P324, "h"
    push $P324, "g"
    push $P324, "f"
    push $P324, "e"
    push $P324, "d"
    push $P324, "c"
    push $P324, "b"
    push $P324, "a"
    push $P324, $P323
    .return ($P324)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "_block329"  :anon :subid("100_1299602516.087") :method :outer("98_1299602516.087")
.annotate 'line', 112
    .local string rx331_tgt
    .local int rx331_pos
    .local int rx331_off
    .local int rx331_eos
    .local int rx331_rep
    .local pmc rx331_cur
    .local pmc rx331_debug
    (rx331_cur, rx331_pos, rx331_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx331_cur
    .local pmc match
    .lex "$/", match
    length rx331_eos, rx331_tgt
    gt rx331_pos, rx331_eos, rx331_done
    set rx331_off, 0
    lt rx331_pos, 2, rx331_start
    sub rx331_off, rx331_pos, 1
    substr rx331_tgt, rx331_tgt, rx331_off
  rx331_start:
    eq $I10, 1, rx331_restart
    if_null rx331_debug, debug_267
    rx331_cur."!cursor_debug"("START", "")
  debug_267:
    $I10 = self.'from'()
    ne $I10, -1, rxscan332_done
    goto rxscan332_scan
  rxscan332_loop:
    (rx331_pos) = rx331_cur."from"()
    inc rx331_pos
    rx331_cur."!cursor_from"(rx331_pos)
    ge rx331_pos, rx331_eos, rxscan332_done
  rxscan332_scan:
    set_addr $I10, rxscan332_loop
    rx331_cur."!mark_push"(0, rx331_pos, $I10)
  rxscan332_done:
  # rx charclass_q s r 0..-1
    sub $I10, rx331_pos, rx331_off
    find_not_cclass $I11, 32, rx331_tgt, $I10, rx331_eos
    add rx331_pos, rx331_off, $I11
  # rx enumcharlist negate=0 
    ge rx331_pos, rx331_eos, rx331_fail
    sub $I10, rx331_pos, rx331_off
    substr $S10, rx331_tgt, $I10, 1
    index $I11, "],#", $S10
    lt $I11, 0, rx331_fail
    inc rx331_pos
  # rx pass
    rx331_cur."!cursor_pass"(rx331_pos, "")
    if_null rx331_debug, debug_268
    rx331_cur."!cursor_debug"("PASS", "", " at pos=", rx331_pos)
  debug_268:
    .return (rx331_cur)
  rx331_restart:
    if_null rx331_debug, debug_269
    rx331_cur."!cursor_debug"("NEXT", "")
  debug_269:
  rx331_fail:
    (rx331_rep, rx331_pos, $I10, $P10) = rx331_cur."!mark_fail"(0)
    lt rx331_pos, -1, rx331_done
    eq rx331_pos, -1, rx331_fail
    jump $I10
  rx331_done:
    rx331_cur."!cursor_fail"()
    if_null rx331_debug, debug_270
    rx331_cur."!cursor_debug"("FAIL", "")
  debug_270:
    .return (rx331_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "charnames"  :subid("101_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx334_tgt
    .local int rx334_pos
    .local int rx334_off
    .local int rx334_eos
    .local int rx334_rep
    .local pmc rx334_cur
    .local pmc rx334_debug
    (rx334_cur, rx334_pos, rx334_tgt, $I10) = self."!cursor_start"()
    rx334_cur."!cursor_caparray"("charname")
    .lex unicode:"$\x{a2}", rx334_cur
    .local pmc match
    .lex "$/", match
    length rx334_eos, rx334_tgt
    gt rx334_pos, rx334_eos, rx334_done
    set rx334_off, 0
    lt rx334_pos, 2, rx334_start
    sub rx334_off, rx334_pos, 1
    substr rx334_tgt, rx334_tgt, rx334_off
  rx334_start:
    eq $I10, 1, rx334_restart
    if_null rx334_debug, debug_274
    rx334_cur."!cursor_debug"("START", "charnames")
  debug_274:
    $I10 = self.'from'()
    ne $I10, -1, rxscan337_done
    goto rxscan337_scan
  rxscan337_loop:
    (rx334_pos) = rx334_cur."from"()
    inc rx334_pos
    rx334_cur."!cursor_from"(rx334_pos)
    ge rx334_pos, rx334_eos, rxscan337_done
  rxscan337_scan:
    set_addr $I10, rxscan337_loop
    rx334_cur."!mark_push"(0, rx334_pos, $I10)
  rxscan337_done:
.annotate 'line', 114
  # rx rxquantr338 ** 1..*
    set_addr $I10, rxquantr338_done
    rx334_cur."!mark_push"(0, -1, $I10)
  rxquantr338_loop:
  # rx subrule "ws" subtype=method negate=
    rx334_cur."!cursor_pos"(rx334_pos)
    $P10 = rx334_cur."ws"()
    unless $P10, rx334_fail
    rx334_pos = $P10."pos"()
  # rx subrule "charname" subtype=capture negate=
    rx334_cur."!cursor_pos"(rx334_pos)
    $P10 = rx334_cur."charname"()
    unless $P10, rx334_fail
    rx334_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("charname")
    rx334_pos = $P10."pos"()
  # rx subrule "ws" subtype=method negate=
    rx334_cur."!cursor_pos"(rx334_pos)
    $P10 = rx334_cur."ws"()
    unless $P10, rx334_fail
    rx334_pos = $P10."pos"()
    set_addr $I10, rxquantr338_done
    (rx334_rep) = rx334_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr338_done
    rx334_cur."!mark_push"(rx334_rep, rx334_pos, $I10)
  # rx literal  ","
    add $I11, rx334_pos, 1
    gt $I11, rx334_eos, rx334_fail
    sub $I11, rx334_pos, rx334_off
    ord $I11, rx334_tgt, $I11
    ne $I11, 44, rx334_fail
    add rx334_pos, 1
    goto rxquantr338_loop
  rxquantr338_done:
  # rx pass
    rx334_cur."!cursor_pass"(rx334_pos, "charnames")
    if_null rx334_debug, debug_275
    rx334_cur."!cursor_debug"("PASS", "charnames", " at pos=", rx334_pos)
  debug_275:
    .return (rx334_cur)
  rx334_restart:
.annotate 'line', 31
    if_null rx334_debug, debug_276
    rx334_cur."!cursor_debug"("NEXT", "charnames")
  debug_276:
  rx334_fail:
    (rx334_rep, rx334_pos, $I10, $P10) = rx334_cur."!mark_fail"(0)
    lt rx334_pos, -1, rx334_done
    eq rx334_pos, -1, rx334_fail
    jump $I10
  rx334_done:
    rx334_cur."!cursor_fail"()
    if_null rx334_debug, debug_277
    rx334_cur."!cursor_debug"("FAIL", "charnames")
  debug_277:
    .return (rx334_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__charnames"  :nsentry("!PREFIX__charnames") :subid("102_1299602516.087") :method
.annotate 'line', 31
    new $P336, "ResizablePMCArray"
    push $P336, ""
    .return ($P336)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "charspec"  :subid("103_1299602516.087") :method :outer("11_1299602516.087")
.annotate 'line', 31
    .local string rx340_tgt
    .local int rx340_pos
    .local int rx340_off
    .local int rx340_eos
    .local int rx340_rep
    .local pmc rx340_cur
    .local pmc rx340_debug
    (rx340_cur, rx340_pos, rx340_tgt, $I10) = self."!cursor_start"()
    .lex unicode:"$\x{a2}", rx340_cur
    .local pmc match
    .lex "$/", match
    length rx340_eos, rx340_tgt
    gt rx340_pos, rx340_eos, rx340_done
    set rx340_off, 0
    lt rx340_pos, 2, rx340_start
    sub rx340_off, rx340_pos, 1
    substr rx340_tgt, rx340_tgt, rx340_off
  rx340_start:
    eq $I10, 1, rx340_restart
    if_null rx340_debug, debug_278
    rx340_cur."!cursor_debug"("START", "charspec")
  debug_278:
    $I10 = self.'from'()
    ne $I10, -1, rxscan345_done
    goto rxscan345_scan
  rxscan345_loop:
    (rx340_pos) = rx340_cur."from"()
    inc rx340_pos
    rx340_cur."!cursor_from"(rx340_pos)
    ge rx340_pos, rx340_eos, rxscan345_done
  rxscan345_scan:
    set_addr $I10, rxscan345_loop
    rx340_cur."!mark_push"(0, rx340_pos, $I10)
  rxscan345_done:
  alt346_0:
.annotate 'line', 116
    set_addr $I10, alt346_1
    rx340_cur."!mark_push"(0, rx340_pos, $I10)
.annotate 'line', 117
  # rx literal  "["
    add $I11, rx340_pos, 1
    gt $I11, rx340_eos, rx340_fail
    sub $I11, rx340_pos, rx340_off
    ord $I11, rx340_tgt, $I11
    ne $I11, 91, rx340_fail
    add rx340_pos, 1
  # rx subrule "charnames" subtype=capture negate=
    rx340_cur."!cursor_pos"(rx340_pos)
    $P10 = rx340_cur."charnames"()
    unless $P10, rx340_fail
    rx340_cur."!mark_push"(0, -1, 0, $P10)
    $P10."!cursor_names"("charnames")
    rx340_pos = $P10."pos"()
  # rx literal  "]"
    add $I11, rx340_pos, 1
    gt $I11, rx340_eos, rx340_fail
    sub $I11, rx340_pos, rx340_off
    ord $I11, rx340_tgt, $I11
    ne $I11, 93, rx340_fail
    add rx340_pos, 1
    goto alt346_end
  alt346_1:
    set_addr $I10, alt346_2
    rx340_cur."!mark_push"(0, rx340_pos, $I10)
.annotate 'line', 118
  # rx charclass_q d r 1..-1
    sub $I10, rx340_pos, rx340_off
    find_not_cclass $I11, 8, rx340_tgt, $I10, rx340_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx340_fail
    add rx340_pos, rx340_off, $I11
  # rx rxquantr347 ** 0..*
    set_addr $I10, rxquantr347_done
    rx340_cur."!mark_push"(0, rx340_pos, $I10)
  rxquantr347_loop:
  # rx literal  "_"
    add $I11, rx340_pos, 1
    gt $I11, rx340_eos, rx340_fail
    sub $I11, rx340_pos, rx340_off
    ord $I11, rx340_tgt, $I11
    ne $I11, 95, rx340_fail
    add rx340_pos, 1
  # rx charclass_q d r 1..-1
    sub $I10, rx340_pos, rx340_off
    find_not_cclass $I11, 8, rx340_tgt, $I10, rx340_eos
    add $I12, $I10, 1
    lt $I11, $I12, rx340_fail
    add rx340_pos, rx340_off, $I11
    set_addr $I10, rxquantr347_done
    (rx340_rep) = rx340_cur."!mark_commit"($I10)
    set_addr $I10, rxquantr347_done
    rx340_cur."!mark_push"(rx340_rep, rx340_pos, $I10)
    goto rxquantr347_loop
  rxquantr347_done:
    goto alt346_end
  alt346_2:
    set_addr $I10, alt346_3
    rx340_cur."!mark_push"(0, rx340_pos, $I10)
.annotate 'line', 119
  # rx enumcharlist negate=0 
    ge rx340_pos, rx340_eos, rx340_fail
    sub $I10, rx340_pos, rx340_off
    substr $S10, rx340_tgt, $I10, 1
    index $I11, "?@ABCDEFGHIJKLMNOPQRSTUVWXYZ", $S10
    lt $I11, 0, rx340_fail
    inc rx340_pos
    goto alt346_end
  alt346_3:
.annotate 'line', 120
  # rx subrule "panic" subtype=method negate=
    rx340_cur."!cursor_pos"(rx340_pos)
    $P10 = rx340_cur."panic"("Unrecognized \\c character")
    unless $P10, rx340_fail
    rx340_pos = $P10."pos"()
  alt346_end:
.annotate 'line', 115
  # rx pass
    rx340_cur."!cursor_pass"(rx340_pos, "charspec")
    if_null rx340_debug, debug_279
    rx340_cur."!cursor_debug"("PASS", "charspec", " at pos=", rx340_pos)
  debug_279:
    .return (rx340_cur)
  rx340_restart:
.annotate 'line', 31
    if_null rx340_debug, debug_280
    rx340_cur."!cursor_debug"("NEXT", "charspec")
  debug_280:
  rx340_fail:
    (rx340_rep, rx340_pos, $I10, $P10) = rx340_cur."!mark_fail"(0)
    lt rx340_pos, -1, rx340_done
    eq rx340_pos, -1, rx340_fail
    jump $I10
  rx340_done:
    rx340_cur."!cursor_fail"()
    if_null rx340_debug, debug_281
    rx340_cur."!cursor_debug"("FAIL", "charspec")
  debug_281:
    .return (rx340_cur)
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "!PREFIX__charspec"  :nsentry("!PREFIX__charspec") :subid("104_1299602516.087") :method
.annotate 'line', 31
    $P342 = self."!PREFIX__!subrule"("panic", "")
    $P343 = self."!PREFIX__!subrule"("charnames", "[")
    new $P344, "ResizablePMCArray"
    push $P344, $P342
    push $P344, "Z"
    push $P344, "Y"
    push $P344, "X"
    push $P344, "W"
    push $P344, "V"
    push $P344, "U"
    push $P344, "T"
    push $P344, "S"
    push $P344, "R"
    push $P344, "Q"
    push $P344, "P"
    push $P344, "O"
    push $P344, "N"
    push $P344, "M"
    push $P344, "L"
    push $P344, "K"
    push $P344, "J"
    push $P344, "I"
    push $P344, "H"
    push $P344, "G"
    push $P344, "F"
    push $P344, "E"
    push $P344, "D"
    push $P344, "C"
    push $P344, "B"
    push $P344, "A"
    push $P344, "@"
    push $P344, "?"
    push $P344, ""
    push $P344, $P343
    .return ($P344)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "O"  :subid("105_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_349
    .param pmc param_350
    .param pmc param_351 :optional
    .param int has_param_351 :opt_flag
.annotate 'line', 166
    .lex "self", param_349
    .lex "$spec", param_350
    if has_param_351, optparam_282
    new $P352, "Undef"
    set param_351, $P352
  optparam_282:
    .lex "$save", param_351
.annotate 'line', 167

            .local pmc self, cur_class
            .local string spec, save
            .local int has_save
            self = find_lex 'self'
            cur_class = get_hll_global ['Regex'], 'Cursor'
            $P0 = find_lex '$spec'
            spec = $P0
            has_save = 0
            $P0 = find_lex '$save'
            unless $P0 goto no_save
            save = $P0
            has_save = 1
          no_save:

            # First, get the hash cache.  Right now we have one
            # cache for all grammars; eventually we may need a way to
            # separate them out by cursor type.
            .local pmc ohash
            ohash = get_global '%!ohash'
            unless null ohash goto have_ohash
            ohash = new ['Hash']
            set_global '%!ohash', ohash
          have_ohash:

            # See if we've already created a Hash for the current
            # specification string -- if so, use that.
            .local pmc hash
            hash = ohash[spec]
            unless null hash goto hash_done

            # Otherwise, we need to build a new one.
            hash = new ['Hash']
            .local int pos, eos
            pos = 0
            eos = length spec
          spec_loop:
            pos = find_not_cclass .CCLASS_WHITESPACE, spec, pos, eos
            if pos >= eos goto spec_done
            $S0 = substr spec, pos, 1
            if $S0 == ',' goto spec_comma
            if $S0 == ':' goto spec_pair

            # If whatever we found doesn't start with a colon, treat it
            # as a lookup of a previously saved hash to be merged in.
            .local string lookup
            .local int lpos
            # Find the first whitespace or comma
            lpos = find_cclass .CCLASS_WHITESPACE, spec, pos, eos
            $I0 = index spec, ',', pos
            if $I0 < 0 goto have_lookup_lpos
            if $I0 >= lpos goto have_lookup_lpos
            lpos = $I0
          have_lookup_lpos:
            $I0 = lpos - pos
            lookup = substr spec, pos, $I0
            .local pmc lhash, lhash_it
            lhash = ohash[lookup]
            if null lhash goto err_lookup
            lhash_it = iter lhash
          lhash_loop:
            unless lhash_it goto lhash_done
            $S0 = shift lhash_it
            $P0 = lhash[$S0]
            hash[$S0] = $P0
            goto lhash_loop
          lhash_done:
            pos = lpos
            goto spec_loop

            # We just ignore commas between elements for now.
          spec_comma:
            inc pos
            goto spec_loop

            # If we see a colon, then we want to parse whatever
            # comes next like a pair.
          spec_pair:
            # eat colon
            inc pos
            .local string name
            .local pmc value
            value = new ['Boolean']

            # If the pair is of the form :!name, then reverse the value
            # and skip the colon.
            $S0 = substr spec, pos, 1
            $I0 = iseq $S0, '!'
            pos += $I0
            $I0 = not $I0
            value = $I0

            # Get the name of the pair.
            lpos = find_not_cclass .CCLASS_WORD, spec, pos, eos
            $I0 = lpos - pos
            name = substr spec, pos, $I0
            pos = lpos

            # Look for a <...> that follows.
            $S0 = substr spec, pos, 1
            unless $S0 == '<' goto have_value
            inc pos
            lpos = index spec, '>', pos
            $I0 = lpos - pos
            $S0 = substr spec, pos, $I0
            value = box $S0
            pos = lpos + 1
          have_value:
            # Done processing the pair, store it in the hash.
            hash[name] = value
            goto spec_loop
          spec_done:
            # Done processing the spec string, cache the hash for later.
            ohash[spec] = hash
          hash_done:

            # If we've been called as a subrule, then build a pass-cursor
            # to indicate success and set the hash as the subrule's match object.
            if has_save goto save_hash
            ($P0, $I0) = self.'!cursor_start'()
            $P0.'!cursor_pass'($I0, '')
            setattribute $P0, cur_class, '$!match', hash
            .return ($P0)

            # save the hash under a new entry
          save_hash:
            ohash[save] = hash
            .return (self)

          err_lookup:
            self.'panic'('Unknown operator precedence specification "', lookup, '"')
        
.annotate 'line', 166
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "panic"  :subid("106_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_354
    .param pmc param_355 :slurpy
.annotate 'line', 312
    .lex "self", param_354
    .lex "@args", param_355
.annotate 'line', 313
    new $P356, "Undef"
    .lex "$pos", $P356
.annotate 'line', 314
    new $P357, "Undef"
    .lex "$target", $P357
.annotate 'line', 313
    find_lex $P358, "self"
    $P359 = $P358."pos"()
    store_lex "$pos", $P359
.annotate 'line', 314
    find_lex $P360, "self"
    get_hll_global $P361, ["Regex"], "Cursor"
    getattribute $P362, $P360, $P361, "$!target"
    store_lex "$target", $P362
.annotate 'line', 315
    find_lex $P363, "@args"
    $P363."push"(" at line ")
.annotate 'line', 316
    find_lex $P364, "@args"
    get_hll_global $P365, ["HLL"], "Compiler"
    find_lex $P366, "$target"
    find_lex $P367, "$pos"
    $P368 = $P365."lineof"($P366, $P367)
    add $P369, $P368, 1
    $P364."push"($P369)
.annotate 'line', 317
    find_lex $P370, "@args"
    $P370."push"(", near \"")
.annotate 'line', 318
    find_lex $P371, "@args"
    find_lex $P372, "$target"
    set $S373, $P372
    find_lex $P374, "$pos"
    set $I375, $P374
    substr $S376, $S373, $I375, 10
    escape $S377, $S376
    $P371."push"($S377)
.annotate 'line', 319
    find_lex $P378, "@args"
    $P378."push"("\"")
.annotate 'line', 320
    find_lex $P379, "@args"
    join $S380, "", $P379
    die $S380
.annotate 'line', 312
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "peek_delimiters"  :subid("107_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_382
    .param pmc param_383
    .param pmc param_384
.annotate 'line', 333
    .lex "self", param_382
    .lex "$target", param_383
    .lex "$pos", param_384
.annotate 'line', 334

            .local pmc self
            self = find_lex 'self'
            .local string target
            $P0 = find_lex '$target'
            target = $P0
            .local int pos
            $P0 = find_lex '$pos'
            pos = $P0

            .local string brackets, start, stop
            $P0 = get_global '$!brackets'
            brackets = $P0

            # peek at the next character
            start = substr target, pos, 1
            # colon and word characters aren't valid delimiters
            if start == ':' goto err_colon_delim
            $I0 = is_cclass .CCLASS_WORD, start, 0
            if $I0 goto err_word_delim
            $I0 = is_cclass .CCLASS_WHITESPACE, start, 0
            if $I0 goto err_ws_delim

            # assume stop delim is same as start, for the moment
            stop = start

            # see if we have an opener or closer
            $I0 = index brackets, start
            if $I0 < 0 goto bracket_end
            # if it's a closing bracket, that's an error also
            $I1 = $I0 % 2
            if $I1 goto err_close
            # it's an opener, so get the closing bracket
            inc $I0
            stop = substr brackets, $I0, 1

            # see if the opening bracket is repeated
            .local int len
            len = 0
          bracket_loop:
            inc pos
            inc len
            $S0 = substr target, pos, 1
            if $S0 == start goto bracket_loop
            if len == 1 goto bracket_end
            start = repeat start, len
            stop = repeat stop, len
          bracket_end:
            .return (start, stop, pos)

          err_colon_delim:
            self.'panic'('Colons may not be used to delimit quoting constructs')
          err_word_delim:
            self.'panic'('Alphanumeric character is not allowed as a delimiter')
          err_ws_delim:
            self.'panic'('Whitespace character is not allowed as a delimiter')
          err_close:
            self.'panic'('Use of a closing delimiter for an opener is reserved')
        
.annotate 'line', 333
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quote_EXPR"  :subid("108_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_386
    .param pmc param_387 :slurpy
.annotate 'line', 395
    .lex "self", param_386
    .lex "@args", param_387
.annotate 'line', 396

            .local pmc self, cur_class, args
            self = find_lex 'self'
            cur_class = get_hll_global ['Regex'], 'Cursor'
            args = find_lex '@args'

            .local pmc cur, debug
            .local string target
            .local int pos

            (cur, pos, target) = self.'!cursor_start'()
            debug = getattribute cur, cur_class, '$!debug'
            if null debug goto debug_1
            cur.'!cursor_debug'('START', 'quote_EXPR')
          debug_1:

            .local pmc quotemod, true
            .lex '%*QUOTEMOD', quotemod
            quotemod = new ['Hash']

            true = box 1


          args_loop:
            unless args goto args_done
            .local string mod
            mod = shift args
            mod = substr mod, 1
            quotemod[mod] = true
            if mod == 'qq' goto opt_qq
            if mod == 'b' goto opt_b
            goto args_loop
          opt_qq:
            quotemod['s'] = true
            quotemod['a'] = true
            quotemod['h'] = true
            quotemod['f'] = true
            quotemod['c'] = true
            quotemod['b'] = true
          opt_b:
            quotemod['q'] = true
            goto args_loop
          args_done:


            .local pmc start, stop
            (start, stop) = self.'peek_delimiters'(target, pos)

            .lex '$*QUOTE_START', start
            .lex '$*QUOTE_STOP', stop

            $P10 = cur.'quote_delimited'()
            unless $P10 goto fail
            cur.'!mark_push'(0, CURSOR_FAIL, 0, $P10)
            $P10.'!cursor_names'('quote_delimited')
            pos = $P10.'pos'()
            cur.'!cursor_pass'(pos, 'quote_EXPR')
            if null debug goto done
            cur.'!cursor_debug'('PASS', 'quote_EXPR')
            goto done
          fail:
            if null debug goto done
            cur.'!cursor_debug'('FAIL', 'quote_EXPR')
          done:
            .return (cur)
        
.annotate 'line', 395
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "quotemod_check" :nsentry :subid("109_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_389
    .param pmc param_390
.annotate 'line', 464
    .lex "self", param_389
    .lex "$mod", param_390
    find_lex $P391, "$mod"
    find_dynamic_lex $P392, "%*QUOTEMOD"
    unless_null $P392, vivify_283
    get_hll_global $P392, "%QUOTEMOD"
    unless_null $P392, vivify_284
    die "Contextual %*QUOTEMOD not found"
  vivify_284:
  vivify_283:
    set $P393, $P392[$P391]
    unless_null $P393, vivify_285
    new $P393, "Undef"
  vivify_285:
    .return ($P393)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "starter"  :subid("110_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_395
.annotate 'line', 468
    .lex "self", param_395
.annotate 'line', 469

            .local pmc self, cur
            .local string target, start
            .local int pos
            self = find_lex 'self'

            (cur, pos, target) = self.'!cursor_start'()

            $P0 = find_dynamic_lex '$*QUOTE_START'
            if null $P0 goto fail
            start = $P0

            $I0 = length start
            $S0 = substr target, pos, $I0
            unless $S0 == start goto fail
            pos += $I0
            cur.'!cursor_pass'(pos, 'starter')
          fail:
            .return (cur)
        
.annotate 'line', 468
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "stopper"  :subid("111_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_397
.annotate 'line', 491
    .lex "self", param_397
.annotate 'line', 492

            .local pmc self, cur
            .local string target, stop
            .local int pos
            self = find_lex 'self'

            (cur, pos, target) = self.'!cursor_start'()

            $P0 = find_dynamic_lex '$*QUOTE_STOP'
            if null $P0 goto fail
            stop = $P0

            $I0 = length stop
            $S0 = substr target, pos, $I0
            unless $S0 == stop goto fail
            pos += $I0
            cur.'!cursor_pass'(pos, 'stopper')
          fail:
            .return (cur)
        
.annotate 'line', 491
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "split_words" :nsentry :subid("112_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_399
    .param pmc param_400
.annotate 'line', 514
    .lex "self", param_399
    .lex "$words", param_400
.annotate 'line', 515

            .local string words
            $P0 = find_lex '$words'
            words = $P0
            .local int pos, eos
            .local pmc result
            pos = 0
            eos = length words
            result = new ['ResizablePMCArray']
          split_loop:
            pos = find_not_cclass .CCLASS_WHITESPACE, words, pos, eos
            unless pos < eos goto split_done
            $I0 = find_cclass .CCLASS_WHITESPACE, words, pos, eos
            $I1 = $I0 - pos
            $S0 = substr words, pos, $I1
            push result, $S0
            pos = $I0
            goto split_loop
          split_done:
            .return (result)
        
.annotate 'line', 514
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "EXPR"  :subid("113_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_402
    .param pmc param_403 :optional
    .param int has_param_403 :opt_flag
.annotate 'line', 546
    .lex "self", param_402
    if has_param_403, optparam_286
    new $P404, "String"
    assign $P404, ""
    set param_403, $P404
  optparam_286:
    .lex "$preclim", param_403
.annotate 'line', 547

            .local pmc self, cur_class
            self = find_lex 'self'
            cur_class = get_hll_global ['Regex'], 'Cursor'

            .local string preclim
            $P0 = find_lex '$preclim'
            preclim = $P0
            
            .local pmc here, debug
            .local int pos
            (here, pos) = self.'!cursor_start'()
            debug = getattribute here, cur_class, '$!debug'
            if null debug goto debug_1
            here.'!cursor_debug'('START', 'EXPR')
          debug_1:

            .const 'Sub' reduce = 'EXPR_reduce'
            .local string termishrx
            termishrx = 'termish'

            .local pmc opstack, termstack
            opstack = new ['ResizablePMCArray']
            .lex '@opstack', opstack
            termstack = new ['ResizablePMCArray']
            .lex '@termstack', termstack

          term_loop:
            here = here.termishrx()
            unless here goto fail
            .local pmc termish
            termish = here.'MATCH'()

            # interleave any prefix/postfix we might have found
            .local pmc termOPER, prefixish, postfixish
            termOPER = termish
          termOPER_loop:
            $I0 = exists termOPER['OPER']
            unless $I0 goto termOPER_done
            termOPER = termOPER['OPER']
            goto termOPER_loop
          termOPER_done:
            prefixish = termOPER['prefixish']
            postfixish = termOPER['postfixish']
            if null prefixish goto prefix_done

          prepostfix_loop:
            unless prefixish goto prepostfix_done
            unless postfixish goto prepostfix_done
            .local pmc preO, postO
            .local string preprec, postprec
            $P0 = prefixish[0]
            $P0 = $P0['OPER']
            preO = $P0['O']
            preprec = preO['prec']
            $P0 = postfixish[-1]
            $P0 = $P0['OPER']
            postO = $P0['O']
            postprec = postO['prec']
            if postprec < preprec goto post_shift
            if postprec > preprec goto pre_shift
            $S0 = postO['uassoc']
            if $S0 == 'right' goto pre_shift
          post_shift:
            $P0 = pop postfixish
            push opstack, $P0
            goto prepostfix_loop
          pre_shift:
            $P0 = shift prefixish
            push opstack, $P0
            goto prepostfix_loop
          prepostfix_done:

          prefix_loop:
            unless prefixish goto prefix_done
            $P0 = shift prefixish
            push opstack, $P0
            goto prefix_loop
          prefix_done:
            delete termish['prefixish']

          postfix_loop:
            if null postfixish goto postfix_done
            unless postfixish goto postfix_done
            $P0 = pop postfixish
            push opstack, $P0
            goto postfix_loop
          postfix_done:
            delete termish['postfixish']

            $P0 = termish['term']
            push termstack, $P0

            # Now see if we can fetch an infix operator
            .local pmc infixcur, infix
            here = here.'ws'()
            infixcur = here.'infixish'()
            unless infixcur goto term_done
            infix = infixcur.'MATCH'()

            .local pmc inO
            $P0 = infix['OPER']
            inO = $P0['O']
            termishrx = inO['nextterm']
            if termishrx goto have_termishrx
            termishrx = 'termish'
          have_termishrx:

            .local string inprec, inassoc, opprec
            inprec = inO['prec']
            unless inprec goto err_inprec
            if inprec <= preclim goto term_done
            inassoc = inO['assoc']

            $P0 = inO['sub']
            if null $P0 goto subprec_done
            inO['prec'] = $P0
          subprec_done:

          reduce_loop:
            unless opstack goto reduce_done
            $P0 = opstack[-1]
            $P0 = $P0['OPER']
            $P0 = $P0['O']
            opprec = $P0['prec']
            unless opprec > inprec goto reduce_gt_done
            capture_lex reduce
            self.reduce(termstack, opstack)
            goto reduce_loop
          reduce_gt_done:

            unless opprec == inprec goto reduce_done
            # equal precedence, use associativity to decide
            unless inassoc == 'left' goto reduce_done
            # left associative, reduce immediately
            capture_lex reduce
            self.reduce(termstack, opstack)
          reduce_done:

            push opstack, infix        # The Shift
            here = infixcur.'ws'()
            goto term_loop
          term_done:

          opstack_loop:
            unless opstack goto opstack_done
            capture_lex reduce
            self.reduce(termstack, opstack)
            goto opstack_loop
          opstack_done:

          expr_done:
            .local pmc term
            term = pop termstack
            pos = here.'pos'()
            here = self.'!cursor_start'()
            repr_bind_attr_int here, cur_class, '$!pos', pos
            setattribute here, cur_class, '$!match', term
            here.'!reduce'('EXPR')
            if null debug goto done
            here.'!cursor_debug'('PASS', 'EXPR')
            goto done

          fail:
            if null debug goto done
            here.'!cursor_debug'('FAIL', 'EXPR')
          done:
            .return (here)

          err_internal:
            $I0 = termstack
            here.'panic'('Internal operator parser error, @termstack == ', $I0)
          err_inprec:
            infixcur.'panic'('Missing infixish operator precedence')
        
.annotate 'line', 546
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "EXPR_reduce"  :subid("114_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_406
    .param pmc param_407
    .param pmc param_408
.annotate 'line', 724
    .lex "self", param_406
    .lex "$termstack", param_407
    .lex "$opstack", param_408
.annotate 'line', 725

            .local pmc self, termstack, opstack
            self = find_lex 'self'
            termstack = find_lex '$termstack'
            opstack = find_lex '$opstack'

            .local pmc op, opOPER, opO
            .local string opassoc
            op = pop opstack
            opOPER = op['OPER']
            opO = opOPER['O']
            opassoc = opO['assoc']
            if opassoc == 'unary' goto op_unary
            if opassoc == 'list' goto op_list
          op_infix:
            .local pmc right, left
            right = pop termstack
            left = pop termstack
            op[0] = left
            op[1] = right
            $S0 = opO['reducecheck']
            unless $S0 goto op_infix_1
            self.$S0(op)
          op_infix_1:
            self.'!reduce'('EXPR', 'INFIX', op)
            goto done

          op_unary:
            .local pmc arg, afrom, ofrom
            arg = pop termstack
            op[0] = arg
            afrom = arg.'from'()
            ofrom = op.'from'()
            if afrom < ofrom goto op_postfix
          op_prefix:
            self.'!reduce'('EXPR', 'PREFIX', op)
            goto done
          op_postfix:
            self.'!reduce'('EXPR', 'POSTFIX', op)
            goto done

          op_list:
            .local string sym
            sym = opOPER['sym']
            arg = pop termstack
            unshift op, arg
          op_sym_loop:
            unless opstack goto op_sym_done
            $P0 = opstack[-1]
            $P0 = $P0['OPER']
            $S0 = $P0['sym']
            if sym != $S0 goto op_sym_done
            arg = pop termstack
            unshift op, arg
            $P0 = pop opstack
            goto op_sym_loop
          op_sym_done:
            arg = pop termstack
            unshift op, arg
            self.'!reduce'('EXPR', 'LIST', op)
            goto done

          done:
            push termstack, op
        
.annotate 'line', 724
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "ternary"  :subid("115_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_410
    .param pmc param_411
.annotate 'line', 792
    .lex "self", param_410
    .lex "$match", param_411
.annotate 'line', 793
    find_lex $P412, "$match"
    unless_null $P412, vivify_287
    $P412 = root_new ['parrot';'ResizablePMCArray']
  vivify_287:
    set $P413, $P412[1]
    unless_null $P413, vivify_288
    new $P413, "Undef"
  vivify_288:
    find_lex $P414, "$match"
    unless_null $P414, vivify_289
    $P414 = root_new ['parrot';'ResizablePMCArray']
    store_lex "$match", $P414
  vivify_289:
    set $P414[2], $P413
.annotate 'line', 794
    find_lex $P415, "$match"
    unless_null $P415, vivify_290
    $P415 = root_new ['parrot';'Hash']
  vivify_290:
    set $P416, $P415["infix"]
    unless_null $P416, vivify_291
    $P416 = root_new ['parrot';'Hash']
  vivify_291:
    set $P417, $P416["EXPR"]
    unless_null $P417, vivify_292
    new $P417, "Undef"
  vivify_292:
    find_lex $P418, "$match"
    unless_null $P418, vivify_293
    $P418 = root_new ['parrot';'ResizablePMCArray']
    store_lex "$match", $P418
  vivify_293:
    set $P418[1], $P417
.annotate 'line', 792
    .return ($P417)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "MARKER"  :subid("116_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_420
    .param pmc param_421
.annotate 'line', 797
    .lex "self", param_420
    .lex "$markname", param_421
.annotate 'line', 798
    new $P422, "Undef"
    .lex "$pos", $P422
.annotate 'line', 800
    $P423 = root_new ['parrot';'Hash']
    .lex "%markhash", $P423
.annotate 'line', 798
    find_lex $P424, "self"
    $P425 = $P424."pos"()
    store_lex "$pos", $P425
.annotate 'line', 799
    find_lex $P426, "self"
    find_lex $P427, "$markname"
    find_lex $P428, "$pos"
    $P426."!cursor_debug"("START", "MARKER name=", $P427, ", pos=", $P428)
.annotate 'line', 800

            $P429 = get_global '%!MARKHASH'
            unless null $P429 goto have_markhash
            $P429 = new ['Hash']
            set_global '%!MARKHASH', $P429
          have_markhash:
        
    store_lex "%markhash", $P429
.annotate 'line', 807
    find_lex $P430, "$pos"
    find_lex $P431, "$markname"
    find_lex $P432, "%markhash"
    unless_null $P432, vivify_294
    $P432 = root_new ['parrot';'Hash']
    store_lex "%markhash", $P432
  vivify_294:
    set $P432[$P431], $P430
.annotate 'line', 808
    find_lex $P433, "self"
    $P433."!cursor_debug"("PASS", "MARKER")
.annotate 'line', 797
    .return (1)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "MARKED"  :subid("117_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_435
    .param pmc param_436
.annotate 'line', 812
    .lex "self", param_435
    .lex "$markname", param_436
.annotate 'line', 813
    find_lex $P437, "self"
    find_lex $P438, "$markname"
    $P437."!cursor_debug"("START", "MARKED name=", $P438)
.annotate 'line', 814

            .local pmc self, markname, markhash
            self = find_lex 'self'
            markname = find_lex '$markname'
            markhash = get_global '%!MARKHASH'
            if null markhash goto fail
            $P0 = markhash[markname]
            if null $P0 goto fail
            $P1 = self.'pos'()
            unless $P0 == $P1 goto fail
            self.'!cursor_debug'('PASS','MARKED')
            .return (1)
          fail:
            self.'!cursor_debug'('FAIL','MARKED')
            .return (0)
        
.annotate 'line', 812
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "LANG"  :subid("118_1299602516.087") :outer("11_1299602516.087")
    .param pmc param_440
    .param pmc param_441
    .param pmc param_442
.annotate 'line', 832
    .lex "self", param_440
    .lex "$lang", param_441
    .lex "$regex", param_442
.annotate 'line', 833
    new $P443, "Undef"
    .lex "$lang_cursor", $P443
.annotate 'line', 834
    new $P444, "Undef"
    .lex "$*ACTIONS", $P444
.annotate 'line', 835
    new $P445, "Undef"
    .lex "$cur", $P445
.annotate 'line', 833
    find_lex $P446, "$lang"
    find_dynamic_lex $P447, "%*LANG"
    unless_null $P447, vivify_295
    get_hll_global $P447, "%LANG"
    unless_null $P447, vivify_296
    die "Contextual %*LANG not found"
  vivify_296:
  vivify_295:
    set $P448, $P447[$P446]
    unless_null $P448, vivify_297
    new $P448, "Undef"
  vivify_297:
    store_lex "$lang_cursor", $P448
.annotate 'line', 834
    find_lex $P449, "$lang"
    concat $P450, $P449, "-actions"
    find_dynamic_lex $P451, "%*LANG"
    unless_null $P451, vivify_298
    get_hll_global $P451, "%LANG"
    unless_null $P451, vivify_299
    die "Contextual %*LANG not found"
  vivify_299:
  vivify_298:
    set $P452, $P451[$P450]
    unless_null $P452, vivify_300
    new $P452, "Undef"
  vivify_300:
    store_lex "$*ACTIONS", $P452
.annotate 'line', 835

            .local pmc self
            .local int pos
            self = find_lex 'self'
            $P0 = find_lex '$lang_cursor'
            ($P453, pos) = self.'!cursor_start'($P0)
            $P453.'!cursor_pos'(pos)
        
    store_lex "$cur", $P453
.annotate 'line', 843
    find_lex $P454, "$cur"
    find_lex $P455, "$regex"
    set $S456, $P455
    $P457 = $P454.$S456()
.annotate 'line', 832
    .return ($P457)
.end


.HLL "nqp"

.namespace ["HLL";"Grammar"]
.sub "_block459" :load :anon :subid("119_1299602516.087")
.annotate 'line', 3
    .const 'Sub' $P461 = "11_1299602516.087" 
    $P462 = $P461()
    .return ($P462)
.end


.HLL "nqp"

.namespace []
.sub "_block685" :load :anon :subid("121_1299602516.087")
.annotate 'line', 1
    .const 'Sub' $P687 = "10_1299602516.087" 
    $P688 = $P687()
    .return ($P688)
.end

### .include 'src/cheats/hll-grammar.pir'
# Copyright (C) 2009, The Perl Foundation.

=head1 TITLE

src/cheats/hll-grammar.pir -- Additional HLL::Grammar methods

=head2 Methods

=over 4

=cut

.namespace ['HLL';'Grammar']

.sub '' :load :init
    .local pmc brackets
    brackets = box unicode:"<>[](){}\xab\xbb\u0f3a\u0f3b\u0f3c\u0f3d\u169b\u169c\u2045\u2046\u207d\u207e\u208d\u208e\u2329\u232a\u2768\u2769\u276a\u276b\u276c\u276d\u276e\u276f\u2770\u2771\u2772\u2773\u2774\u2775\u27c5\u27c6\u27e6\u27e7\u27e8\u27e9\u27ea\u27eb\u2983\u2984\u2985\u2986\u2987\u2988\u2989\u298a\u298b\u298c\u298d\u298e\u298f\u2990\u2991\u2992\u2993\u2994\u2995\u2996\u2997\u2998\u29d8\u29d9\u29da\u29db\u29fc\u29fd\u3008\u3009\u300a\u300b\u300c\u300d\u300e\u300f\u3010\u3011\u3014\u3015\u3016\u3017\u3018\u3019\u301a\u301b\u301d\u301e\ufd3e\ufd3f\ufe17\ufe18\ufe35\ufe36\ufe37\ufe38\ufe39\ufe3a\ufe3b\ufe3c\ufe3d\ufe3e\ufe3f\ufe40\ufe41\ufe42\ufe43\ufe44\ufe47\ufe48\ufe59\ufe5a\ufe5b\ufe5c\ufe5d\ufe5e\uff08\uff09\uff3b\uff3d\uff5b\uff5d\uff5f\uff60\uff62\uff63"
    set_global '$!brackets', brackets
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

### .include 'gen/hllgrammar-actions.pir'

.HLL "nqp"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.namespace []
.sub "_block11"  :anon :subid("10_1299602518.024")
.annotate 'line', 0
    get_hll_global $P18, ["HLL";"Actions"], "_block17" 
    capture_lex $P18
.annotate 'line', 1
    getinterp $P13
    get_class $P14, "LexPad"
    get_class $P15, "NQPLexPad"
    $P13."hll_map"($P14, $P15)
    get_hll_global $P16, ["HLL"], "Actions"
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
.annotate 'line', 3
    get_hll_global $P18, ["HLL";"Actions"], "_block17" 
    capture_lex $P18
    $P653 = $P18()
.annotate 'line', 1
    .return ($P653)
    .const 'Sub' $P655 = "56_1299602518.024" 
    .return ($P655)
.end


.HLL "nqp"

.namespace []
.sub "" :load :init :subid("post57") :outer("10_1299602518.024")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1299602518.024" 
    .local pmc block
    set block, $P12
    nqp_get_sc $P659, "1299602516.9"
    isnull $I660, $P659
    if $I660, if_658
    goto if_658_end
  if_658:
    nqp_dynop_setup 
    load_bytecode "nqpmo.pbc"
    nqp_create_sc $P661, "1299602516.9"
    .local pmc cur_sc
    set cur_sc, $P661
    load_bytecode "SettingManager.pbc"
    get_hll_global $P662, ["HLL"], "SettingManager"
    $P663 = $P662."load_setting"("NQPCORE")
    block."set_outer_ctx"($P663)
    get_hll_global $P664, "NQPClassHOW"
    $P665 = $P664."new_type"("HLL::Actions" :named("name"))
    nqp_set_sc_for_object $P665, cur_sc
    nqp_set_sc_object "1299602516.9", 0, $P665
  if_658_end:
.end


.HLL "nqp"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.namespace ["HLL";"Actions"]
.sub "_block17"  :subid("11_1299602518.024") :outer("10_1299602518.024")
.annotate 'line', 3
    .const 'Sub' $P585 = "55_1299602518.024" 
    capture_lex $P585
    .const 'Sub' $P554 = "53_1299602518.024" 
    capture_lex $P554
    .const 'Sub' $P531 = "51_1299602518.024" 
    capture_lex $P531
    .const 'Sub' $P503 = "50_1299602518.024" 
    capture_lex $P503
    .const 'Sub' $P486 = "49_1299602518.024" 
    capture_lex $P486
    .const 'Sub' $P481 = "48_1299602518.024" 
    capture_lex $P481
    .const 'Sub' $P473 = "47_1299602518.024" 
    capture_lex $P473
    .const 'Sub' $P458 = "46_1299602518.024" 
    capture_lex $P458
    .const 'Sub' $P443 = "45_1299602518.024" 
    capture_lex $P443
    .const 'Sub' $P438 = "44_1299602518.024" 
    capture_lex $P438
    .const 'Sub' $P433 = "43_1299602518.024" 
    capture_lex $P433
    .const 'Sub' $P428 = "42_1299602518.024" 
    capture_lex $P428
    .const 'Sub' $P423 = "41_1299602518.024" 
    capture_lex $P423
    .const 'Sub' $P418 = "40_1299602518.024" 
    capture_lex $P418
    .const 'Sub' $P413 = "39_1299602518.024" 
    capture_lex $P413
    .const 'Sub' $P405 = "38_1299602518.024" 
    capture_lex $P405
    .const 'Sub' $P400 = "37_1299602518.024" 
    capture_lex $P400
    .const 'Sub' $P386 = "36_1299602518.024" 
    capture_lex $P386
    .const 'Sub' $P313 = "34_1299602518.024" 
    capture_lex $P313
    .const 'Sub' $P252 = "31_1299602518.024" 
    capture_lex $P252
    .const 'Sub' $P245 = "30_1299602518.024" 
    capture_lex $P245
    .const 'Sub' $P238 = "29_1299602518.024" 
    capture_lex $P238
    .const 'Sub' $P231 = "28_1299602518.024" 
    capture_lex $P231
    .const 'Sub' $P224 = "27_1299602518.024" 
    capture_lex $P224
    .const 'Sub' $P217 = "26_1299602518.024" 
    capture_lex $P217
    .const 'Sub' $P209 = "25_1299602518.024" 
    capture_lex $P209
    .const 'Sub' $P201 = "24_1299602518.024" 
    capture_lex $P201
    .const 'Sub' $P195 = "23_1299602518.024" 
    capture_lex $P195
    .const 'Sub' $P187 = "22_1299602518.024" 
    capture_lex $P187
    .const 'Sub' $P179 = "21_1299602518.024" 
    capture_lex $P179
    .const 'Sub' $P77 = "18_1299602518.024" 
    capture_lex $P77
    .const 'Sub' $P41 = "15_1299602518.024" 
    capture_lex $P41
    .const 'Sub' $P36 = "14_1299602518.024" 
    capture_lex $P36
    .const 'Sub' $P29 = "13_1299602518.024" 
    capture_lex $P29
    .const 'Sub' $P23 = "12_1299602518.024" 
    capture_lex $P23
    get_global $P19, "$?CLASS"
    getinterp $P20
    get_class $P21, "LexPad"
    get_class $P22, "NQPLexPad"
    $P20."hll_map"($P21, $P22)
    .const 'Sub' $P23 = "12_1299602518.024" 
    newclosure $P27, $P23
    .lex "string_to_int", $P27
    find_lex $P28, "string_to_int"
    set_global "string_to_int", $P28
.annotate 'line', 37
    .const 'Sub' $P29 = "13_1299602518.024" 
    newclosure $P32, $P29
    .lex "ints_to_string", $P32
.annotate 'line', 3
    find_lex $P33, "ints_to_string"
    set_global "ints_to_string", $P33
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    find_lex $P34, "string_to_int"
    find_lex $P35, "ints_to_string"
.annotate 'line', 225
    .const 'Sub' $P554 = "53_1299602518.024" 
    newclosure $P569, $P554
.annotate 'line', 3
    .return ($P569)
    .const 'Sub' $P571 = "54_1299602518.024" 
    .return ($P571)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "" :load :init :subid("post58") :outer("11_1299602518.024")
.annotate 'line', 3
    get_hll_global $P18, ["HLL";"Actions"], "_block17" 
    .local pmc block
    set block, $P18
    .const 'Sub' $P574 = "12_1299602518.024" 
    set_global "string_to_int", $P574
    .const 'Sub' $P575 = "13_1299602518.024" 
    set_global "ints_to_string", $P575
    nqp_get_sc $P577, "1299602516.9"
    isnull $I578, $P577
    if $I578, if_576
    goto if_576_end
  if_576:
    nqp_dynop_setup 
    load_bytecode "nqpmo.pbc"
    nqp_create_sc $P579, "1299602516.9"
    .local pmc cur_sc
    set cur_sc, $P579
    load_bytecode "SettingManager.pbc"
    get_hll_global $P580, ["HLL"], "SettingManager"
    $P581 = $P580."load_setting"("NQPCORE")
    block."set_outer_ctx"($P581)
    get_hll_global $P582, "NQPClassHOW"
    $P583 = $P582."new_type"("HLL::Actions" :named("name"))
    nqp_set_sc_for_object $P583, cur_sc
    nqp_set_sc_object "1299602516.9", 0, $P583
  if_576_end:
    .const 'Sub' $P585 = "55_1299602518.024" 
    capture_lex $P585
    $P585()
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block584"  :anon :subid("55_1299602518.024") :outer("11_1299602518.024")
.annotate 'line', 3
    nqp_get_sc_object $P586, "1299602516.9", 0
    .local pmc type_obj
    set type_obj, $P586
    set_hll_global ["HLL"], "Actions", type_obj
    set_global "$?CLASS", type_obj
    get_how $P587, type_obj
    .const 'Sub' $P588 = "14_1299602518.024" 
    $P587."add_method"(type_obj, "CTXSAVE", $P588)
    get_how $P589, type_obj
    .const 'Sub' $P590 = "15_1299602518.024" 
    $P589."add_method"(type_obj, "SET_BLOCK_OUTER_CTX", $P590)
    get_how $P591, type_obj
    .const 'Sub' $P592 = "18_1299602518.024" 
    $P591."add_method"(type_obj, "EXPR", $P592)
    get_how $P593, type_obj
    .const 'Sub' $P594 = "21_1299602518.024" 
    $P593."add_method"(type_obj, "term:sym<circumfix>", $P594)
    get_how $P595, type_obj
    .const 'Sub' $P596 = "22_1299602518.024" 
    $P595."add_method"(type_obj, "termish", $P596)
    get_how $P597, type_obj
    .const 'Sub' $P598 = "23_1299602518.024" 
    $P597."add_method"(type_obj, "nullterm", $P598)
    get_how $P599, type_obj
    .const 'Sub' $P600 = "24_1299602518.024" 
    $P599."add_method"(type_obj, "nullterm_alt", $P600)
    get_how $P601, type_obj
    .const 'Sub' $P602 = "25_1299602518.024" 
    $P601."add_method"(type_obj, "integer", $P602)
    get_how $P603, type_obj
    .const 'Sub' $P604 = "26_1299602518.024" 
    $P603."add_method"(type_obj, "dec_number", $P604)
    get_how $P605, type_obj
    .const 'Sub' $P606 = "27_1299602518.024" 
    $P605."add_method"(type_obj, "decint", $P606)
    get_how $P607, type_obj
    .const 'Sub' $P608 = "28_1299602518.024" 
    $P607."add_method"(type_obj, "hexint", $P608)
    get_how $P609, type_obj
    .const 'Sub' $P610 = "29_1299602518.024" 
    $P609."add_method"(type_obj, "octint", $P610)
    get_how $P611, type_obj
    .const 'Sub' $P612 = "30_1299602518.024" 
    $P611."add_method"(type_obj, "binint", $P612)
    get_how $P613, type_obj
    .const 'Sub' $P614 = "31_1299602518.024" 
    $P613."add_method"(type_obj, "quote_EXPR", $P614)
    get_how $P615, type_obj
    .const 'Sub' $P616 = "34_1299602518.024" 
    $P615."add_method"(type_obj, "quote_delimited", $P616)
    get_how $P617, type_obj
    .const 'Sub' $P618 = "36_1299602518.024" 
    $P617."add_method"(type_obj, "quote_atom", $P618)
    get_how $P619, type_obj
    .const 'Sub' $P620 = "37_1299602518.024" 
    $P619."add_method"(type_obj, "quote_escape:sym<backslash>", $P620)
    get_how $P621, type_obj
    .const 'Sub' $P622 = "38_1299602518.024" 
    $P621."add_method"(type_obj, "quote_escape:sym<stopper>", $P622)
    get_how $P623, type_obj
    .const 'Sub' $P624 = "39_1299602518.024" 
    $P623."add_method"(type_obj, "quote_escape:sym<bs>", $P624)
    get_how $P625, type_obj
    .const 'Sub' $P626 = "40_1299602518.024" 
    $P625."add_method"(type_obj, "quote_escape:sym<nl>", $P626)
    get_how $P627, type_obj
    .const 'Sub' $P628 = "41_1299602518.024" 
    $P627."add_method"(type_obj, "quote_escape:sym<cr>", $P628)
    get_how $P629, type_obj
    .const 'Sub' $P630 = "42_1299602518.024" 
    $P629."add_method"(type_obj, "quote_escape:sym<tab>", $P630)
    get_how $P631, type_obj
    .const 'Sub' $P632 = "43_1299602518.024" 
    $P631."add_method"(type_obj, "quote_escape:sym<ff>", $P632)
    get_how $P633, type_obj
    .const 'Sub' $P634 = "44_1299602518.024" 
    $P633."add_method"(type_obj, "quote_escape:sym<esc>", $P634)
    get_how $P635, type_obj
    .const 'Sub' $P636 = "45_1299602518.024" 
    $P635."add_method"(type_obj, "quote_escape:sym<hex>", $P636)
    get_how $P637, type_obj
    .const 'Sub' $P638 = "46_1299602518.024" 
    $P637."add_method"(type_obj, "quote_escape:sym<oct>", $P638)
    get_how $P639, type_obj
    .const 'Sub' $P640 = "47_1299602518.024" 
    $P639."add_method"(type_obj, "quote_escape:sym<chr>", $P640)
    get_how $P641, type_obj
    .const 'Sub' $P642 = "48_1299602518.024" 
    $P641."add_method"(type_obj, "quote_escape:sym<0>", $P642)
    get_how $P643, type_obj
    .const 'Sub' $P644 = "49_1299602518.024" 
    $P643."add_method"(type_obj, "quote_escape:sym<misc>", $P644)
    get_how $P645, type_obj
    .const 'Sub' $P646 = "50_1299602518.024" 
    $P645."add_method"(type_obj, "charname", $P646)
    get_how $P647, type_obj
    .const 'Sub' $P648 = "51_1299602518.024" 
    $P647."add_method"(type_obj, "charnames", $P648)
    get_how $P649, type_obj
    .const 'Sub' $P650 = "53_1299602518.024" 
    $P649."add_method"(type_obj, "charspec", $P650)
    get_how $P651, type_obj
    $P652 = $P651."compose"(type_obj)
    .return ($P652)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "string_to_int"  :subid("12_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_24
    .param pmc param_25
.annotate 'line', 3
    .lex "$src", param_24
    .lex "$base", param_25
.annotate 'line', 4

        .local pmc src
        .local string src_s
        src = find_lex '$src'
        src_s = src
        .local int base, pos, eos, result
        $P0 = find_lex '$base'
        base = $P0
        pos = 0
        eos = length src_s
        result = 0
      str_loop:
        unless pos < eos goto str_done
        .local string char
        char = substr src_s, pos, 1
        if char == '_' goto str_next
        .local int digitval
        digitval = index "00112233445566778899AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz", char
        if digitval < 0 goto err_base
        digitval >>= 1
        if digitval >= base goto err_base
        result *= base
        result += digitval
      str_next:
        inc pos
        goto str_loop
      err_base:
	src.'panic'('Invalid radix conversion of "', char, '"')
      str_done:
        $P26 = box result
    
.annotate 'line', 3
    .return ($P26)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "ints_to_string"  :subid("13_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_30
.annotate 'line', 37
    .lex "$ints", param_30
.annotate 'line', 38

        .local string result
        result = ''
        .local pmc ints, ints_it
        ints = find_lex '$ints'
        $I0 = does ints, 'array'
        unless $I0 goto ints_1
        ints_it = iter ints
      ints_loop:
        unless ints_it goto ints_done
        $P0 = shift ints_it
        $I0 = $P0.'ast'()
        $S0 = chr $I0
        result = concat result, $S0
        goto ints_loop
      ints_1:
        $I0 = ints.'ast'()
        result = chr $I0
      ints_done:
        $P31 = box result
    
.annotate 'line', 37
    .return ($P31)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "CTXSAVE"  :subid("14_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_37
.annotate 'line', 62
    .lex "self", param_37
.annotate 'line', 63
    get_hll_global $P38, ["PAST"], "Op"
.annotate 'line', 69
    new $P39, "ResizablePMCArray"
    push $P39, "    $P0 = find_dynamic_lex \"$*CTXSAVE\""
    push $P39, "    if null $P0 goto ctxsave_done"
    push $P39, "    $I0 = can $P0, \"ctxsave\""
    push $P39, "    unless $I0 goto ctxsave_done"
    push $P39, "    $P0.\"ctxsave\"()"
    push $P39, "  ctxsave_done:"
    $P40 = $P38."new"($P39 :named("inline"))
.annotate 'line', 62
    .return ($P40)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "SET_BLOCK_OUTER_CTX"  :subid("15_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_42
    .param pmc param_43
.annotate 'line', 76
    .const 'Sub' $P53 = "16_1299602518.024" 
    capture_lex $P53
    .lex "self", param_42
    .lex "$block", param_43
.annotate 'line', 77
    new $P44, "Undef"
    .lex "$outer_ctx", $P44
    find_dynamic_lex $P45, "%*COMPILING"
    unless_null $P45, vivify_59
    get_hll_global $P45, "%COMPILING"
    unless_null $P45, vivify_60
    die "Contextual %*COMPILING not found"
  vivify_60:
  vivify_59:
    set $P46, $P45["%?OPTIONS"]
    unless_null $P46, vivify_61
    $P46 = root_new ['parrot';'Hash']
  vivify_61:
    set $P47, $P46["outer_ctx"]
    unless_null $P47, vivify_62
    new $P47, "Undef"
  vivify_62:
    store_lex "$outer_ctx", $P47
.annotate 'line', 78
    find_lex $P50, "$outer_ctx"
    defined $I51, $P50
    if $I51, if_49
    new $P48, 'Integer'
    set $P48, $I51
    goto if_49_end
  if_49:
    .const 'Sub' $P53 = "16_1299602518.024" 
    capture_lex $P53
    $P76 = $P53()
    set $P48, $P76
  if_49_end:
.annotate 'line', 76
    .return ($P48)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.include "except_types.pasm"
.sub "_block52"  :anon :subid("16_1299602518.024") :outer("15_1299602518.024")
.annotate 'line', 78
    .const 'Sub' $P67 = "17_1299602518.024" 
    capture_lex $P67
.annotate 'line', 79
    $P54 = root_new ['parrot';'ResizablePMCArray']
    .lex "@ns", $P54
    find_lex $P55, "$outer_ctx"
    getattribute $P56, $P55, "current_namespace"
    $P57 = $P56."get_name"()
    store_lex "@ns", $P57
.annotate 'line', 80
    find_lex $P58, "@ns"
    $P58."shift"()
.annotate 'line', 81
    find_lex $P59, "$block"
    find_lex $P60, "@ns"
    $P59."namespace"($P60)
.annotate 'line', 82
    find_lex $P62, "$outer_ctx"
    $P63 = $P62."lexpad_full"()
    defined $I64, $P63
    unless $I64, for_undef_63
    iter $P61, $P63
    new $P74, 'ExceptionHandler'
    set_label $P74, loop73_handler
    $P74."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P74
  loop73_test:
    unless $P61, loop73_done
    shift $P65, $P61
  loop73_redo:
    .const 'Sub' $P67 = "17_1299602518.024" 
    capture_lex $P67
    $P67($P65)
  loop73_next:
    goto loop73_test
  loop73_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P75, exception, 'type'
    eq $P75, .CONTROL_LOOP_NEXT, loop73_next
    eq $P75, .CONTROL_LOOP_REDO, loop73_redo
  loop73_done:
    pop_eh 
  for_undef_63:
.annotate 'line', 78
    .return ($P61)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block66"  :anon :subid("17_1299602518.024") :outer("16_1299602518.024")
    .param pmc param_68
.annotate 'line', 82
    .lex "$_", param_68
.annotate 'line', 83
    find_lex $P69, "$block"
    find_lex $P70, "$_"
    $P71 = $P70."key"()
    $P72 = $P69."symbol"($P71, "lexical" :named("scope"))
.annotate 'line', 82
    .return ($P72)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.include "except_types.pasm"
.sub "EXPR"  :subid("18_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_80
    .param pmc param_81
    .param pmc param_82 :optional
    .param int has_param_82 :opt_flag
.annotate 'line', 89
    .const 'Sub' $P161 = "20_1299602518.024" 
    capture_lex $P161
    .const 'Sub' $P128 = "19_1299602518.024" 
    capture_lex $P128
    new $P79, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P79, control_78
    push_eh $P79
    .lex "self", param_80
    .lex "$/", param_81
    if has_param_82, optparam_64
    new $P83, "Undef"
    set param_82, $P83
  optparam_64:
    .lex "$key", param_82
.annotate 'line', 91
    new $P84, "Undef"
    .lex "$past", $P84
.annotate 'line', 90
    find_lex $P86, "$key"
    if $P86, unless_85_end
    new $P87, "Exception"
    set $P87['type'], .CONTROL_RETURN
    new $P88, "Integer"
    assign $P88, 0
    setattribute $P87, 'payload', $P88
    throw $P87
  unless_85_end:
.annotate 'line', 91
    find_lex $P90, "$/"
    $P91 = $P90."ast"()
    set $P89, $P91
    defined $I93, $P89
    if $I93, default_92
    find_lex $P94, "$/"
    unless_null $P94, vivify_65
    $P94 = root_new ['parrot';'Hash']
  vivify_65:
    set $P95, $P94["OPER"]
    unless_null $P95, vivify_66
    new $P95, "Undef"
  vivify_66:
    $P96 = $P95."ast"()
    set $P89, $P96
  default_92:
    store_lex "$past", $P89
.annotate 'line', 92
    find_lex $P98, "$past"
    if $P98, unless_97_end
.annotate 'line', 93
    get_hll_global $P99, ["PAST"], "Op"
    find_lex $P100, "$/"
    $P101 = $P99."new"($P100 :named("node"))
    store_lex "$past", $P101
.annotate 'line', 94
    find_lex $P103, "$/"
    unless_null $P103, vivify_67
    $P103 = root_new ['parrot';'Hash']
  vivify_67:
    set $P104, $P103["OPER"]
    unless_null $P104, vivify_68
    $P104 = root_new ['parrot';'Hash']
  vivify_68:
    set $P105, $P104["O"]
    unless_null $P105, vivify_69
    $P105 = root_new ['parrot';'Hash']
  vivify_69:
    set $P106, $P105["pasttype"]
    unless_null $P106, vivify_70
    new $P106, "Undef"
  vivify_70:
    if $P106, if_102
.annotate 'line', 95
    find_lex $P114, "$/"
    unless_null $P114, vivify_71
    $P114 = root_new ['parrot';'Hash']
  vivify_71:
    set $P115, $P114["OPER"]
    unless_null $P115, vivify_72
    $P115 = root_new ['parrot';'Hash']
  vivify_72:
    set $P116, $P115["O"]
    unless_null $P116, vivify_73
    $P116 = root_new ['parrot';'Hash']
  vivify_73:
    set $P117, $P116["pirop"]
    unless_null $P117, vivify_74
    new $P117, "Undef"
  vivify_74:
    unless $P117, if_113_end
    find_lex $P118, "$past"
    find_lex $P119, "$/"
    unless_null $P119, vivify_75
    $P119 = root_new ['parrot';'Hash']
  vivify_75:
    set $P120, $P119["OPER"]
    unless_null $P120, vivify_76
    $P120 = root_new ['parrot';'Hash']
  vivify_76:
    set $P121, $P120["O"]
    unless_null $P121, vivify_77
    $P121 = root_new ['parrot';'Hash']
  vivify_77:
    set $P122, $P121["pirop"]
    unless_null $P122, vivify_78
    new $P122, "Undef"
  vivify_78:
    set $S123, $P122
    $P118."pirop"($S123)
  if_113_end:
    goto if_102_end
  if_102:
.annotate 'line', 94
    find_lex $P107, "$past"
    find_lex $P108, "$/"
    unless_null $P108, vivify_79
    $P108 = root_new ['parrot';'Hash']
  vivify_79:
    set $P109, $P108["OPER"]
    unless_null $P109, vivify_80
    $P109 = root_new ['parrot';'Hash']
  vivify_80:
    set $P110, $P109["O"]
    unless_null $P110, vivify_81
    $P110 = root_new ['parrot';'Hash']
  vivify_81:
    set $P111, $P110["pasttype"]
    unless_null $P111, vivify_82
    new $P111, "Undef"
  vivify_82:
    set $S112, $P111
    $P107."pasttype"($S112)
  if_102_end:
.annotate 'line', 96
    find_lex $P125, "$past"
    $P126 = $P125."name"()
    if $P126, unless_124_end
    .const 'Sub' $P128 = "19_1299602518.024" 
    capture_lex $P128
    $P128()
  unless_124_end:
  unless_97_end:
.annotate 'line', 107
    find_lex $P148, "$key"
    set $S149, $P148
    iseq $I150, $S149, "POSTFIX"
    if $I150, if_147
.annotate 'line', 109
    find_lex $P156, "$/"
    $P157 = $P156."list"()
    defined $I158, $P157
    unless $I158, for_undef_86
    iter $P155, $P157
    new $P173, 'ExceptionHandler'
    set_label $P173, loop172_handler
    $P173."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P173
  loop172_test:
    unless $P155, loop172_done
    shift $P159, $P155
  loop172_redo:
    .const 'Sub' $P161 = "20_1299602518.024" 
    capture_lex $P161
    $P161($P159)
  loop172_next:
    goto loop172_test
  loop172_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P174, exception, 'type'
    eq $P174, .CONTROL_LOOP_NEXT, loop172_next
    eq $P174, .CONTROL_LOOP_REDO, loop172_redo
  loop172_done:
    pop_eh 
  for_undef_86:
.annotate 'line', 108
    goto if_147_end
  if_147:
.annotate 'line', 107
    find_lex $P151, "$past"
    find_lex $P152, "$/"
    unless_null $P152, vivify_87
    $P152 = root_new ['parrot';'ResizablePMCArray']
  vivify_87:
    set $P153, $P152[0]
    unless_null $P153, vivify_88
    new $P153, "Undef"
  vivify_88:
    $P154 = $P153."ast"()
    $P151."unshift"($P154)
  if_147_end:
.annotate 'line', 111
    find_lex $P175, "$/"
    find_lex $P176, "$past"
    $P177 = $P175."!make"($P176)
.annotate 'line', 89
    .return ($P177)
  control_78:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P178, exception, "payload"
    .return ($P178)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block127"  :anon :subid("19_1299602518.024") :outer("18_1299602518.024")
.annotate 'line', 98
    new $P129, "Undef"
    .lex "$name", $P129
.annotate 'line', 97
    find_lex $P131, "$key"
    set $S132, $P131
    iseq $I133, $S132, "LIST"
    unless $I133, if_130_end
    new $P134, "String"
    assign $P134, "infix"
    store_lex "$key", $P134
  if_130_end:
.annotate 'line', 98

                $P0 = find_lex '$key'
                $S0 = $P0
                $S0 = downcase $S0
                $P135 = box $S0
            
    concat $P136, $P135, ":<"
.annotate 'line', 103
    find_lex $P137, "$/"
    unless_null $P137, vivify_83
    $P137 = root_new ['parrot';'Hash']
  vivify_83:
    set $P138, $P137["OPER"]
    unless_null $P138, vivify_84
    $P138 = root_new ['parrot';'Hash']
  vivify_84:
    set $P139, $P138["sym"]
    unless_null $P139, vivify_85
    new $P139, "Undef"
  vivify_85:
    concat $P140, $P136, $P139
    concat $P141, $P140, ">"
    store_lex "$name", $P141
.annotate 'line', 104
    find_lex $P142, "$past"
    new $P143, "String"
    assign $P143, "&"
    find_lex $P144, "$name"
    concat $P145, $P143, $P144
    $P146 = $P142."name"($P145)
.annotate 'line', 96
    .return ($P146)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block160"  :anon :subid("20_1299602518.024") :outer("18_1299602518.024")
    .param pmc param_162
.annotate 'line', 109
    .lex "$_", param_162
    find_lex $P165, "$_"
    $P166 = $P165."ast"()
    defined $I167, $P166
    if $I167, if_164
    new $P163, 'Integer'
    set $P163, $I167
    goto if_164_end
  if_164:
    find_lex $P168, "$past"
    find_lex $P169, "$_"
    $P170 = $P169."ast"()
    $P171 = $P168."push"($P170)
    set $P163, $P171
  if_164_end:
    .return ($P163)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "term:sym<circumfix>"  :subid("21_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_180
    .param pmc param_181
.annotate 'line', 114
    .lex "self", param_180
    .lex "$/", param_181
    find_lex $P182, "$/"
    find_lex $P183, "$/"
    unless_null $P183, vivify_89
    $P183 = root_new ['parrot';'Hash']
  vivify_89:
    set $P184, $P183["circumfix"]
    unless_null $P184, vivify_90
    new $P184, "Undef"
  vivify_90:
    $P185 = $P184."ast"()
    $P186 = $P182."!make"($P185)
    .return ($P186)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "termish"  :subid("22_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_188
    .param pmc param_189
.annotate 'line', 116
    .lex "self", param_188
    .lex "$/", param_189
    find_lex $P190, "$/"
    find_lex $P191, "$/"
    unless_null $P191, vivify_91
    $P191 = root_new ['parrot';'Hash']
  vivify_91:
    set $P192, $P191["term"]
    unless_null $P192, vivify_92
    new $P192, "Undef"
  vivify_92:
    $P193 = $P192."ast"()
    $P194 = $P190."!make"($P193)
    .return ($P194)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "nullterm"  :subid("23_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_196
    .param pmc param_197
.annotate 'line', 117
    .lex "self", param_196
    .lex "$/", param_197
    find_lex $P198, "$/"
 $P199 = new ['Undef'] 
    $P200 = $P198."!make"($P199)
    .return ($P200)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "nullterm_alt"  :subid("24_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_202
    .param pmc param_203
.annotate 'line', 118
    .lex "self", param_202
    .lex "$/", param_203
    find_lex $P204, "$/"
    find_lex $P205, "$/"
    unless_null $P205, vivify_93
    $P205 = root_new ['parrot';'Hash']
  vivify_93:
    set $P206, $P205["term"]
    unless_null $P206, vivify_94
    new $P206, "Undef"
  vivify_94:
    $P207 = $P206."ast"()
    $P208 = $P204."!make"($P207)
    .return ($P208)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "integer"  :subid("25_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_210
    .param pmc param_211
.annotate 'line', 120
    .lex "self", param_210
    .lex "$/", param_211
    find_lex $P212, "$/"
    find_lex $P213, "$/"
    unless_null $P213, vivify_95
    $P213 = root_new ['parrot';'Hash']
  vivify_95:
    set $P214, $P213["VALUE"]
    unless_null $P214, vivify_96
    new $P214, "Undef"
  vivify_96:
    $P215 = $P214."ast"()
    $P216 = $P212."!make"($P215)
    .return ($P216)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "dec_number"  :subid("26_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_218
    .param pmc param_219
.annotate 'line', 122
    .lex "self", param_218
    .lex "$/", param_219
    find_lex $P220, "$/"
    find_lex $P221, "$/"
    set $N222, $P221
    $P223 = $P220."!make"($N222)
    .return ($P223)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "decint"  :subid("27_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_225
    .param pmc param_226
.annotate 'line', 124
    .lex "self", param_225
    .lex "$/", param_226
    find_lex $P227, "$/"
    find_lex $P228, "$/"
    $P229 = "string_to_int"($P228, 10)
    $P230 = $P227."!make"($P229)
    .return ($P230)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "hexint"  :subid("28_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_232
    .param pmc param_233
.annotate 'line', 125
    .lex "self", param_232
    .lex "$/", param_233
    find_lex $P234, "$/"
    find_lex $P235, "$/"
    $P236 = "string_to_int"($P235, 16)
    $P237 = $P234."!make"($P236)
    .return ($P237)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "octint"  :subid("29_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_239
    .param pmc param_240
.annotate 'line', 126
    .lex "self", param_239
    .lex "$/", param_240
    find_lex $P241, "$/"
    find_lex $P242, "$/"
    $P243 = "string_to_int"($P242, 8)
    $P244 = $P241."!make"($P243)
    .return ($P244)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "binint"  :subid("30_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_246
    .param pmc param_247
.annotate 'line', 127
    .lex "self", param_246
    .lex "$/", param_247
    find_lex $P248, "$/"
    find_lex $P249, "$/"
    $P250 = "string_to_int"($P249, 2)
    $P251 = $P248."!make"($P250)
    .return ($P251)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_EXPR"  :subid("31_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_253
    .param pmc param_254
.annotate 'line', 129
    .const 'Sub' $P270 = "32_1299602518.024" 
    capture_lex $P270
    .lex "self", param_253
    .lex "$/", param_254
.annotate 'line', 130
    new $P255, "Undef"
    .lex "$past", $P255
    find_lex $P256, "$/"
    unless_null $P256, vivify_97
    $P256 = root_new ['parrot';'Hash']
  vivify_97:
    set $P257, $P256["quote_delimited"]
    unless_null $P257, vivify_98
    new $P257, "Undef"
  vivify_98:
    $P258 = $P257."ast"()
    store_lex "$past", $P258
.annotate 'line', 131
    find_lex $P260, "$/"
    $P261 = $P260."CURSOR"()
    $P262 = $P261."quotemod_check"("w")
    unless $P262, if_259_end
.annotate 'line', 132
    get_hll_global $P264, ["PAST"], "Node"
    find_lex $P265, "$past"
    $P266 = $P264."ACCEPTS"($P265)
    if $P266, if_263
.annotate 'line', 135
    .const 'Sub' $P270 = "32_1299602518.024" 
    capture_lex $P270
    $P270()
    goto if_263_end
  if_263:
.annotate 'line', 133
    find_lex $P267, "$/"
    $P268 = $P267."CURSOR"()
    $P268."panic"("Can't form :w list from non-constant strings (yet)")
  if_263_end:
  if_259_end:
.annotate 'line', 146
    get_hll_global $P302, ["PAST"], "Node"
    find_lex $P303, "$past"
    $P304 = $P302."ACCEPTS"($P303)
    isfalse $I305, $P304
    unless $I305, if_301_end
.annotate 'line', 147
    get_hll_global $P306, ["PAST"], "Val"
    find_lex $P307, "$past"
    set $S308, $P307
    $P309 = $P306."new"($S308 :named("value"))
    store_lex "$past", $P309
  if_301_end:
.annotate 'line', 149
    find_lex $P310, "$/"
    find_lex $P311, "$past"
    $P312 = $P310."!make"($P311)
.annotate 'line', 129
    .return ($P312)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.include "except_types.pasm"
.sub "_block269"  :anon :subid("32_1299602518.024") :outer("31_1299602518.024")
.annotate 'line', 135
    .const 'Sub' $P289 = "33_1299602518.024" 
    capture_lex $P289
.annotate 'line', 136
    $P271 = root_new ['parrot';'ResizablePMCArray']
    .lex "@words", $P271
    get_hll_global $P272, ["HLL";"Grammar"], "split_words"
    find_lex $P273, "$/"
    find_lex $P274, "$past"
    $P275 = $P272($P273, $P274)
    store_lex "@words", $P275
.annotate 'line', 137
    find_lex $P278, "@words"
    set $N279, $P278
    isne $I280, $N279, 1.0
    if $I280, if_277
.annotate 'line', 142
    find_lex $P297, "@words"
    unless_null $P297, vivify_99
    $P297 = root_new ['parrot';'ResizablePMCArray']
  vivify_99:
    set $P298, $P297[0]
    unless_null $P298, vivify_100
    new $P298, "Undef"
  vivify_100:
    set $S299, $P298
    new $P300, 'String'
    set $P300, $S299
    store_lex "$past", $P300
.annotate 'line', 141
    set $P276, $P300
.annotate 'line', 137
    goto if_277_end
  if_277:
.annotate 'line', 138
    get_hll_global $P281, ["PAST"], "Op"
    find_lex $P282, "$/"
    $P283 = $P281."new"("list" :named("pasttype"), $P282 :named("node"))
    store_lex "$past", $P283
.annotate 'line', 139
    find_lex $P285, "@words"
    defined $I286, $P285
    unless $I286, for_undef_101
    iter $P284, $P285
    new $P295, 'ExceptionHandler'
    set_label $P295, loop294_handler
    $P295."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P295
  loop294_test:
    unless $P284, loop294_done
    shift $P287, $P284
  loop294_redo:
    .const 'Sub' $P289 = "33_1299602518.024" 
    capture_lex $P289
    $P289($P287)
  loop294_next:
    goto loop294_test
  loop294_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P296, exception, 'type'
    eq $P296, .CONTROL_LOOP_NEXT, loop294_next
    eq $P296, .CONTROL_LOOP_REDO, loop294_redo
  loop294_done:
    pop_eh 
  for_undef_101:
.annotate 'line', 137
    set $P276, $P284
  if_277_end:
.annotate 'line', 135
    .return ($P276)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block288"  :anon :subid("33_1299602518.024") :outer("32_1299602518.024")
    .param pmc param_290
.annotate 'line', 139
    .lex "$_", param_290
    find_lex $P291, "$past"
    find_lex $P292, "$_"
    $P293 = $P291."push"($P292)
    .return ($P293)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.include "except_types.pasm"
.sub "quote_delimited"  :subid("34_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_314
    .param pmc param_315
.annotate 'line', 152
    .const 'Sub' $P327 = "35_1299602518.024" 
    capture_lex $P327
    .lex "self", param_314
    .lex "$/", param_315
.annotate 'line', 153
    $P316 = root_new ['parrot';'ResizablePMCArray']
    .lex "@parts", $P316
.annotate 'line', 154
    new $P317, "Undef"
    .lex "$lastlit", $P317
.annotate 'line', 170
    new $P318, "Undef"
    .lex "$past", $P318
.annotate 'line', 152
    find_lex $P319, "@parts"
.annotate 'line', 154
    new $P320, "String"
    assign $P320, ""
    store_lex "$lastlit", $P320
.annotate 'line', 155
    find_lex $P322, "$/"
    unless_null $P322, vivify_102
    $P322 = root_new ['parrot';'Hash']
  vivify_102:
    set $P323, $P322["quote_atom"]
    unless_null $P323, vivify_103
    new $P323, "Undef"
  vivify_103:
    defined $I324, $P323
    unless $I324, for_undef_104
    iter $P321, $P323
    new $P360, 'ExceptionHandler'
    set_label $P360, loop359_handler
    $P360."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P360
  loop359_test:
    unless $P321, loop359_done
    shift $P325, $P321
  loop359_redo:
    .const 'Sub' $P327 = "35_1299602518.024" 
    capture_lex $P327
    $P327($P325)
  loop359_next:
    goto loop359_test
  loop359_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P361, exception, 'type'
    eq $P361, .CONTROL_LOOP_NEXT, loop359_next
    eq $P361, .CONTROL_LOOP_REDO, loop359_redo
  loop359_done:
    pop_eh 
  for_undef_104:
.annotate 'line', 169
    find_lex $P363, "$lastlit"
    set $S364, $P363
    isgt $I365, $S364, ""
    unless $I365, if_362_end
    find_lex $P366, "@parts"
    find_lex $P367, "$lastlit"
    $P366."push"($P367)
  if_362_end:
.annotate 'line', 170
    find_lex $P370, "@parts"
    if $P370, if_369
    new $P373, "String"
    assign $P373, ""
    set $P368, $P373
    goto if_369_end
  if_369:
    find_lex $P371, "@parts"
    $P372 = $P371."shift"()
    set $P368, $P372
  if_369_end:
    store_lex "$past", $P368
.annotate 'line', 171
    new $P381, 'ExceptionHandler'
    set_label $P381, loop380_handler
    $P381."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P381
  loop380_test:
    find_lex $P374, "@parts"
    unless $P374, loop380_done
  loop380_redo:
.annotate 'line', 172
    get_hll_global $P375, ["PAST"], "Op"
    find_lex $P376, "$past"
    find_lex $P377, "@parts"
    $P378 = $P377."shift"()
    $P379 = $P375."new"($P376, $P378, "concat" :named("pirop"))
    store_lex "$past", $P379
  loop380_next:
.annotate 'line', 171
    goto loop380_test
  loop380_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P382, exception, 'type'
    eq $P382, .CONTROL_LOOP_NEXT, loop380_next
    eq $P382, .CONTROL_LOOP_REDO, loop380_redo
  loop380_done:
    pop_eh 
.annotate 'line', 174
    find_lex $P383, "$/"
    find_lex $P384, "$past"
    $P385 = $P383."!make"($P384)
.annotate 'line', 152
    .return ($P385)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block326"  :anon :subid("35_1299602518.024") :outer("34_1299602518.024")
    .param pmc param_329
.annotate 'line', 156
    new $P328, "Undef"
    .lex "$ast", $P328
    .lex "$_", param_329
    find_lex $P330, "$_"
    $P331 = $P330."ast"()
    store_lex "$ast", $P331
.annotate 'line', 157
    get_hll_global $P334, ["PAST"], "Node"
    find_lex $P335, "$ast"
    $P336 = $P334."ACCEPTS"($P335)
    isfalse $I337, $P336
    if $I337, if_333
.annotate 'line', 160
    find_lex $P343, "$ast"
    get_hll_global $P344, ["PAST"], "Val"
    $P345 = $P343."isa"($P344)
    if $P345, if_342
.annotate 'line', 164
    find_lex $P351, "$lastlit"
    set $S352, $P351
    isgt $I353, $S352, ""
    unless $I353, if_350_end
    find_lex $P354, "@parts"
    find_lex $P355, "$lastlit"
    $P354."push"($P355)
  if_350_end:
.annotate 'line', 165
    find_lex $P356, "@parts"
    find_lex $P357, "$ast"
    $P356."push"($P357)
.annotate 'line', 166
    new $P358, "String"
    assign $P358, ""
    store_lex "$lastlit", $P358
.annotate 'line', 163
    set $P341, $P358
.annotate 'line', 160
    goto if_342_end
  if_342:
.annotate 'line', 161
    find_lex $P346, "$lastlit"
    find_lex $P347, "$ast"
    $S348 = $P347."value"()
    concat $P349, $P346, $S348
    store_lex "$lastlit", $P349
.annotate 'line', 160
    set $P341, $P349
  if_342_end:
    set $P332, $P341
.annotate 'line', 157
    goto if_333_end
  if_333:
.annotate 'line', 158
    find_lex $P338, "$lastlit"
    find_lex $P339, "$ast"
    concat $P340, $P338, $P339
    store_lex "$lastlit", $P340
.annotate 'line', 157
    set $P332, $P340
  if_333_end:
.annotate 'line', 155
    .return ($P332)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_atom"  :subid("36_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_387
    .param pmc param_388
.annotate 'line', 177
    .lex "self", param_387
    .lex "$/", param_388
.annotate 'line', 178
    find_lex $P389, "$/"
    find_lex $P392, "$/"
    unless_null $P392, vivify_105
    $P392 = root_new ['parrot';'Hash']
  vivify_105:
    set $P393, $P392["quote_escape"]
    unless_null $P393, vivify_106
    new $P393, "Undef"
  vivify_106:
    if $P393, if_391
    find_lex $P397, "$/"
    set $S398, $P397
    new $P390, 'String'
    set $P390, $S398
    goto if_391_end
  if_391:
    find_lex $P394, "$/"
    unless_null $P394, vivify_107
    $P394 = root_new ['parrot';'Hash']
  vivify_107:
    set $P395, $P394["quote_escape"]
    unless_null $P395, vivify_108
    new $P395, "Undef"
  vivify_108:
    $P396 = $P395."ast"()
    set $P390, $P396
  if_391_end:
    $P399 = $P389."!make"($P390)
.annotate 'line', 177
    .return ($P399)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<backslash>"  :subid("37_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_401
    .param pmc param_402
.annotate 'line', 181
    .lex "self", param_401
    .lex "$/", param_402
    find_lex $P403, "$/"
    $P404 = $P403."!make"("\\")
    .return ($P404)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<stopper>"  :subid("38_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_406
    .param pmc param_407
.annotate 'line', 182
    .lex "self", param_406
    .lex "$/", param_407
    find_lex $P408, "$/"
    find_lex $P409, "$/"
    unless_null $P409, vivify_109
    $P409 = root_new ['parrot';'Hash']
  vivify_109:
    set $P410, $P409["stopper"]
    unless_null $P410, vivify_110
    new $P410, "Undef"
  vivify_110:
    set $S411, $P410
    $P412 = $P408."!make"($S411)
    .return ($P412)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<bs>"  :subid("39_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_414
    .param pmc param_415
.annotate 'line', 184
    .lex "self", param_414
    .lex "$/", param_415
    find_lex $P416, "$/"
    $P417 = $P416."!make"("\b")
    .return ($P417)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<nl>"  :subid("40_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_419
    .param pmc param_420
.annotate 'line', 185
    .lex "self", param_419
    .lex "$/", param_420
    find_lex $P421, "$/"
    $P422 = $P421."!make"("\n")
    .return ($P422)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<cr>"  :subid("41_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_424
    .param pmc param_425
.annotate 'line', 186
    .lex "self", param_424
    .lex "$/", param_425
    find_lex $P426, "$/"
    $P427 = $P426."!make"("\r")
    .return ($P427)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<tab>"  :subid("42_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_429
    .param pmc param_430
.annotate 'line', 187
    .lex "self", param_429
    .lex "$/", param_430
    find_lex $P431, "$/"
    $P432 = $P431."!make"("\t")
    .return ($P432)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<ff>"  :subid("43_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_434
    .param pmc param_435
.annotate 'line', 188
    .lex "self", param_434
    .lex "$/", param_435
    find_lex $P436, "$/"
    $P437 = $P436."!make"("\f")
    .return ($P437)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<esc>"  :subid("44_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_439
    .param pmc param_440
.annotate 'line', 189
    .lex "self", param_439
    .lex "$/", param_440
    find_lex $P441, "$/"
    $P442 = $P441."!make"("\e")
    .return ($P442)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<hex>"  :subid("45_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_444
    .param pmc param_445
.annotate 'line', 191
    .lex "self", param_444
    .lex "$/", param_445
.annotate 'line', 192
    find_lex $P446, "$/"
    find_lex $P449, "$/"
    unless_null $P449, vivify_111
    $P449 = root_new ['parrot';'Hash']
  vivify_111:
    set $P450, $P449["hexint"]
    unless_null $P450, vivify_112
    new $P450, "Undef"
  vivify_112:
    if $P450, if_448
    find_lex $P453, "$/"
    unless_null $P453, vivify_113
    $P453 = root_new ['parrot';'Hash']
  vivify_113:
    set $P454, $P453["hexints"]
    unless_null $P454, vivify_114
    $P454 = root_new ['parrot';'Hash']
  vivify_114:
    set $P455, $P454["hexint"]
    unless_null $P455, vivify_115
    new $P455, "Undef"
  vivify_115:
    set $P447, $P455
    goto if_448_end
  if_448:
    find_lex $P451, "$/"
    unless_null $P451, vivify_116
    $P451 = root_new ['parrot';'Hash']
  vivify_116:
    set $P452, $P451["hexint"]
    unless_null $P452, vivify_117
    new $P452, "Undef"
  vivify_117:
    set $P447, $P452
  if_448_end:
    $P456 = "ints_to_string"($P447)
    $P457 = $P446."!make"($P456)
.annotate 'line', 191
    .return ($P457)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<oct>"  :subid("46_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_459
    .param pmc param_460
.annotate 'line', 195
    .lex "self", param_459
    .lex "$/", param_460
.annotate 'line', 196
    find_lex $P461, "$/"
    find_lex $P464, "$/"
    unless_null $P464, vivify_118
    $P464 = root_new ['parrot';'Hash']
  vivify_118:
    set $P465, $P464["octint"]
    unless_null $P465, vivify_119
    new $P465, "Undef"
  vivify_119:
    if $P465, if_463
    find_lex $P468, "$/"
    unless_null $P468, vivify_120
    $P468 = root_new ['parrot';'Hash']
  vivify_120:
    set $P469, $P468["octints"]
    unless_null $P469, vivify_121
    $P469 = root_new ['parrot';'Hash']
  vivify_121:
    set $P470, $P469["octint"]
    unless_null $P470, vivify_122
    new $P470, "Undef"
  vivify_122:
    set $P462, $P470
    goto if_463_end
  if_463:
    find_lex $P466, "$/"
    unless_null $P466, vivify_123
    $P466 = root_new ['parrot';'Hash']
  vivify_123:
    set $P467, $P466["octint"]
    unless_null $P467, vivify_124
    new $P467, "Undef"
  vivify_124:
    set $P462, $P467
  if_463_end:
    $P471 = "ints_to_string"($P462)
    $P472 = $P461."!make"($P471)
.annotate 'line', 195
    .return ($P472)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<chr>"  :subid("47_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_474
    .param pmc param_475
.annotate 'line', 199
    .lex "self", param_474
    .lex "$/", param_475
.annotate 'line', 200
    find_lex $P476, "$/"
    find_lex $P477, "$/"
    unless_null $P477, vivify_125
    $P477 = root_new ['parrot';'Hash']
  vivify_125:
    set $P478, $P477["charspec"]
    unless_null $P478, vivify_126
    new $P478, "Undef"
  vivify_126:
    $P479 = $P478."ast"()
    $P480 = $P476."!make"($P479)
.annotate 'line', 199
    .return ($P480)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<0>"  :subid("48_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_482
    .param pmc param_483
.annotate 'line', 203
    .lex "self", param_482
    .lex "$/", param_483
.annotate 'line', 204
    find_lex $P484, "$/"
    $P485 = $P484."!make"(unicode:"\x{0}")
.annotate 'line', 203
    .return ($P485)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "quote_escape:sym<misc>"  :subid("49_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_487
    .param pmc param_488
.annotate 'line', 207
    .lex "self", param_487
    .lex "$/", param_488
.annotate 'line', 208
    find_lex $P489, "$/"
    find_lex $P492, "$/"
    unless_null $P492, vivify_127
    $P492 = root_new ['parrot';'Hash']
  vivify_127:
    set $P493, $P492["textq"]
    unless_null $P493, vivify_128
    new $P493, "Undef"
  vivify_128:
    if $P493, if_491
    find_lex $P499, "$/"
    unless_null $P499, vivify_129
    $P499 = root_new ['parrot';'Hash']
  vivify_129:
    set $P500, $P499["textqq"]
    unless_null $P500, vivify_130
    new $P500, "Undef"
  vivify_130:
    $P501 = $P500."Str"()
    set $P490, $P501
    goto if_491_end
  if_491:
    new $P494, "String"
    assign $P494, "\\"
    find_lex $P495, "$/"
    unless_null $P495, vivify_131
    $P495 = root_new ['parrot';'Hash']
  vivify_131:
    set $P496, $P495["textq"]
    unless_null $P496, vivify_132
    new $P496, "Undef"
  vivify_132:
    $S497 = $P496."Str"()
    concat $P498, $P494, $S497
    set $P490, $P498
  if_491_end:
    $P502 = $P489."!make"($P490)
.annotate 'line', 207
    .return ($P502)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "charname"  :subid("50_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_504
    .param pmc param_505
.annotate 'line', 211
    .lex "self", param_504
    .lex "$/", param_505
.annotate 'line', 212
    new $P506, "Undef"
    .lex "$codepoint", $P506
.annotate 'line', 213
    find_lex $P509, "$/"
    unless_null $P509, vivify_133
    $P509 = root_new ['parrot';'Hash']
  vivify_133:
    set $P510, $P509["integer"]
    unless_null $P510, vivify_134
    new $P510, "Undef"
  vivify_134:
    if $P510, if_508
.annotate 'line', 214
    find_lex $P514, "$/"
    set $S515, $P514
    find_codepoint $I516, $S515
    new $P507, 'Integer'
    set $P507, $I516
.annotate 'line', 213
    goto if_508_end
  if_508:
    find_lex $P511, "$/"
    unless_null $P511, vivify_135
    $P511 = root_new ['parrot';'Hash']
  vivify_135:
    set $P512, $P511["integer"]
    unless_null $P512, vivify_136
    new $P512, "Undef"
  vivify_136:
    $P513 = $P512."ast"()
    set $P507, $P513
  if_508_end:
    store_lex "$codepoint", $P507
.annotate 'line', 215
    find_lex $P518, "$codepoint"
    set $N519, $P518
    islt $I520, $N519, 0.0
    unless $I520, if_517_end
    find_lex $P521, "$/"
    $P522 = $P521."CURSOR"()
    new $P523, 'String'
    set $P523, "Unrecognized character name "
    find_lex $P524, "$/"
    concat $P525, $P523, $P524
    $P522."panic"($P525)
  if_517_end:
.annotate 'line', 216
    find_lex $P526, "$/"
    find_lex $P527, "$codepoint"
    set $I528, $P527
    chr $S529, $I528
    $P530 = $P526."!make"($S529)
.annotate 'line', 211
    .return ($P530)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.include "except_types.pasm"
.sub "charnames"  :subid("51_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_532
    .param pmc param_533
.annotate 'line', 219
    .const 'Sub' $P542 = "52_1299602518.024" 
    capture_lex $P542
    .lex "self", param_532
    .lex "$/", param_533
.annotate 'line', 220
    new $P534, "Undef"
    .lex "$str", $P534
    new $P535, "String"
    assign $P535, ""
    store_lex "$str", $P535
.annotate 'line', 221
    find_lex $P537, "$/"
    unless_null $P537, vivify_137
    $P537 = root_new ['parrot';'Hash']
  vivify_137:
    set $P538, $P537["charname"]
    unless_null $P538, vivify_138
    new $P538, "Undef"
  vivify_138:
    defined $I539, $P538
    unless $I539, for_undef_139
    iter $P536, $P538
    new $P549, 'ExceptionHandler'
    set_label $P549, loop548_handler
    $P549."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P549
  loop548_test:
    unless $P536, loop548_done
    shift $P540, $P536
  loop548_redo:
    .const 'Sub' $P542 = "52_1299602518.024" 
    capture_lex $P542
    $P542($P540)
  loop548_next:
    goto loop548_test
  loop548_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P550, exception, 'type'
    eq $P550, .CONTROL_LOOP_NEXT, loop548_next
    eq $P550, .CONTROL_LOOP_REDO, loop548_redo
  loop548_done:
    pop_eh 
  for_undef_139:
.annotate 'line', 222
    find_lex $P551, "$/"
    find_lex $P552, "$str"
    $P553 = $P551."!make"($P552)
.annotate 'line', 219
    .return ($P553)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block541"  :anon :subid("52_1299602518.024") :outer("51_1299602518.024")
    .param pmc param_543
.annotate 'line', 221
    .lex "$_", param_543
    find_lex $P544, "$str"
    find_lex $P545, "$_"
    $S546 = $P545."ast"()
    concat $P547, $P544, $S546
    store_lex "$str", $P547
    .return ($P547)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "charspec"  :subid("53_1299602518.024") :outer("11_1299602518.024")
    .param pmc param_555
    .param pmc param_556
.annotate 'line', 225
    .lex "self", param_555
    .lex "$/", param_556
.annotate 'line', 226
    find_lex $P557, "$/"
    find_lex $P560, "$/"
    unless_null $P560, vivify_140
    $P560 = root_new ['parrot';'Hash']
  vivify_140:
    set $P561, $P560["charnames"]
    unless_null $P561, vivify_141
    new $P561, "Undef"
  vivify_141:
    if $P561, if_559
    find_lex $P565, "$/"
    $I566 = "string_to_int"($P565, 10)
    chr $S567, $I566
    new $P558, 'String'
    set $P558, $S567
    goto if_559_end
  if_559:
    find_lex $P562, "$/"
    unless_null $P562, vivify_142
    $P562 = root_new ['parrot';'Hash']
  vivify_142:
    set $P563, $P562["charnames"]
    unless_null $P563, vivify_143
    new $P563, "Undef"
  vivify_143:
    $P564 = $P563."ast"()
    set $P558, $P564
  if_559_end:
    $P568 = $P557."!make"($P558)
.annotate 'line', 225
    .return ($P568)
.end


.HLL "nqp"

.namespace ["HLL";"Actions"]
.sub "_block570" :load :anon :subid("54_1299602518.024")
.annotate 'line', 3
    .const 'Sub' $P572 = "11_1299602518.024" 
    $P573 = $P572()
    .return ($P573)
.end


.HLL "nqp"

.namespace []
.sub "_block654" :load :anon :subid("56_1299602518.024")
.annotate 'line', 1
    .const 'Sub' $P656 = "10_1299602518.024" 
    $P657 = $P656()
    .return ($P657)
.end

### .include 'gen/hllcompiler.pir'

.HLL "nqp"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.namespace []
.sub "_block11"  :anon :subid("10_1299602521.155")
.annotate 'line', 0
    get_hll_global $P20, ["HLL";"Compiler"], "_block19" 
    capture_lex $P20
    .const 'Sub' $P18 = "11_1299602521.155" 
    capture_lex $P18
.annotate 'line', 1
    getinterp $P13
    get_class $P14, "LexPad"
    get_class $P15, "NQPLexPad"
    $P13."hll_map"($P14, $P15)
    get_hll_global $P16, ["HLL"], "Compiler"
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    .const 'Sub' $P18 = "11_1299602521.155" 
    capture_lex $P18
    $P18()
.annotate 'line', 9
    get_hll_global $P20, ["HLL";"Compiler"], "_block19" 
    capture_lex $P20
    $P1230 = $P20()
.annotate 'line', 1
    .return ($P1230)
    .const 'Sub' $P1232 = "78_1299602521.155" 
    .return ($P1232)
.end


.HLL "nqp"

.namespace []
.sub "" :load :init :subid("post79") :outer("10_1299602521.155")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1299602521.155" 
    .local pmc block
    set block, $P12
    nqp_get_sc $P1236, "1299602518.413"
    isnull $I1237, $P1236
    if $I1237, if_1235
    goto if_1235_end
  if_1235:
    nqp_dynop_setup 
    load_bytecode "nqpmo.pbc"
    nqp_create_sc $P1238, "1299602518.413"
    .local pmc cur_sc
    set cur_sc, $P1238
    load_bytecode "SettingManager.pbc"
    get_hll_global $P1239, ["HLL"], "SettingManager"
    $P1240 = $P1239."load_setting"("NQPCORE")
    block."set_outer_ctx"($P1240)
    get_hll_global $P1241, "NQPClassHOW"
    $P1242 = $P1241."new_type"("HLL::Compiler" :named("name"))
    nqp_set_sc_for_object $P1242, cur_sc
    nqp_set_sc_object "1299602518.413", 0, $P1242
  if_1235_end:
.end


.HLL "nqp"

.namespace []
.sub "_block17"  :anon :subid("11_1299602521.155") :outer("10_1299602521.155")
.annotate 'line', 1
    .return ()
.end


.HLL "nqp"

.namespace []
.sub "" :load :init :subid("post80") :outer("11_1299602521.155")
.annotate 'line', 1
    .const 'Sub' $P18 = "11_1299602521.155" 
    .local pmc block
    set block, $P18
.annotate 'line', 2
    load_bytecode "Parrot/Exception.pbc"
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block19"  :subid("12_1299602521.155") :outer("10_1299602521.155")
.annotate 'line', 9
    .const 'Sub' $P1121 = "77_1299602521.155" 
    capture_lex $P1121
    .const 'Sub' $P1113 = "76_1299602521.155" 
    capture_lex $P1113
    .const 'Sub' $P1060 = "74_1299602521.155" 
    capture_lex $P1060
    .const 'Sub' $P987 = "71_1299602521.155" 
    capture_lex $P987
    .const 'Sub' $P957 = "69_1299602521.155" 
    capture_lex $P957
    .const 'Sub' $P952 = "68_1299602521.155" 
    capture_lex $P952
    .const 'Sub' $P942 = "67_1299602521.155" 
    capture_lex $P942
    .const 'Sub' $P916 = "65_1299602521.155" 
    capture_lex $P916
    .const 'Sub' $P907 = "64_1299602521.155" 
    capture_lex $P907
    .const 'Sub' $P899 = "63_1299602521.155" 
    capture_lex $P899
    .const 'Sub' $P891 = "62_1299602521.155" 
    capture_lex $P891
    .const 'Sub' $P887 = "61_1299602521.155" 
    capture_lex $P887
    .const 'Sub' $P883 = "60_1299602521.155" 
    capture_lex $P883
    .const 'Sub' $P816 = "58_1299602521.155" 
    capture_lex $P816
    .const 'Sub' $P720 = "54_1299602521.155" 
    capture_lex $P720
    .const 'Sub' $P684 = "51_1299602521.155" 
    capture_lex $P684
    .const 'Sub' $P636 = "49_1299602521.155" 
    capture_lex $P636
    .const 'Sub' $P623 = "48_1299602521.155" 
    capture_lex $P623
    .const 'Sub' $P610 = "47_1299602521.155" 
    capture_lex $P610
    .const 'Sub' $P597 = "46_1299602521.155" 
    capture_lex $P597
    .const 'Sub' $P584 = "45_1299602521.155" 
    capture_lex $P584
    .const 'Sub' $P571 = "44_1299602521.155" 
    capture_lex $P571
    .const 'Sub' $P558 = "43_1299602521.155" 
    capture_lex $P558
    .const 'Sub' $P545 = "42_1299602521.155" 
    capture_lex $P545
    .const 'Sub' $P532 = "41_1299602521.155" 
    capture_lex $P532
    .const 'Sub' $P527 = "40_1299602521.155" 
    capture_lex $P527
    .const 'Sub' $P523 = "39_1299602521.155" 
    capture_lex $P523
    .const 'Sub' $P483 = "37_1299602521.155" 
    capture_lex $P483
    .const 'Sub' $P336 = "30_1299602521.155" 
    capture_lex $P336
    .const 'Sub' $P323 = "29_1299602521.155" 
    capture_lex $P323
    .const 'Sub' $P230 = "24_1299602521.155" 
    capture_lex $P230
    .const 'Sub' $P197 = "22_1299602521.155" 
    capture_lex $P197
    .const 'Sub' $P182 = "21_1299602521.155" 
    capture_lex $P182
    .const 'Sub' $P167 = "20_1299602521.155" 
    capture_lex $P167
    .const 'Sub' $P80 = "17_1299602521.155" 
    capture_lex $P80
    .const 'Sub' $P43 = "15_1299602521.155" 
    capture_lex $P43
    .const 'Sub' $P36 = "14_1299602521.155" 
    capture_lex $P36
    .const 'Sub' $P22 = "13_1299602521.155" 
    capture_lex $P22
    get_global $P21, "$?CLASS"
.annotate 'line', 64
    .const 'Sub' $P22 = "13_1299602521.155" 
    newclosure $P35, $P22
    .lex "value_type", $P35
.annotate 'line', 29
    find_lex $P79, "value_type"
.annotate 'line', 660
    .const 'Sub' $P1113 = "76_1299602521.155" 
    newclosure $P1119, $P1113
.annotate 'line', 9
    .return ($P1119)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "" :load :init :subid("post81") :outer("12_1299602521.155")
.annotate 'line', 9
    get_hll_global $P20, ["HLL";"Compiler"], "_block19" 
    .local pmc block
    set block, $P20
    .const 'Sub' $P1121 = "77_1299602521.155" 
    capture_lex $P1121
    $P1121()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block1120"  :anon :subid("77_1299602521.155") :outer("12_1299602521.155")
.annotate 'line', 9
    nqp_get_sc_object $P1122, "1299602518.413", 0
    .local pmc type_obj
    set type_obj, $P1122
    set_hll_global ["HLL"], "Compiler", type_obj
    set_global "$?CLASS", type_obj
    get_how $P1123, type_obj
    get_hll_global $P1124, "NQPAttribute"
    $P1125 = $P1124."new"("@!stages" :named("name"))
    $P1123."add_attribute"(type_obj, $P1125)
    get_how $P1126, type_obj
    get_hll_global $P1127, "NQPAttribute"
    $P1128 = $P1127."new"("$!parsegrammar" :named("name"))
    $P1126."add_attribute"(type_obj, $P1128)
    get_how $P1129, type_obj
    get_hll_global $P1130, "NQPAttribute"
    $P1131 = $P1130."new"("$!parseactions" :named("name"))
    $P1129."add_attribute"(type_obj, $P1131)
    get_how $P1132, type_obj
    get_hll_global $P1133, "NQPAttribute"
    $P1134 = $P1133."new"("$!astgrammar" :named("name"))
    $P1132."add_attribute"(type_obj, $P1134)
    get_how $P1135, type_obj
    get_hll_global $P1136, "NQPAttribute"
    $P1137 = $P1136."new"("$!commandline_banner" :named("name"))
    $P1135."add_attribute"(type_obj, $P1137)
    get_how $P1138, type_obj
    get_hll_global $P1139, "NQPAttribute"
    $P1140 = $P1139."new"("$!commandline_prompt" :named("name"))
    $P1138."add_attribute"(type_obj, $P1140)
    get_how $P1141, type_obj
    get_hll_global $P1142, "NQPAttribute"
    $P1143 = $P1142."new"("@!cmdoptions" :named("name"))
    $P1141."add_attribute"(type_obj, $P1143)
    get_how $P1144, type_obj
    get_hll_global $P1145, "NQPAttribute"
    $P1146 = $P1145."new"("$!usage" :named("name"))
    $P1144."add_attribute"(type_obj, $P1146)
    get_how $P1147, type_obj
    get_hll_global $P1148, "NQPAttribute"
    $P1149 = $P1148."new"("$!version" :named("name"))
    $P1147."add_attribute"(type_obj, $P1149)
    get_how $P1150, type_obj
    get_hll_global $P1151, "NQPAttribute"
    $P1152 = $P1151."new"("$!compiler_progname" :named("name"))
    $P1150."add_attribute"(type_obj, $P1152)
    get_how $P1153, type_obj
    get_hll_global $P1154, "NQPAttribute"
    $P1155 = $P1154."new"("$!language" :named("name"))
    $P1153."add_attribute"(type_obj, $P1155)
    get_how $P1156, type_obj
    .const 'Sub' $P1157 = "14_1299602521.155" 
    $P1156."add_method"(type_obj, "new", $P1157)
    get_how $P1158, type_obj
    .const 'Sub' $P1159 = "15_1299602521.155" 
    $P1158."add_method"(type_obj, "BUILD", $P1159)
    get_how $P1160, type_obj
    .const 'Sub' $P1161 = "17_1299602521.155" 
    $P1160."add_method"(type_obj, "get_exports", $P1161)
    get_how $P1162, type_obj
    .const 'Sub' $P1163 = "20_1299602521.155" 
    $P1162."add_method"(type_obj, "get_module", $P1163)
    get_how $P1164, type_obj
    .const 'Sub' $P1165 = "21_1299602521.155" 
    $P1164."add_method"(type_obj, "language", $P1165)
    get_how $P1166, type_obj
    .const 'Sub' $P1167 = "22_1299602521.155" 
    $P1166."add_method"(type_obj, "load_module", $P1167)
    get_how $P1168, type_obj
    .const 'Sub' $P1169 = "24_1299602521.155" 
    $P1168."add_method"(type_obj, "import", $P1169)
    get_how $P1170, type_obj
    .const 'Sub' $P1171 = "29_1299602521.155" 
    $P1170."add_method"(type_obj, "autoprint", $P1171)
    get_how $P1172, type_obj
    .const 'Sub' $P1173 = "30_1299602521.155" 
    $P1172."add_method"(type_obj, "interactive", $P1173)
    get_how $P1174, type_obj
    .const 'Sub' $P1175 = "37_1299602521.155" 
    $P1174."add_method"(type_obj, "eval", $P1175)
    get_how $P1176, type_obj
    .const 'Sub' $P1177 = "39_1299602521.155" 
    $P1176."add_method"(type_obj, "ctxsave", $P1177)
    get_how $P1178, type_obj
    .const 'Sub' $P1179 = "40_1299602521.155" 
    $P1178."add_method"(type_obj, "panic", $P1179)
    get_how $P1180, type_obj
    .const 'Sub' $P1181 = "41_1299602521.155" 
    $P1180."add_method"(type_obj, "stages", $P1181)
    get_how $P1182, type_obj
    .const 'Sub' $P1183 = "42_1299602521.155" 
    $P1182."add_method"(type_obj, "parsegrammar", $P1183)
    get_how $P1184, type_obj
    .const 'Sub' $P1185 = "43_1299602521.155" 
    $P1184."add_method"(type_obj, "parseactions", $P1185)
    get_how $P1186, type_obj
    .const 'Sub' $P1187 = "44_1299602521.155" 
    $P1186."add_method"(type_obj, "astgrammar", $P1187)
    get_how $P1188, type_obj
    .const 'Sub' $P1189 = "45_1299602521.155" 
    $P1188."add_method"(type_obj, "commandline_banner", $P1189)
    get_how $P1190, type_obj
    .const 'Sub' $P1191 = "46_1299602521.155" 
    $P1190."add_method"(type_obj, "commandline_prompt", $P1191)
    get_how $P1192, type_obj
    .const 'Sub' $P1193 = "47_1299602521.155" 
    $P1192."add_method"(type_obj, "compiler_progname", $P1193)
    get_how $P1194, type_obj
    .const 'Sub' $P1195 = "48_1299602521.155" 
    $P1194."add_method"(type_obj, "commandline_options", $P1195)
    get_how $P1196, type_obj
    .const 'Sub' $P1197 = "49_1299602521.155" 
    $P1196."add_method"(type_obj, "command_line", $P1197)
    get_how $P1198, type_obj
    .const 'Sub' $P1199 = "51_1299602521.155" 
    $P1198."add_method"(type_obj, "process_args", $P1199)
    get_how $P1200, type_obj
    .const 'Sub' $P1201 = "54_1299602521.155" 
    $P1200."add_method"(type_obj, "evalfiles", $P1201)
    get_how $P1202, type_obj
    .const 'Sub' $P1203 = "58_1299602521.155" 
    $P1202."add_method"(type_obj, "compile", $P1203)
    get_how $P1204, type_obj
    .const 'Sub' $P1205 = "60_1299602521.155" 
    $P1204."add_method"(type_obj, "parse", $P1205)
    get_how $P1206, type_obj
    .const 'Sub' $P1207 = "61_1299602521.155" 
    $P1206."add_method"(type_obj, "past", $P1207)
    get_how $P1208, type_obj
    .const 'Sub' $P1209 = "62_1299602521.155" 
    $P1208."add_method"(type_obj, "post", $P1209)
    get_how $P1210, type_obj
    .const 'Sub' $P1211 = "63_1299602521.155" 
    $P1210."add_method"(type_obj, "pir", $P1211)
    get_how $P1212, type_obj
    .const 'Sub' $P1213 = "64_1299602521.155" 
    $P1212."add_method"(type_obj, "evalpmc", $P1213)
    get_how $P1214, type_obj
    .const 'Sub' $P1215 = "65_1299602521.155" 
    $P1214."add_method"(type_obj, "dumper", $P1215)
    get_how $P1216, type_obj
    .const 'Sub' $P1217 = "67_1299602521.155" 
    $P1216."add_method"(type_obj, "usage", $P1217)
    get_how $P1218, type_obj
    .const 'Sub' $P1219 = "68_1299602521.155" 
    $P1218."add_method"(type_obj, "version", $P1219)
    get_how $P1220, type_obj
    .const 'Sub' $P1221 = "69_1299602521.155" 
    $P1220."add_method"(type_obj, "removestage", $P1221)
    get_how $P1222, type_obj
    .const 'Sub' $P1223 = "71_1299602521.155" 
    $P1222."add_method"(type_obj, "addstage", $P1223)
    get_how $P1224, type_obj
    .const 'Sub' $P1225 = "74_1299602521.155" 
    $P1224."add_method"(type_obj, "parse_name", $P1225)
    get_how $P1226, type_obj
    .const 'Sub' $P1227 = "76_1299602521.155" 
    $P1226."add_method"(type_obj, "lineof", $P1227)
    get_how $P1228, type_obj
    $P1229 = $P1228."compose"(type_obj)
    .return ($P1229)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "value_type"  :subid("13_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_23
.annotate 'line', 64
    .lex "$value", param_23
.annotate 'line', 65
    find_lex $P26, "$value"
    isa $I27, $P26, "NameSpace"
    if $I27, if_25
.annotate 'line', 67
    find_lex $P31, "$value"
    isa $I32, $P31, "Sub"
    if $I32, if_30
    new $P34, "String"
    assign $P34, "var"
    set $P29, $P34
    goto if_30_end
  if_30:
    new $P33, "String"
    assign $P33, "sub"
    set $P29, $P33
  if_30_end:
    set $P24, $P29
.annotate 'line', 65
    goto if_25_end
  if_25:
    new $P28, "String"
    assign $P28, "namespace"
    set $P24, $P28
  if_25_end:
.annotate 'line', 64
    .return ($P24)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "new"  :subid("14_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_37
.annotate 'line', 23
    .lex "self", param_37
.annotate 'line', 24
    new $P38, "Undef"
    .lex "$obj", $P38
    find_lex $P39, "self"
    repr_instance_of $P40, $P39
    store_lex "$obj", $P40
.annotate 'line', 25
    find_lex $P41, "$obj"
    $P41."BUILD"()
    find_lex $P42, "$obj"
.annotate 'line', 23
    .return ($P42)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "BUILD"  :subid("15_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_44
.annotate 'line', 29
    .const 'Sub' $P61 = "16_1299602521.155" 
    capture_lex $P61
    .lex "self", param_44
.annotate 'line', 31
    split $P45, " ", "parse past post pir evalpmc"
    find_lex $P46, "self"
    get_global $P47, "$?CLASS"
    setattribute $P46, $P47, "@!stages", $P45
.annotate 'line', 34
    split $P48, " ", "e=s help|h target=s dumper=s trace|t=s encoding=s output|o=s combine version|v stagestats ll-backtrace"
    find_lex $P49, "self"
    get_global $P50, "$?CLASS"
    setattribute $P49, $P50, "@!cmdoptions", $P48
.annotate 'line', 35
    new $P51, "String"
    assign $P51, "This compiler is based on HLL::Compler.\n\nOptions:\n"
    find_lex $P52, "self"
    get_global $P53, "$?CLASS"
    setattribute $P52, $P53, "$!usage", $P51
.annotate 'line', 36
    find_lex $P55, "self"
    get_global $P56, "$?CLASS"
    getattribute $P57, $P55, $P56, "@!cmdoptions"
    unless_null $P57, vivify_82
    $P57 = root_new ['parrot';'ResizablePMCArray']
  vivify_82:
    defined $I58, $P57
    unless $I58, for_undef_83
    iter $P54, $P57
    new $P74, 'ExceptionHandler'
    set_label $P74, loop73_handler
    $P74."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P74
  loop73_test:
    unless $P54, loop73_done
    shift $P59, $P54
  loop73_redo:
    .const 'Sub' $P61 = "16_1299602521.155" 
    capture_lex $P61
    $P61($P59)
  loop73_next:
    goto loop73_test
  loop73_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P75, exception, 'type'
    eq $P75, .CONTROL_LOOP_NEXT, loop73_next
    eq $P75, .CONTROL_LOOP_REDO, loop73_redo
  loop73_done:
    pop_eh 
  for_undef_83:
.annotate 'line', 41

            .include 'iglobals.pasm'
            .include 'cclass.pasm'
            $S0  = '???'
            push_eh _handler
            $P0 = getinterp
            $P0 = $P0[.IGLOBALS_CONFIG_HASH]
            $S0  = $P0['git_describe']   # also $I0 = P0['installed'] could be used
          _handler:
            pop_eh
            $P76  = box 'This compiler is built with the Parrot Compiler Toolkit, parrot '
            if $S0 goto _revision_lab
            $P76 .= 'version '
            $S0 = $P0['VERSION']
            goto _is_version
          _revision_lab:
            $P76 .= 'revision '
          _is_version:
            $P76 .= $S0
            $P76 .= '.'
        
    find_lex $P77, "self"
    get_global $P78, "$?CLASS"
    setattribute $P77, $P78, "$!version", $P76
.annotate 'line', 29
    .return ($P76)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block60"  :anon :subid("16_1299602521.155") :outer("15_1299602521.155")
    .param pmc param_62
.annotate 'line', 36
    .lex "$_", param_62
.annotate 'line', 37
    find_lex $P63, "self"
    get_global $P64, "$?CLASS"
    getattribute $P65, $P63, $P64, "$!usage"
    unless_null $P65, vivify_84
    new $P65, "Undef"
  vivify_84:
    new $P66, 'String'
    set $P66, "    "
    find_lex $P67, "$_"
    concat $P68, $P66, $P67
    concat $P69, $P68, "\n"
    concat $P70, $P65, $P69
    find_lex $P71, "self"
    get_global $P72, "$?CLASS"
    setattribute $P71, $P72, "$!usage", $P70
.annotate 'line', 36
    .return ($P70)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "get_exports"  :subid("17_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_81
    .param pmc param_82
    .param pmc param_85 :slurpy
    .param pmc param_83 :optional :named("tagset")
    .param int has_param_83 :opt_flag
.annotate 'line', 70
    .const 'Sub' $P151 = "19_1299602521.155" 
    capture_lex $P151
    .const 'Sub' $P130 = "18_1299602521.155" 
    capture_lex $P130
    .lex "self", param_81
    .lex "$module", param_82
    if has_param_83, optparam_85
    new $P84, "Undef"
    set param_83, $P84
  optparam_85:
    .lex "$tagset", param_83
    .lex "@symbols", param_85
.annotate 'line', 77
    $P86 = root_new ['parrot';'Hash']
    .lex "%exports", $P86
.annotate 'line', 78
    $P87 = root_new ['parrot';'Hash']
    .lex "%source", $P87
.annotate 'line', 72
    find_lex $P89, "$module"
    does $I90, $P89, "hash"
    new $P91, 'Integer'
    set $P91, $I90
    isfalse $I92, $P91
    unless $I92, if_88_end
.annotate 'line', 73
    find_lex $P93, "self"
    find_lex $P94, "$module"
    $P95 = $P93."get_module"($P94)
    store_lex "$module", $P95
  if_88_end:
.annotate 'line', 76
    find_lex $P97, "$tagset"
    set $P96, $P97
    defined $I99, $P96
    if $I99, default_98
    find_lex $P102, "@symbols"
    if $P102, if_101
    new $P104, "String"
    assign $P104, "DEFAULT"
    set $P100, $P104
    goto if_101_end
  if_101:
    new $P103, "String"
    assign $P103, "ALL"
    set $P100, $P103
  if_101_end:
    set $P96, $P100
  default_98:
    store_lex "$tagset", $P96
    find_lex $P105, "%exports"
.annotate 'line', 78
    find_lex $P106, "$tagset"
    set $S107, $P106
    find_lex $P108, "$module"
    unless_null $P108, vivify_86
    $P108 = root_new ['parrot';'Hash']
  vivify_86:
    set $P109, $P108["EXPORT"]
    unless_null $P109, vivify_87
    $P109 = root_new ['parrot';'Hash']
  vivify_87:
    set $P110, $P109[$S107]
    unless_null $P110, vivify_88
    new $P110, "Undef"
  vivify_88:
    store_lex "%source", $P110
.annotate 'line', 79
    find_lex $P112, "%source"
    defined $I113, $P112
    new $P114, 'Integer'
    set $P114, $I113
    isfalse $I115, $P114
    unless $I115, if_111_end
.annotate 'line', 80
    find_lex $P118, "$tagset"
    set $S119, $P118
    iseq $I120, $S119, "ALL"
    if $I120, if_117
    $P122 = root_new ['parrot';'Hash']
    set $P116, $P122
    goto if_117_end
  if_117:
    find_lex $P121, "$module"
    set $P116, $P121
  if_117_end:
    store_lex "%source", $P116
  if_111_end:
.annotate 'line', 82
    find_lex $P124, "@symbols"
    if $P124, if_123
.annotate 'line', 89
    find_lex $P147, "%source"
    defined $I148, $P147
    unless $I148, for_undef_89
    iter $P146, $P147
    new $P164, 'ExceptionHandler'
    set_label $P164, loop163_handler
    $P164."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P164
  loop163_test:
    unless $P146, loop163_done
    shift $P149, $P146
  loop163_redo:
    .const 'Sub' $P151 = "19_1299602521.155" 
    capture_lex $P151
    $P151($P149)
  loop163_next:
    goto loop163_test
  loop163_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P165, exception, 'type'
    eq $P165, .CONTROL_LOOP_NEXT, loop163_next
    eq $P165, .CONTROL_LOOP_REDO, loop163_redo
  loop163_done:
    pop_eh 
  for_undef_89:
.annotate 'line', 88
    goto if_123_end
  if_123:
.annotate 'line', 83
    find_lex $P126, "@symbols"
    defined $I127, $P126
    unless $I127, for_undef_92
    iter $P125, $P126
    new $P144, 'ExceptionHandler'
    set_label $P144, loop143_handler
    $P144."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P144
  loop143_test:
    unless $P125, loop143_done
    shift $P128, $P125
  loop143_redo:
    .const 'Sub' $P130 = "18_1299602521.155" 
    capture_lex $P130
    $P130($P128)
  loop143_next:
    goto loop143_test
  loop143_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P145, exception, 'type'
    eq $P145, .CONTROL_LOOP_NEXT, loop143_next
    eq $P145, .CONTROL_LOOP_REDO, loop143_redo
  loop143_done:
    pop_eh 
  for_undef_92:
  if_123_end:
.annotate 'line', 82
    find_lex $P166, "%exports"
.annotate 'line', 70
    .return ($P166)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block150"  :anon :subid("19_1299602521.155") :outer("17_1299602521.155")
    .param pmc param_153
.annotate 'line', 90
    new $P152, "Undef"
    .lex "$value", $P152
    .lex "$_", param_153
    find_lex $P154, "$_"
    $P155 = $P154."value"()
    store_lex "$value", $P155
.annotate 'line', 91
    find_lex $P156, "$value"
    find_lex $P157, "$_"
    $P158 = $P157."key"()
    find_lex $P159, "$value"
    $P160 = "value_type"($P159)
    find_lex $P161, "%exports"
    unless_null $P161, vivify_90
    $P161 = root_new ['parrot';'Hash']
    store_lex "%exports", $P161
  vivify_90:
    set $P162, $P161[$P160]
    unless_null $P162, vivify_91
    $P162 = root_new ['parrot';'Hash']
    set $P161[$P160], $P162
  vivify_91:
    set $P162[$P158], $P156
.annotate 'line', 89
    .return ($P156)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block129"  :anon :subid("18_1299602521.155") :outer("17_1299602521.155")
    .param pmc param_132
.annotate 'line', 84
    new $P131, "Undef"
    .lex "$value", $P131
    .lex "$_", param_132
    find_lex $P133, "$_"
    set $S134, $P133
    find_lex $P135, "%source"
    unless_null $P135, vivify_93
    $P135 = root_new ['parrot';'Hash']
  vivify_93:
    set $P136, $P135[$S134]
    unless_null $P136, vivify_94
    new $P136, "Undef"
  vivify_94:
    store_lex "$value", $P136
.annotate 'line', 85
    find_lex $P137, "$value"
    find_lex $P138, "$_"
    find_lex $P139, "$value"
    $P140 = "value_type"($P139)
    find_lex $P141, "%exports"
    unless_null $P141, vivify_95
    $P141 = root_new ['parrot';'Hash']
    store_lex "%exports", $P141
  vivify_95:
    set $P142, $P141[$P140]
    unless_null $P142, vivify_96
    $P142 = root_new ['parrot';'Hash']
    set $P141[$P140], $P142
  vivify_96:
    set $P142[$P138], $P137
.annotate 'line', 83
    .return ($P137)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "get_module"  :subid("20_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_168
    .param pmc param_169
.annotate 'line', 97
    .lex "self", param_168
    .lex "$name", param_169
.annotate 'line', 98
    $P170 = root_new ['parrot';'ResizablePMCArray']
    .lex "@name", $P170
    find_lex $P171, "self"
    find_lex $P172, "$name"
    $P173 = $P171."parse_name"($P172)
    store_lex "@name", $P173
.annotate 'line', 99
    find_lex $P174, "@name"
    find_lex $P175, "self"
    get_global $P176, "$?CLASS"
    getattribute $P177, $P175, $P176, "$!language"
    unless_null $P177, vivify_97
    new $P177, "Undef"
  vivify_97:
    set $S178, $P177
    downcase $S179, $S178
    $P174."unshift"($S179)
.annotate 'line', 100
    find_lex $P180, "@name"
    get_root_namespace $P181, $P180
.annotate 'line', 97
    .return ($P181)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "language"  :subid("21_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_183
    .param pmc param_184 :optional
    .param int has_param_184 :opt_flag
.annotate 'line', 103
    .lex "self", param_183
    if has_param_184, optparam_98
    new $P185, "Undef"
    set param_184, $P185
  optparam_98:
    .lex "$name", param_184
.annotate 'line', 104
    find_lex $P187, "$name"
    unless $P187, if_186_end
.annotate 'line', 105
    find_lex $P188, "$name"
    find_lex $P189, "self"
    get_global $P190, "$?CLASS"
    setattribute $P189, $P190, "$!language", $P188
.annotate 'line', 106
    find_lex $P191, "$name"
    set $S192, $P191
    find_lex $P193, "self"
    compreg $S192, $P193
  if_186_end:
.annotate 'line', 104
    find_lex $P194, "self"
    get_global $P195, "$?CLASS"
    getattribute $P196, $P194, $P195, "$!language"
    unless_null $P196, vivify_99
    new $P196, "Undef"
  vivify_99:
.annotate 'line', 103
    .return ($P196)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "load_module"  :subid("22_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_198
    .param pmc param_199
.annotate 'line', 111
    .const 'Sub' $P209 = "23_1299602521.155" 
    capture_lex $P209
    .lex "self", param_198
    .lex "$name", param_199
.annotate 'line', 112
    new $P200, "Undef"
    .lex "$base", $P200
.annotate 'line', 113
    new $P201, "Undef"
    .lex "$loaded", $P201
.annotate 'line', 112
    find_lex $P202, "self"
    find_lex $P203, "$name"
    $P204 = $P202."parse_name"($P203)
    join $S205, "/", $P204
    new $P206, 'String'
    set $P206, $S205
    store_lex "$base", $P206
.annotate 'line', 113
    new $P207, "Integer"
    assign $P207, 0
    store_lex "$loaded", $P207
.annotate 'line', 114
    .const 'Sub' $P209 = "23_1299602521.155" 
    capture_lex $P209
    $P209()
.annotate 'line', 115
    find_lex $P222, "$loaded"
    if $P222, unless_221_end
    find_lex $P223, "$base"
    concat $P224, $P223, ".pir"
    set $S225, $P224
    load_bytecode $S225
    new $P226, "Integer"
    assign $P226, 1
    store_lex "$loaded", $P226
  unless_221_end:
.annotate 'line', 116
    find_lex $P227, "self"
    find_lex $P228, "$name"
    $P229 = $P227."get_module"($P228)
.annotate 'line', 111
    .return ($P229)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block208"  :anon :subid("23_1299602521.155") :outer("22_1299602521.155")
.annotate 'line', 114
    new $P216, 'ExceptionHandler'
    set_label $P216, control_215
    $P216."handle_types_except"(.CONTROL_RETURN,  .CONTROL_OK,  .CONTROL_BREAK,  .CONTROL_CONTINUE,  .CONTROL_TAKE,  .CONTROL_LEAVE,  .CONTROL_EXIT,  .CONTROL_LOOP_NEXT,  .CONTROL_LOOP_LAST,  .CONTROL_LOOP_REDO)
    push_eh $P216
    find_lex $P210, "$base"
    concat $P211, $P210, ".pbc"
    set $S212, $P211
    load_bytecode $S212
    new $P213, "Integer"
    assign $P213, 1
    store_lex "$loaded", $P213
    pop_eh 
    goto skip_handler_214
  control_215:
    .local pmc exception 
    .get_results (exception) 
    new $P219, 'Integer'
    set $P219, 1
    set exception["handled"], $P219
    set $I220, exception["handled"]
    ne $I220, 1, nothandled_218
  handled_217:
    .return (exception)
  nothandled_218:
    rethrow exception
  skip_handler_214:
    .return ($P213)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "import"  :subid("24_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_231
    .param pmc param_232
    .param pmc param_233
.annotate 'line', 119
    .const 'Sub' $P239 = "25_1299602521.155" 
    capture_lex $P239
    .lex "self", param_231
    .lex "$target", param_232
    .lex "%exports", param_233
.annotate 'line', 120
    find_lex $P235, "%exports"
    defined $I236, $P235
    unless $I236, for_undef_100
    iter $P234, $P235
    new $P321, 'ExceptionHandler'
    set_label $P321, loop320_handler
    $P321."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P321
  loop320_test:
    unless $P234, loop320_done
    shift $P237, $P234
  loop320_redo:
    .const 'Sub' $P239 = "25_1299602521.155" 
    capture_lex $P239
    $P239($P237)
  loop320_next:
    goto loop320_test
  loop320_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P322, exception, 'type'
    eq $P322, .CONTROL_LOOP_NEXT, loop320_next
    eq $P322, .CONTROL_LOOP_REDO, loop320_redo
  loop320_done:
    pop_eh 
  for_undef_100:
.annotate 'line', 119
    .return ($P234)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block238"  :anon :subid("25_1299602521.155") :outer("24_1299602521.155")
    .param pmc param_242
.annotate 'line', 120
    .const 'Sub' $P309 = "28_1299602521.155" 
    capture_lex $P309
    .const 'Sub' $P289 = "27_1299602521.155" 
    capture_lex $P289
    .const 'Sub' $P260 = "26_1299602521.155" 
    capture_lex $P260
.annotate 'line', 121
    new $P240, "Undef"
    .lex "$type", $P240
.annotate 'line', 122
    $P241 = root_new ['parrot';'Hash']
    .lex "%items", $P241
    .lex "$_", param_242
.annotate 'line', 121
    find_lex $P243, "$_"
    $P244 = $P243."key"()
    store_lex "$type", $P244
.annotate 'line', 122
    find_lex $P245, "$_"
    $P246 = $P245."value"()
    store_lex "%items", $P246
.annotate 'line', 123
    find_lex $P249, "self"
    new $P250, 'String'
    set $P250, "import_"
    find_lex $P251, "$type"
    concat $P252, $P250, $P251
    set $S253, $P252
    can $I254, $P249, $S253
    if $I254, if_248
.annotate 'line', 126
    find_lex $P278, "$target"
    new $P279, 'String'
    set $P279, "add_"
    find_lex $P280, "$type"
    concat $P281, $P279, $P280
    set $S282, $P281
    can $I283, $P278, $S282
    if $I283, if_277
.annotate 'line', 130
    find_lex $P305, "%items"
    defined $I306, $P305
    unless $I306, for_undef_101
    iter $P304, $P305
    new $P318, 'ExceptionHandler'
    set_label $P318, loop317_handler
    $P318."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P318
  loop317_test:
    unless $P304, loop317_done
    shift $P307, $P304
  loop317_redo:
    .const 'Sub' $P309 = "28_1299602521.155" 
    capture_lex $P309
    $P309($P307)
  loop317_next:
    goto loop317_test
  loop317_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P319, exception, 'type'
    eq $P319, .CONTROL_LOOP_NEXT, loop317_next
    eq $P319, .CONTROL_LOOP_REDO, loop317_redo
  loop317_done:
    pop_eh 
  for_undef_101:
.annotate 'line', 129
    set $P276, $P304
.annotate 'line', 126
    goto if_277_end
  if_277:
.annotate 'line', 127
    find_lex $P285, "%items"
    defined $I286, $P285
    unless $I286, for_undef_103
    iter $P284, $P285
    new $P302, 'ExceptionHandler'
    set_label $P302, loop301_handler
    $P302."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P302
  loop301_test:
    unless $P284, loop301_done
    shift $P287, $P284
  loop301_redo:
    .const 'Sub' $P289 = "27_1299602521.155" 
    capture_lex $P289
    $P289($P287)
  loop301_next:
    goto loop301_test
  loop301_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P303, exception, 'type'
    eq $P303, .CONTROL_LOOP_NEXT, loop301_next
    eq $P303, .CONTROL_LOOP_REDO, loop301_redo
  loop301_done:
    pop_eh 
  for_undef_103:
.annotate 'line', 126
    set $P276, $P284
  if_277_end:
    set $P247, $P276
.annotate 'line', 123
    goto if_248_end
  if_248:
.annotate 'line', 124
    find_lex $P256, "%items"
    defined $I257, $P256
    unless $I257, for_undef_104
    iter $P255, $P256
    new $P274, 'ExceptionHandler'
    set_label $P274, loop273_handler
    $P274."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P274
  loop273_test:
    unless $P255, loop273_done
    shift $P258, $P255
  loop273_redo:
    .const 'Sub' $P260 = "26_1299602521.155" 
    capture_lex $P260
    $P260($P258)
  loop273_next:
    goto loop273_test
  loop273_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P275, exception, 'type'
    eq $P275, .CONTROL_LOOP_NEXT, loop273_next
    eq $P275, .CONTROL_LOOP_REDO, loop273_redo
  loop273_done:
    pop_eh 
  for_undef_104:
.annotate 'line', 123
    set $P247, $P255
  if_248_end:
.annotate 'line', 120
    .return ($P247)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block308"  :anon :subid("28_1299602521.155") :outer("25_1299602521.155")
    .param pmc param_310
.annotate 'line', 130
    .lex "$_", param_310
    find_lex $P311, "$_"
    $P312 = $P311."value"()
    find_lex $P313, "$_"
    $P314 = $P313."key"()
    set $S315, $P314
    find_lex $P316, "$target"
    unless_null $P316, vivify_102
    $P316 = root_new ['parrot';'Hash']
    store_lex "$target", $P316
  vivify_102:
    set $P316[$S315], $P312
    .return ($P312)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block288"  :anon :subid("27_1299602521.155") :outer("25_1299602521.155")
    .param pmc param_290
.annotate 'line', 127
    .lex "$_", param_290
    find_lex $P291, "$target"
    find_lex $P292, "$_"
    $P293 = $P292."key"()
    find_lex $P294, "$_"
    $P295 = $P294."value"()
    new $P296, 'String'
    set $P296, "add_"
    find_lex $P297, "$type"
    concat $P298, $P296, $P297
    set $S299, $P298
    $P300 = $P291.$S299($P293, $P295)
    .return ($P300)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block259"  :anon :subid("26_1299602521.155") :outer("25_1299602521.155")
    .param pmc param_261
.annotate 'line', 124
    .lex "$_", param_261
    find_lex $P262, "self"
    find_lex $P263, "$target"
    find_lex $P264, "$_"
    $P265 = $P264."key"()
    find_lex $P266, "$_"
    $P267 = $P266."value"()
    new $P268, 'String'
    set $P268, "import_"
    find_lex $P269, "$type"
    concat $P270, $P268, $P269
    set $S271, $P270
    $P272 = $P262.$S271($P263, $P265, $P267)
    .return ($P272)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "autoprint"  :subid("29_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_324
    .param pmc param_325
.annotate 'line', 135
    .lex "self", param_324
    .lex "$value", param_325
.annotate 'line', 137
    getinterp $P328
    $P329 = $P328."stdout_handle"()
    $N330 = $P329."tell"()
    find_dynamic_lex $P331, "$*AUTOPRINTPOS"
    unless_null $P331, vivify_105
    get_hll_global $P331, "$AUTOPRINTPOS"
    unless_null $P331, vivify_106
    die "Contextual $*AUTOPRINTPOS not found"
  vivify_106:
  vivify_105:
    set $N332, $P331
    isgt $I333, $N330, $N332
    unless $I333, unless_327
    new $P326, 'Integer'
    set $P326, $I333
    goto unless_327_end
  unless_327:
.annotate 'line', 136
    find_lex $P334, "$value"
    set $S335, $P334
    say $S335
  unless_327_end:
.annotate 'line', 135
    .return ($P326)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "interactive"  :subid("30_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_337
    .param pmc param_338 :slurpy :named
.annotate 'line', 140
    .const 'Sub' $P370 = "31_1299602521.155" 
    capture_lex $P370
    .lex "self", param_337
    .lex "%adverbs", param_338
.annotate 'line', 141
    new $P339, "Undef"
    .lex "$target", $P339
.annotate 'line', 145
    new $P340, "Undef"
    .lex "$stdin", $P340
.annotate 'line', 146
    new $P341, "Undef"
    .lex "$encoding", $P341
.annotate 'line', 151
    new $P342, "Undef"
    .lex "$save_ctx", $P342
.annotate 'line', 141
    find_lex $P343, "%adverbs"
    unless_null $P343, vivify_107
    $P343 = root_new ['parrot';'Hash']
  vivify_107:
    set $P344, $P343["target"]
    unless_null $P344, vivify_108
    new $P344, "Undef"
  vivify_108:
    set $S345, $P344
    downcase $S346, $S345
    new $P347, 'String'
    set $P347, $S346
    store_lex "$target", $P347
.annotate 'line', 143
    getinterp $P348
    $P349 = $P348."stderr_handle"()
    find_lex $P350, "self"
    $S351 = $P350."commandline_banner"()
    print $P349, $S351
.annotate 'line', 145
    getinterp $P352
    $P353 = $P352."stdin_handle"()
    store_lex "$stdin", $P353
.annotate 'line', 146
    find_lex $P354, "%adverbs"
    unless_null $P354, vivify_109
    $P354 = root_new ['parrot';'Hash']
  vivify_109:
    set $P355, $P354["encoding"]
    unless_null $P355, vivify_110
    new $P355, "Undef"
  vivify_110:
    set $S356, $P355
    new $P357, 'String'
    set $P357, $S356
    store_lex "$encoding", $P357
.annotate 'line', 147
    find_lex $P361, "$encoding"
    if $P361, if_360
    set $P359, $P361
    goto if_360_end
  if_360:
    find_lex $P362, "$encoding"
    set $S363, $P362
    isne $I364, $S363, "fixed_8"
    new $P359, 'Integer'
    set $P359, $I364
  if_360_end:
    unless $P359, if_358_end
.annotate 'line', 148
    find_lex $P365, "$stdin"
    find_lex $P366, "$encoding"
    $P365."encoding"($P366)
  if_358_end:
.annotate 'line', 147
    find_lex $P367, "$save_ctx"
.annotate 'line', 152
    new $P481, 'ExceptionHandler'
    set_label $P481, loop480_handler
    $P481."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P481
  loop480_test:
    new $P368, "Integer"
    assign $P368, 1
    unless $P368, loop480_done
  loop480_redo:
    .const 'Sub' $P370 = "31_1299602521.155" 
    capture_lex $P370
    $P370()
  loop480_next:
    goto loop480_test
  loop480_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P482, exception, 'type'
    eq $P482, .CONTROL_LOOP_NEXT, loop480_next
    eq $P482, .CONTROL_LOOP_REDO, loop480_redo
  loop480_done:
    pop_eh 
.annotate 'line', 140
    .return ($P368)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block369"  :anon :subid("31_1299602521.155") :outer("30_1299602521.155")
.annotate 'line', 152
    .const 'Sub' $P402 = "32_1299602521.155" 
    capture_lex $P402
.annotate 'line', 155
    new $P371, "Undef"
    .lex "$prompt", $P371
.annotate 'line', 156
    new $P372, "Undef"
    .lex "$code", $P372
.annotate 'line', 161
    new $P373, "Undef"
    .lex "$*AUTOPRINTPOS", $P373
.annotate 'line', 162
    new $P374, "Undef"
    .lex "$*CTXSAVE", $P374
.annotate 'line', 163
    new $P375, "Undef"
    .lex "$*MAIN_CTX", $P375
.annotate 'line', 153
    find_lex $P377, "$stdin"
    if $P377, unless_376_end
    set $I378, .CONTROL_LOOP_LAST
    die 0, $I378
  unless_376_end:
.annotate 'line', 155
    find_lex $P380, "self"
    $P381 = $P380."commandline_prompt"()
    set $P379, $P381
    defined $I383, $P379
    if $I383, default_382
    new $P384, "String"
    assign $P384, "> "
    set $P379, $P384
  default_382:
    store_lex "$prompt", $P379
.annotate 'line', 156
    find_lex $P385, "$stdin"
    find_lex $P386, "$prompt"
    set $S387, $P386
    $P388 = $P385."readline_interactive"($S387)
    store_lex "$code", $P388
.annotate 'line', 158
    find_lex $P390, "$code"
    isnull $I391, $P390
    unless $I391, if_389_end
    set $I392, .CONTROL_LOOP_LAST
    die 0, $I392
  if_389_end:
.annotate 'line', 161
    getinterp $P393
    $P394 = $P393."stdout_handle"()
    $P395 = $P394."tell"()
    store_lex "$*AUTOPRINTPOS", $P395
.annotate 'line', 162
    find_lex $P396, "self"
    store_lex "$*CTXSAVE", $P396
    find_lex $P397, "$*MAIN_CTX"
    unless_null $P397, vivify_111
    get_hll_global $P397, "$MAIN_CTX"
    unless_null $P397, vivify_112
    die "Contextual $*MAIN_CTX not found"
  vivify_112:
  vivify_111:
.annotate 'line', 165
    find_lex $P400, "$code"
    if $P400, if_399
    set $P398, $P400
    goto if_399_end
  if_399:
    .const 'Sub' $P402 = "32_1299602521.155" 
    capture_lex $P402
    $P479 = $P402()
    set $P398, $P479
  if_399_end:
.annotate 'line', 152
    .return ($P398)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block401"  :anon :subid("32_1299602521.155") :outer("31_1299602521.155")
.annotate 'line', 165
    .const 'Sub' $P435 = "35_1299602521.155" 
    capture_lex $P435
    .const 'Sub' $P408 = "33_1299602521.155" 
    capture_lex $P408
.annotate 'line', 167
    new $P403, "Undef"
    .lex "$output", $P403
.annotate 'line', 166
    find_lex $P404, "$code"
    concat $P405, $P404, "\n"
    store_lex "$code", $P405
    find_lex $P406, "$output"
.annotate 'line', 168
    .const 'Sub' $P408 = "33_1299602521.155" 
    capture_lex $P408
    $P408()
.annotate 'line', 175
    find_dynamic_lex $P432, "$*MAIN_CTX"
    unless_null $P432, vivify_113
    get_hll_global $P432, "$MAIN_CTX"
    unless_null $P432, vivify_114
    die "Contextual $*MAIN_CTX not found"
  vivify_114:
  vivify_113:
    defined $I433, $P432
    unless $I433, if_431_end
    .const 'Sub' $P435 = "35_1299602521.155" 
    capture_lex $P435
    $P435()
  if_431_end:
.annotate 'line', 183
    find_lex $P458, "$output"
    isnull $I459, $P458
    unless $I459, if_457_end
    set $I460, .CONTROL_LOOP_NEXT
    die 0, $I460
  if_457_end:
.annotate 'line', 185
    find_lex $P463, "$target"
    isfalse $I464, $P463
    if $I464, if_462
.annotate 'line', 187
    find_lex $P470, "$target"
    set $S471, $P470
    iseq $I472, $S471, "pir"
    if $I472, if_469
.annotate 'line', 190
    find_lex $P474, "self"
    find_lex $P475, "$output"
    find_lex $P476, "$target"
    find_lex $P477, "%adverbs"
    $P478 = $P474."dumper"($P475, $P476, $P477 :flat)
.annotate 'line', 189
    set $P468, $P478
.annotate 'line', 187
    goto if_469_end
  if_469:
.annotate 'line', 188
    find_lex $P473, "$output"
    say $P473
  if_469_end:
.annotate 'line', 187
    set $P461, $P468
.annotate 'line', 185
    goto if_462_end
  if_462:
.annotate 'line', 186
    find_lex $P465, "self"
    find_lex $P466, "$output"
    $P467 = $P465."autoprint"($P466)
.annotate 'line', 185
    set $P461, $P467
  if_462_end:
.annotate 'line', 165
    .return ($P461)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block407"  :anon :subid("33_1299602521.155") :outer("32_1299602521.155")
.annotate 'line', 168
    .const 'Sub' $P420 = "34_1299602521.155" 
    capture_lex $P420
    new $P416, 'ExceptionHandler'
    set_label $P416, control_415
    $P416."handle_types_except"(.CONTROL_RETURN,  .CONTROL_OK,  .CONTROL_BREAK,  .CONTROL_CONTINUE,  .CONTROL_TAKE,  .CONTROL_LEAVE,  .CONTROL_EXIT,  .CONTROL_LOOP_NEXT,  .CONTROL_LOOP_LAST,  .CONTROL_LOOP_REDO)
    push_eh $P416
.annotate 'line', 169
    find_lex $P409, "self"
    find_lex $P410, "$code"
    find_lex $P411, "$save_ctx"
    find_lex $P412, "%adverbs"
    $P413 = $P409."eval"($P410, $P412 :flat, $P411 :named("outer_ctx"))
    store_lex "$output", $P413
.annotate 'line', 168
    pop_eh 
    goto skip_handler_414
  control_415:
.annotate 'line', 170
    .local pmc exception 
    .get_results (exception) 
    .const 'Sub' $P420 = "34_1299602521.155" 
    newclosure $P428, $P420
    $P428(exception)
    new $P429, 'Integer'
    set $P429, 1
    set exception["handled"], $P429
    set $I430, exception["handled"]
    ne $I430, 1, nothandled_418
  handled_417:
    .return (exception)
  nothandled_418:
    rethrow exception
  skip_handler_414:
.annotate 'line', 168
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block419"  :anon :subid("34_1299602521.155") :outer("33_1299602521.155")
    .param pmc param_421
.annotate 'line', 170
    .lex "$_", param_421
    find_lex $P422, "$_"
    .lex "$!", $P422
.annotate 'line', 171
    find_lex $P423, "$!"
    set $S424, $P423
    new $P425, 'String'
    set $P425, $S424
    concat $P426, $P425, "\n"
    print $P426
.annotate 'line', 172
    set $I427, .CONTROL_LOOP_NEXT
    die 0, $I427
.annotate 'line', 170
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block434"  :anon :subid("35_1299602521.155") :outer("32_1299602521.155")
.annotate 'line', 175
    .const 'Sub' $P446 = "36_1299602521.155" 
    capture_lex $P446
.annotate 'line', 176
    get_global $P436, "$interactive_ctx"
    unless_null $P436, vivify_115
    new $P436, "Undef"
    set_global "$interactive_ctx", $P436
  vivify_115:
.annotate 'line', 177
    get_global $P437, "%interactive_pad"
    unless_null $P437, vivify_116
    $P437 = root_new ['parrot';'Hash']
    set_global "%interactive_pad", $P437
  vivify_116:
.annotate 'line', 175
    get_global $P438, "$interactive_ctx"
    get_global $P439, "%interactive_pad"
.annotate 'line', 178
    find_dynamic_lex $P441, "$*MAIN_CTX"
    unless_null $P441, vivify_117
    get_hll_global $P441, "$MAIN_CTX"
    unless_null $P441, vivify_118
    die "Contextual $*MAIN_CTX not found"
  vivify_118:
  vivify_117:
    $P442 = $P441."lexpad_full"()
    defined $I443, $P442
    unless $I443, for_undef_119
    iter $P440, $P442
    new $P454, 'ExceptionHandler'
    set_label $P454, loop453_handler
    $P454."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P454
  loop453_test:
    unless $P440, loop453_done
    shift $P444, $P440
  loop453_redo:
    .const 'Sub' $P446 = "36_1299602521.155" 
    capture_lex $P446
    $P446($P444)
  loop453_next:
    goto loop453_test
  loop453_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P455, exception, 'type'
    eq $P455, .CONTROL_LOOP_NEXT, loop453_next
    eq $P455, .CONTROL_LOOP_REDO, loop453_redo
  loop453_done:
    pop_eh 
  for_undef_119:
.annotate 'line', 181
    get_global $P456, "$interactive_ctx"
    store_lex "$save_ctx", $P456
.annotate 'line', 175
    .return ($P456)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block445"  :anon :subid("36_1299602521.155") :outer("35_1299602521.155")
    .param pmc param_447
.annotate 'line', 178
    .lex "$_", param_447
.annotate 'line', 179
    find_lex $P448, "$_"
    $P449 = $P448."value"()
    find_lex $P450, "$_"
    $P451 = $P450."key"()
    get_global $P452, "%interactive_pad"
    unless_null $P452, vivify_120
    $P452 = root_new ['parrot';'Hash']
    set_global "%interactive_pad", $P452
  vivify_120:
    set $P452[$P451], $P449
.annotate 'line', 178
    .return ($P449)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "eval"  :subid("37_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_484
    .param pmc param_485
    .param pmc param_486 :slurpy
    .param pmc param_487 :slurpy :named
.annotate 'line', 196
    .const 'Sub' $P506 = "38_1299602521.155" 
    capture_lex $P506
    .lex "self", param_484
    .lex "$code", param_485
    .lex "@args", param_486
    .lex "%adverbs", param_487
.annotate 'line', 197
    new $P488, "Undef"
    .lex "$output", $P488
.annotate 'line', 196
    find_lex $P489, "$output"
.annotate 'line', 198
    find_lex $P490, "self"
    find_lex $P491, "$code"
    find_lex $P492, "%adverbs"
    $P493 = $P490."compile"($P491, $P492 :flat)
    store_lex "$output", $P493
.annotate 'line', 200
    find_lex $P497, "$output"
    isa $I498, $P497, "String"
    new $P499, 'Integer'
    set $P499, $I498
    isfalse $I500, $P499
    if $I500, if_496
    new $P495, 'Integer'
    set $P495, $I500
    goto if_496_end
  if_496:
.annotate 'line', 201
    find_lex $P501, "%adverbs"
    unless_null $P501, vivify_121
    $P501 = root_new ['parrot';'Hash']
  vivify_121:
    set $P502, $P501["target"]
    unless_null $P502, vivify_122
    new $P502, "Undef"
  vivify_122:
    set $S503, $P502
    iseq $I504, $S503, ""
    new $P495, 'Integer'
    set $P495, $I504
  if_496_end:
    unless $P495, if_494_end
    .const 'Sub' $P506 = "38_1299602521.155" 
    capture_lex $P506
    $P506()
  if_494_end:
.annotate 'line', 200
    find_lex $P522, "$output"
.annotate 'line', 196
    .return ($P522)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block505"  :anon :subid("38_1299602521.155") :outer("37_1299602521.155")
.annotate 'line', 202
    new $P507, "Undef"
    .lex "$outer_ctx", $P507
    find_lex $P508, "%adverbs"
    unless_null $P508, vivify_123
    $P508 = root_new ['parrot';'Hash']
  vivify_123:
    set $P509, $P508["outer_ctx"]
    unless_null $P509, vivify_124
    new $P509, "Undef"
  vivify_124:
    store_lex "$outer_ctx", $P509
.annotate 'line', 203
    find_lex $P511, "$outer_ctx"
    defined $I512, $P511
    unless $I512, if_510_end
.annotate 'line', 204
    find_lex $P513, "$output"
    unless_null $P513, vivify_125
    $P513 = root_new ['parrot';'ResizablePMCArray']
  vivify_125:
    set $P514, $P513[0]
    unless_null $P514, vivify_126
    new $P514, "Undef"
  vivify_126:
    find_lex $P515, "$outer_ctx"
    $P514."set_outer_ctx"($P515)
  if_510_end:
.annotate 'line', 207
    find_lex $P516, "%adverbs"
    unless_null $P516, vivify_127
    $P516 = root_new ['parrot';'Hash']
  vivify_127:
    set $P517, $P516["trace"]
    unless_null $P517, vivify_128
    new $P517, "Undef"
  vivify_128:
    set $I518, $P517
    trace $I518
.annotate 'line', 208
    find_lex $P519, "$output"
    find_lex $P520, "@args"
    $P521 = $P519($P520 :flat)
    store_lex "$output", $P521
.annotate 'line', 209
    trace 0
.annotate 'line', 201
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "ctxsave"  :subid("39_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_524
.annotate 'line', 215
    .lex "self", param_524
.annotate 'line', 217

                $P0 = getinterp
                $P525 = $P0['context';1]
            
    store_dynamic_lex "$*MAIN_CTX", $P525
.annotate 'line', 221
    new $P526, "Integer"
    assign $P526, 0
    store_dynamic_lex "$*CTXSAVE", $P526
.annotate 'line', 215
    .return ($P526)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "panic"  :subid("40_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_528
    .param pmc param_529 :slurpy
.annotate 'line', 224
    .lex "self", param_528
    .lex "@args", param_529
.annotate 'line', 225
    find_lex $P530, "@args"
    join $S531, "", $P530
    die $S531
.annotate 'line', 224
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "stages"  :subid("41_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_533
    .param pmc param_534 :optional
    .param int has_param_534 :opt_flag
.annotate 'line', 228
    .lex "self", param_533
    if has_param_534, optparam_129
    $P535 = root_new ['parrot';'ResizablePMCArray']
    set param_534, $P535
  optparam_129:
    .lex "@value", param_534
.annotate 'line', 229
    find_lex $P537, "@value"
    set $N538, $P537
    unless $N538, if_536_end
.annotate 'line', 230
    find_lex $P539, "@value"
    find_lex $P540, "self"
    get_global $P541, "$?CLASS"
    setattribute $P540, $P541, "@!stages", $P539
  if_536_end:
.annotate 'line', 229
    find_lex $P542, "self"
    get_global $P543, "$?CLASS"
    getattribute $P544, $P542, $P543, "@!stages"
    unless_null $P544, vivify_130
    $P544 = root_new ['parrot';'ResizablePMCArray']
  vivify_130:
.annotate 'line', 228
    .return ($P544)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "parsegrammar"  :subid("42_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_546
    .param pmc param_547 :slurpy
.annotate 'line', 235
    .lex "self", param_546
    .lex "@value", param_547
.annotate 'line', 236
    find_lex $P549, "@value"
    set $N550, $P549
    unless $N550, if_548_end
.annotate 'line', 237
    find_lex $P551, "@value"
    unless_null $P551, vivify_131
    $P551 = root_new ['parrot';'ResizablePMCArray']
  vivify_131:
    set $P552, $P551[0]
    unless_null $P552, vivify_132
    new $P552, "Undef"
  vivify_132:
    find_lex $P553, "self"
    get_global $P554, "$?CLASS"
    setattribute $P553, $P554, "$!parsegrammar", $P552
  if_548_end:
.annotate 'line', 236
    find_lex $P555, "self"
    get_global $P556, "$?CLASS"
    getattribute $P557, $P555, $P556, "$!parsegrammar"
    unless_null $P557, vivify_133
    new $P557, "Undef"
  vivify_133:
.annotate 'line', 235
    .return ($P557)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "parseactions"  :subid("43_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_559
    .param pmc param_560 :slurpy
.annotate 'line', 242
    .lex "self", param_559
    .lex "@value", param_560
.annotate 'line', 243
    find_lex $P562, "@value"
    set $N563, $P562
    unless $N563, if_561_end
.annotate 'line', 244
    find_lex $P564, "@value"
    unless_null $P564, vivify_134
    $P564 = root_new ['parrot';'ResizablePMCArray']
  vivify_134:
    set $P565, $P564[0]
    unless_null $P565, vivify_135
    new $P565, "Undef"
  vivify_135:
    find_lex $P566, "self"
    get_global $P567, "$?CLASS"
    setattribute $P566, $P567, "$!parseactions", $P565
  if_561_end:
.annotate 'line', 243
    find_lex $P568, "self"
    get_global $P569, "$?CLASS"
    getattribute $P570, $P568, $P569, "$!parseactions"
    unless_null $P570, vivify_136
    new $P570, "Undef"
  vivify_136:
.annotate 'line', 242
    .return ($P570)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "astgrammar"  :subid("44_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_572
    .param pmc param_573 :slurpy
.annotate 'line', 249
    .lex "self", param_572
    .lex "@value", param_573
.annotate 'line', 250
    find_lex $P575, "@value"
    set $N576, $P575
    unless $N576, if_574_end
.annotate 'line', 251
    find_lex $P577, "@value"
    unless_null $P577, vivify_137
    $P577 = root_new ['parrot';'ResizablePMCArray']
  vivify_137:
    set $P578, $P577[0]
    unless_null $P578, vivify_138
    new $P578, "Undef"
  vivify_138:
    find_lex $P579, "self"
    get_global $P580, "$?CLASS"
    setattribute $P579, $P580, "$!astgrammar", $P578
  if_574_end:
.annotate 'line', 250
    find_lex $P581, "self"
    get_global $P582, "$?CLASS"
    getattribute $P583, $P581, $P582, "$!astgrammar"
    unless_null $P583, vivify_139
    new $P583, "Undef"
  vivify_139:
.annotate 'line', 249
    .return ($P583)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "commandline_banner"  :subid("45_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_585
    .param pmc param_586 :optional
    .param int has_param_586 :opt_flag
.annotate 'line', 256
    .lex "self", param_585
    if has_param_586, optparam_140
    new $P587, "Undef"
    set param_586, $P587
  optparam_140:
    .lex "$value", param_586
.annotate 'line', 257
    find_lex $P589, "$value"
    defined $I590, $P589
    unless $I590, if_588_end
.annotate 'line', 258
    find_lex $P591, "$value"
    find_lex $P592, "self"
    get_global $P593, "$?CLASS"
    setattribute $P592, $P593, "$!commandline_banner", $P591
  if_588_end:
.annotate 'line', 257
    find_lex $P594, "self"
    get_global $P595, "$?CLASS"
    getattribute $P596, $P594, $P595, "$!commandline_banner"
    unless_null $P596, vivify_141
    new $P596, "Undef"
  vivify_141:
.annotate 'line', 256
    .return ($P596)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "commandline_prompt"  :subid("46_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_598
    .param pmc param_599 :optional
    .param int has_param_599 :opt_flag
.annotate 'line', 263
    .lex "self", param_598
    if has_param_599, optparam_142
    new $P600, "Undef"
    set param_599, $P600
  optparam_142:
    .lex "$value", param_599
.annotate 'line', 264
    find_lex $P602, "$value"
    defined $I603, $P602
    unless $I603, if_601_end
.annotate 'line', 265
    find_lex $P604, "$value"
    find_lex $P605, "self"
    get_global $P606, "$?CLASS"
    setattribute $P605, $P606, "$!commandline_prompt", $P604
  if_601_end:
.annotate 'line', 264
    find_lex $P607, "self"
    get_global $P608, "$?CLASS"
    getattribute $P609, $P607, $P608, "$!commandline_prompt"
    unless_null $P609, vivify_143
    new $P609, "Undef"
  vivify_143:
.annotate 'line', 263
    .return ($P609)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "compiler_progname"  :subid("47_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_611
    .param pmc param_612 :optional
    .param int has_param_612 :opt_flag
.annotate 'line', 270
    .lex "self", param_611
    if has_param_612, optparam_144
    new $P613, "Undef"
    set param_612, $P613
  optparam_144:
    .lex "$value", param_612
.annotate 'line', 271
    find_lex $P615, "$value"
    defined $I616, $P615
    unless $I616, if_614_end
.annotate 'line', 272
    find_lex $P617, "$value"
    find_lex $P618, "self"
    get_global $P619, "$?CLASS"
    setattribute $P618, $P619, "$!compiler_progname", $P617
  if_614_end:
.annotate 'line', 271
    find_lex $P620, "self"
    get_global $P621, "$?CLASS"
    getattribute $P622, $P620, $P621, "$!compiler_progname"
    unless_null $P622, vivify_145
    new $P622, "Undef"
  vivify_145:
.annotate 'line', 270
    .return ($P622)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "commandline_options"  :subid("48_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_624
    .param pmc param_625 :optional
    .param int has_param_625 :opt_flag
.annotate 'line', 277
    .lex "self", param_624
    if has_param_625, optparam_146
    $P626 = root_new ['parrot';'ResizablePMCArray']
    set param_625, $P626
  optparam_146:
    .lex "@value", param_625
.annotate 'line', 278
    find_lex $P628, "@value"
    set $N629, $P628
    unless $N629, if_627_end
.annotate 'line', 279
    find_lex $P630, "@value"
    find_lex $P631, "self"
    get_global $P632, "$?CLASS"
    setattribute $P631, $P632, "@!cmdoptions", $P630
  if_627_end:
.annotate 'line', 278
    find_lex $P633, "self"
    get_global $P634, "$?CLASS"
    getattribute $P635, $P633, $P634, "@!cmdoptions"
    unless_null $P635, vivify_147
    $P635 = root_new ['parrot';'ResizablePMCArray']
  vivify_147:
.annotate 'line', 277
    .return ($P635)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "command_line"  :subid("49_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_637
    .param pmc param_638
    .param pmc param_639 :slurpy :named
.annotate 'line', 284
    .const 'Sub' $P665 = "50_1299602521.155" 
    capture_lex $P665
    .lex "self", param_637
    .lex "@args", param_638
    .lex "%adverbs", param_639
.annotate 'line', 297
    new $P640, "Undef"
    .lex "$program-name", $P640
.annotate 'line', 298
    new $P641, "Undef"
    .lex "$res", $P641
.annotate 'line', 299
    $P642 = root_new ['parrot';'Hash']
    .lex "%opts", $P642
.annotate 'line', 300
    $P643 = root_new ['parrot';'ResizablePMCArray']
    .lex "@a", $P643
.annotate 'line', 293
    find_lex $P645, "@args"
    unless_null $P645, vivify_148
    $P645 = root_new ['parrot';'ResizablePMCArray']
  vivify_148:
    set $P646, $P645[2]
    unless_null $P646, vivify_149
    new $P646, "Undef"
  vivify_149:
    set $S647, $P646
    index $I648, $S647, "@INC"
    set $N649, $I648
    isge $I650, $N649, 0.0
    unless $I650, if_644_end
.annotate 'line', 294
    exit 0
  if_644_end:
.annotate 'line', 297
    find_lex $P651, "@args"
    unless_null $P651, vivify_150
    $P651 = root_new ['parrot';'ResizablePMCArray']
  vivify_150:
    set $P652, $P651[0]
    unless_null $P652, vivify_151
    new $P652, "Undef"
  vivify_151:
    store_lex "$program-name", $P652
.annotate 'line', 298
    find_lex $P653, "self"
    find_lex $P654, "@args"
    $P655 = $P653."process_args"($P654)
    store_lex "$res", $P655
.annotate 'line', 299
    find_lex $P656, "$res"
    $P657 = $P656."options"()
    store_lex "%opts", $P657
.annotate 'line', 300
    find_lex $P658, "$res"
    $P659 = $P658."arguments"()
    store_lex "@a", $P659
.annotate 'line', 302
    find_lex $P661, "%opts"
    defined $I662, $P661
    unless $I662, for_undef_152
    iter $P660, $P661
    new $P673, 'ExceptionHandler'
    set_label $P673, loop672_handler
    $P673."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P673
  loop672_test:
    unless $P660, loop672_done
    shift $P663, $P660
  loop672_redo:
    .const 'Sub' $P665 = "50_1299602521.155" 
    capture_lex $P665
    $P665($P663)
  loop672_next:
    goto loop672_test
  loop672_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P674, exception, 'type'
    eq $P674, .CONTROL_LOOP_NEXT, loop672_next
    eq $P674, .CONTROL_LOOP_REDO, loop672_redo
  loop672_done:
    pop_eh 
  for_undef_152:
.annotate 'line', 305
    find_lex $P676, "%adverbs"
    unless_null $P676, vivify_156
    $P676 = root_new ['parrot';'Hash']
  vivify_156:
    set $P677, $P676["help"]
    unless_null $P677, vivify_157
    new $P677, "Undef"
  vivify_157:
    unless $P677, if_675_end
    find_lex $P678, "self"
    find_lex $P679, "$program-name"
    $P678."usage"($P679)
  if_675_end:
.annotate 'line', 306
    find_lex $P681, "%adverbs"
    unless_null $P681, vivify_158
    $P681 = root_new ['parrot';'Hash']
  vivify_158:
    set $P682, $P681["version"]
    unless_null $P682, vivify_159
    new $P682, "Undef"
  vivify_159:
    unless $P682, if_680_end
    find_lex $P683, "self"
    $P683."version"()
  if_680_end:
.annotate 'line', 308

            .include 'except_severity.pasm'
            .local pmc args, adverbs, self
            args = find_lex '@a'
            adverbs = find_lex '%adverbs'
            self = find_lex 'self'

            load_bytecode 'dumper.pbc'
            load_bytecode 'PGE/Dumper.pbc'


            .local int can_backtrace, ll_backtrace
            can_backtrace = can self, 'backtrace'
            unless can_backtrace goto no_push_eh
            ll_backtrace = adverbs['ll-backtrace']
            if ll_backtrace goto no_push_eh
            push_eh uncaught_exception
          no_push_eh:

            $S0 = adverbs['e']
            $I0 = exists adverbs['e']
            if $I0 goto eval_line
            .local pmc result
            result = box ''
            unless args goto interactive
            $I0 = adverbs['combine']
            if $I0 goto combine
            $S0 = args[0]
            result = self.'evalfiles'($S0, args :flat, adverbs :flat :named)
            goto save_output
          combine:
            result = self.'evalfiles'(args, adverbs :flat :named)
            goto save_output
          interactive:
            self.'interactive'(args :flat, adverbs :flat :named)
            goto save_output
          eval_line:
            result = self.'eval'($S0, '-e', args :flat, adverbs :flat :named)

          save_output:
            unless can_backtrace goto no_pop_eh
            pop_eh
          no_pop_eh:
            if null result goto end
            $I0 = defined result
            unless $I0 goto end
            .local string target
            target = adverbs['target']
            target = downcase target
            if target != 'pir' goto end
            .local string output
            .local pmc ofh
            $P0 = getinterp
            ofh = $P0.'stdout_handle'()
            output = adverbs['output']
            if output == '' goto save_output_1
            if output == '-' goto save_output_1
            ofh = new ['FileHandle']
            ofh.'open'(output, 'w')
            unless ofh goto err_output
          save_output_1:
            print ofh, result
            ofh.'close'()
          end:
            .return ()

          err_output:
            .tailcall self.'panic'('Error: file cannot be written: ', output)

            # If we get an uncaught exception in the program and the HLL provides
            # a backtrace method, we end up here. We pass it the exception object
            # so it can render a backtrace, unless the severity is exit or warning
            # in which case it needs special handling.
          uncaught_exception:
            .get_results ($P0)
            pop_eh
            $P1 = getinterp
            $P1 = $P1.'stderr_handle'()
            $I0 = $P0['severity']
            if $I0 == .EXCEPT_EXIT goto do_exit
            $S0 = self.'backtrace'($P0)
            print $P1, $S0
            if $I0 <= .EXCEPT_WARNING goto do_warning
            exit 1
          do_exit:
            $I0 = $P0['exit_code']
            exit $I0
          do_warning:
            $P0 = $P0["resume"]
            push_eh uncaught_exception # Otherwise we get errors about no handler to delete
            $P0()
        
.annotate 'line', 284
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block664"  :anon :subid("50_1299602521.155") :outer("49_1299602521.155")
    .param pmc param_666
.annotate 'line', 302
    .lex "$k", param_666
.annotate 'line', 303
    find_lex $P667, "$k"
    find_lex $P668, "%opts"
    unless_null $P668, vivify_153
    $P668 = root_new ['parrot';'Hash']
  vivify_153:
    set $P669, $P668[$P667]
    unless_null $P669, vivify_154
    new $P669, "Undef"
  vivify_154:
    find_lex $P670, "$k"
    find_lex $P671, "%adverbs"
    unless_null $P671, vivify_155
    $P671 = root_new ['parrot';'Hash']
    store_lex "%adverbs", $P671
  vivify_155:
    set $P671[$P670], $P669
.annotate 'line', 302
    .return ($P669)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "process_args"  :subid("51_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_685
    .param pmc param_686
.annotate 'line', 402
    .const 'Sub' $P701 = "52_1299602521.155" 
    capture_lex $P701
    .lex "self", param_685
    .lex "@args", param_686
.annotate 'line', 406
    new $P687, "Undef"
    .lex "$p", $P687
.annotate 'line', 409
    new $P688, "Undef"
    .lex "$res", $P688
.annotate 'line', 404
    find_lex $P689, "self"
    find_lex $P690, "@args"
    $P691 = $P690."shift"()
    $P689."compiler_progname"($P691)
.annotate 'line', 406
    get_hll_global $P692, ["HLL";"CommandLine"], "Parser"
    find_lex $P693, "self"
    get_global $P694, "$?CLASS"
    getattribute $P695, $P693, $P694, "@!cmdoptions"
    unless_null $P695, vivify_160
    $P695 = root_new ['parrot';'ResizablePMCArray']
  vivify_160:
    $P696 = $P692."new"($P695)
    store_lex "$p", $P696
.annotate 'line', 407
    find_lex $P697, "$p"
    $P697."add-stopper"("-e")
.annotate 'line', 408
    find_lex $P698, "$p"
    $P698."stop-after-first-arg"()
    find_lex $P699, "$res"
.annotate 'line', 410
    .const 'Sub' $P701 = "52_1299602521.155" 
    capture_lex $P701
    $P701()
    find_lex $P719, "$res"
.annotate 'line', 402
    .return ($P719)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block700"  :anon :subid("52_1299602521.155") :outer("51_1299602521.155")
.annotate 'line', 410
    .const 'Sub' $P711 = "53_1299602521.155" 
    capture_lex $P711
    new $P707, 'ExceptionHandler'
    set_label $P707, control_706
    $P707."handle_types_except"(.CONTROL_RETURN,  .CONTROL_OK,  .CONTROL_BREAK,  .CONTROL_CONTINUE,  .CONTROL_TAKE,  .CONTROL_LEAVE,  .CONTROL_EXIT,  .CONTROL_LOOP_NEXT,  .CONTROL_LOOP_LAST,  .CONTROL_LOOP_REDO)
    push_eh $P707
.annotate 'line', 411
    find_lex $P702, "$p"
    find_lex $P703, "@args"
    $P704 = $P702."parse"($P703)
    store_lex "$res", $P704
.annotate 'line', 410
    pop_eh 
    goto skip_handler_705
  control_706:
.annotate 'line', 412
    .local pmc exception 
    .get_results (exception) 
    .const 'Sub' $P711 = "53_1299602521.155" 
    newclosure $P716, $P711
    $P716(exception)
    new $P717, 'Integer'
    set $P717, 1
    set exception["handled"], $P717
    set $I718, exception["handled"]
    ne $I718, 1, nothandled_709
  handled_708:
    .return (exception)
  nothandled_709:
    rethrow exception
  skip_handler_705:
.annotate 'line', 410
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block710"  :anon :subid("53_1299602521.155") :outer("52_1299602521.155")
    .param pmc param_712
.annotate 'line', 412
    .lex "$_", param_712
    find_lex $P713, "$_"
    .lex "$!", $P713
.annotate 'line', 413
    find_lex $P714, "$_"
    say $P714
.annotate 'line', 414
    find_lex $P715, "self"
    $P715."usage"()
.annotate 'line', 415
    exit 1
.annotate 'line', 412
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "evalfiles"  :subid("54_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_723
    .param pmc param_724
    .param pmc param_725 :slurpy
    .param pmc param_726 :slurpy :named
.annotate 'line', 421
    .const 'Sub' $P751 = "55_1299602521.155" 
    capture_lex $P751
    new $P722, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P722, control_721
    push_eh $P722
    .lex "self", param_723
    .lex "$files", param_724
    .lex "@args", param_725
    .lex "%adverbs", param_726
.annotate 'line', 422
    new $P727, "Undef"
    .lex "$target", $P727
.annotate 'line', 423
    new $P728, "Undef"
    .lex "$encoding", $P728
.annotate 'line', 424
    $P729 = root_new ['parrot';'ResizablePMCArray']
    .lex "@files", $P729
.annotate 'line', 425
    $P730 = root_new ['parrot';'ResizablePMCArray']
    .lex "@codes", $P730
.annotate 'line', 422
    find_lex $P731, "%adverbs"
    unless_null $P731, vivify_161
    $P731 = root_new ['parrot';'Hash']
  vivify_161:
    set $P732, $P731["target"]
    unless_null $P732, vivify_162
    new $P732, "Undef"
  vivify_162:
    set $S733, $P732
    downcase $S734, $S733
    new $P735, 'String'
    set $P735, $S734
    store_lex "$target", $P735
.annotate 'line', 423
    find_lex $P736, "%adverbs"
    unless_null $P736, vivify_163
    $P736 = root_new ['parrot';'Hash']
  vivify_163:
    set $P737, $P736["encoding"]
    unless_null $P737, vivify_164
    new $P737, "Undef"
  vivify_164:
    store_lex "$encoding", $P737
.annotate 'line', 424
    find_lex $P740, "$files"
    does $I741, $P740, "array"
    if $I741, if_739
    find_lex $P743, "$files"
    new $P744, "ResizablePMCArray"
    push $P744, $P743
    set $P738, $P744
    goto if_739_end
  if_739:
    find_lex $P742, "$files"
    set $P738, $P742
  if_739_end:
    store_lex "@files", $P738
    find_lex $P745, "@codes"
.annotate 'line', 426
    find_lex $P747, "@files"
    defined $I748, $P747
    unless $I748, for_undef_165
    iter $P746, $P747
    new $P813, 'ExceptionHandler'
    set_label $P813, loop812_handler
    $P813."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P813
  loop812_test:
    unless $P746, loop812_done
    shift $P749, $P746
  loop812_redo:
    .const 'Sub' $P751 = "55_1299602521.155" 
    capture_lex $P751
    $P751($P749)
  loop812_next:
    goto loop812_test
  loop812_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P814, exception, 'type'
    eq $P814, .CONTROL_LOOP_NEXT, loop812_next
    eq $P814, .CONTROL_LOOP_REDO, loop812_redo
  loop812_done:
    pop_eh 
  for_undef_165:
.annotate 'line', 421
    .return ($P746)
  control_721:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P815, exception, "payload"
    .return ($P815)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block750"  :anon :subid("55_1299602521.155") :outer("54_1299602521.155")
    .param pmc param_756
.annotate 'line', 426
    .const 'Sub' $P760 = "56_1299602521.155" 
    capture_lex $P760
.annotate 'line', 427
    new $P752, "Undef"
    .lex "$in-handle", $P752
.annotate 'line', 428
    new $P753, "Undef"
    .lex "$err", $P753
.annotate 'line', 441
    new $P754, "Undef"
    .lex "$code", $P754
.annotate 'line', 443
    new $P755, "Undef"
    .lex "$r", $P755
    .lex "$_", param_756
.annotate 'line', 427
    new $P757, "FileHandle"
    store_lex "$in-handle", $P757
.annotate 'line', 428
    new $P758, "Integer"
    assign $P758, 0
    store_lex "$err", $P758
.annotate 'line', 429
    .const 'Sub' $P760 = "56_1299602521.155" 
    capture_lex $P760
    $P760()
.annotate 'line', 440
    find_lex $P784, "$err"
    unless $P784, if_783_end
    find_lex $P785, "$err"
    die $P785
  if_783_end:
.annotate 'line', 441
    find_lex $P786, "@codes"
    join $S787, "", $P786
    new $P788, 'String'
    set $P788, $S787
    store_lex "$code", $P788
.annotate 'line', 443
    find_lex $P789, "self"
    find_lex $P790, "$code"
    find_lex $P791, "@args"
    find_lex $P792, "%adverbs"
    $P793 = $P789."eval"($P790, $P791 :flat, $P792 :flat)
    store_lex "$r", $P793
.annotate 'line', 444
    find_lex $P798, "$target"
    set $S799, $P798
    iseq $I800, $S799, ""
    unless $I800, unless_797
    new $P796, 'Integer'
    set $P796, $I800
    goto unless_797_end
  unless_797:
    find_lex $P801, "$target"
    set $S802, $P801
    iseq $I803, $S802, "pir"
    new $P796, 'Integer'
    set $P796, $I803
  unless_797_end:
    if $P796, if_795
.annotate 'line', 447
    new $P806, "Exception"
    set $P806['type'], .CONTROL_RETURN
    find_lex $P807, "self"
    find_lex $P808, "$r"
    find_lex $P809, "$target"
    find_lex $P810, "%adverbs"
    $P811 = $P807."dumper"($P808, $P809, $P810 :flat)
    setattribute $P806, 'payload', $P811
    throw $P806
.annotate 'line', 446
    goto if_795_end
  if_795:
.annotate 'line', 445
    new $P804, "Exception"
    set $P804['type'], .CONTROL_RETURN
    find_lex $P805, "$r"
    setattribute $P804, 'payload', $P805
    throw $P804
  if_795_end:
.annotate 'line', 426
    .return ($P794)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block759"  :anon :subid("56_1299602521.155") :outer("55_1299602521.155")
.annotate 'line', 429
    .const 'Sub' $P774 = "57_1299602521.155" 
    capture_lex $P774
    new $P770, 'ExceptionHandler'
    set_label $P770, control_769
    $P770."handle_types_except"(.CONTROL_RETURN,  .CONTROL_OK,  .CONTROL_BREAK,  .CONTROL_CONTINUE,  .CONTROL_TAKE,  .CONTROL_LEAVE,  .CONTROL_EXIT,  .CONTROL_LOOP_NEXT,  .CONTROL_LOOP_LAST,  .CONTROL_LOOP_REDO)
    push_eh $P770
.annotate 'line', 433
    find_lex $P761, "$in-handle"
    find_lex $P762, "$encoding"
    $P761."encoding"($P762)
.annotate 'line', 434
    find_lex $P763, "@codes"
    find_lex $P764, "$in-handle"
    find_lex $P765, "$_"
    $P766 = $P764."readall"($P765)
    push $P763, $P766
.annotate 'line', 435
    find_lex $P767, "$in-handle"
    $P767."close"()
.annotate 'line', 429
    pop_eh 
    goto skip_handler_768
  control_769:
.annotate 'line', 436
    .local pmc exception 
    .get_results (exception) 
    .const 'Sub' $P774 = "57_1299602521.155" 
    newclosure $P780, $P774
    $P780(exception)
    new $P781, 'Integer'
    set $P781, 1
    set exception["handled"], $P781
    set $I782, exception["handled"]
    ne $I782, 1, nothandled_772
  handled_771:
    .return (exception)
  nothandled_772:
    rethrow exception
  skip_handler_768:
.annotate 'line', 429
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block773"  :anon :subid("57_1299602521.155") :outer("56_1299602521.155")
    .param pmc param_775
.annotate 'line', 436
    .lex "$_", param_775
    find_lex $P776, "$_"
    .lex "$!", $P776
.annotate 'line', 437
    new $P777, 'String'
    set $P777, "Error while reading from file: "
    find_lex $P778, "$_"
    concat $P779, $P777, $P778
    store_lex "$err", $P779
.annotate 'line', 436
    .return ($P779)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "compile"  :subid("58_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_819
    .param pmc param_820
    .param pmc param_821 :slurpy :named
.annotate 'line', 453
    .const 'Sub' $P842 = "59_1299602521.155" 
    capture_lex $P842
    new $P818, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P818, control_817
    push_eh $P818
    .lex "self", param_819
    .lex "$source", param_820
    .lex "%adverbs", param_821
.annotate 'line', 454
    $P822 = root_new ['parrot';'Hash']
    .lex "%*COMPILING", $P822
.annotate 'line', 456
    new $P823, "Undef"
    .lex "$target", $P823
.annotate 'line', 457
    new $P824, "Undef"
    .lex "$result", $P824
.annotate 'line', 458
    new $P825, "Undef"
    .lex "$stderr", $P825
.annotate 'line', 454
    find_lex $P826, "%adverbs"
    find_lex $P827, "%*COMPILING"
    unless_null $P827, vivify_166
    get_hll_global $P827, "%COMPILING"
    unless_null $P827, vivify_167
    die "Contextual %*COMPILING not found"
  vivify_167:
    store_lex "%*COMPILING", $P827
  vivify_166:
    set $P827["%?OPTIONS"], $P826
.annotate 'line', 456
    find_lex $P828, "%adverbs"
    unless_null $P828, vivify_168
    $P828 = root_new ['parrot';'Hash']
  vivify_168:
    set $P829, $P828["target"]
    unless_null $P829, vivify_169
    new $P829, "Undef"
  vivify_169:
    set $S830, $P829
    downcase $S831, $S830
    new $P832, 'String'
    set $P832, $S831
    store_lex "$target", $P832
.annotate 'line', 457
    find_lex $P833, "$source"
    store_lex "$result", $P833
.annotate 'line', 458
    getinterp $P834
    $P835 = $P834."stderr_handle"()
    store_lex "$stderr", $P835
.annotate 'line', 459
    find_lex $P837, "self"
    $P838 = $P837."stages"()
    defined $I839, $P838
    unless $I839, for_undef_170
    iter $P836, $P838
    new $P878, 'ExceptionHandler'
    set_label $P878, loop877_handler
    $P878."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P878
  loop877_test:
    unless $P836, loop877_done
    shift $P840, $P836
  loop877_redo:
    .const 'Sub' $P842 = "59_1299602521.155" 
    capture_lex $P842
    $P842($P840)
  loop877_next:
    goto loop877_test
  loop877_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P879, exception, 'type'
    eq $P879, .CONTROL_LOOP_NEXT, loop877_next
    eq $P879, .CONTROL_LOOP_REDO, loop877_redo
  loop877_done:
    pop_eh 
  for_undef_170:
.annotate 'line', 469
    new $P880, "Exception"
    set $P880['type'], .CONTROL_RETURN
    find_lex $P881, "$result"
    setattribute $P880, 'payload', $P881
    throw $P880
.annotate 'line', 453
    .return ()
  control_817:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P882, exception, "payload"
    .return ($P882)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block841"  :anon :subid("59_1299602521.155") :outer("58_1299602521.155")
    .param pmc param_845
.annotate 'line', 460
    new $P843, "Undef"
    .lex "$timestamp", $P843
.annotate 'line', 462
    new $P844, "Undef"
    .lex "$diff", $P844
    .lex "$_", param_845
.annotate 'line', 460
    time $N846
    new $P847, 'Float'
    set $P847, $N846
    store_lex "$timestamp", $P847
.annotate 'line', 461
    find_lex $P848, "self"
    find_lex $P849, "$result"
    find_lex $P850, "%adverbs"
    find_lex $P851, "$_"
    set $S852, $P851
    $P853 = $P848.$S852($P849, $P850 :flat)
    store_lex "$result", $P853
.annotate 'line', 462
    time $N854
    new $P855, 'Float'
    set $P855, $N854
    find_lex $P856, "$timestamp"
    sub $P857, $P855, $P856
    store_lex "$diff", $P857
.annotate 'line', 463
    find_lex $P859, "%adverbs"
    unless_null $P859, vivify_171
    $P859 = root_new ['parrot';'Hash']
  vivify_171:
    set $P860, $P859["stagestats"]
    unless_null $P860, vivify_172
    new $P860, "Undef"
  vivify_172:
    unless $P860, if_858_end
.annotate 'line', 465
    find_lex $P861, "$stderr"
    new $P862, 'String'
    set $P862, "Stage "
    find_lex $P863, "$_"
    concat $P864, $P862, $P863
    concat $P865, $P864, ": "
    find_lex $P866, "$diff"
    concat $P867, $P865, $P866
    concat $P868, $P867, "\n"
    $P861."print__N"($P868)
  if_858_end:
.annotate 'line', 467
    find_lex $P871, "$_"
    set $S872, $P871
    find_lex $P873, "$target"
    set $S874, $P873
    iseq $I875, $S872, $S874
    if $I875, if_870
    new $P869, 'Integer'
    set $P869, $I875
    goto if_870_end
  if_870:
    set $I876, .CONTROL_LOOP_LAST
    die 0, $I876
  if_870_end:
.annotate 'line', 459
    .return ($P869)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "parse"  :subid("60_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_884
    .param pmc param_885
    .param pmc param_886 :slurpy :named
.annotate 'line', 472
    .lex "self", param_884
    .lex "$source", param_885
    .lex "%adverbs", param_886
.annotate 'line', 473

            .local pmc source, options, self
            source = find_lex '$source'
            options = find_lex '%adverbs'
            self = find_lex 'self'

            .local string tcode
            tcode = options['transcode']
            unless tcode goto transcode_done
            .local pmc tcode_it
            $P0 = split ' ', tcode
            tcode_it = iter $P0
          tcode_loop:
            unless tcode_it goto transcode_done
            tcode = shift tcode_it
            push_eh tcode_fail
            $I0 = find_encoding tcode
            $S0 = source
            $S0 = trans_encoding $S0, $I0
            assign source, $S0
            pop_eh
            goto transcode_done
          tcode_fail:
            pop_eh
            goto tcode_loop
          transcode_done:

            .local pmc parsegrammar, parseactions, match
            parsegrammar = self.'parsegrammar'()

            null parseactions
            $S0 = options['target']
            if $S0 == 'parse' goto have_parseactions
            parseactions = self.'parseactions'()
          have_parseactions:

            .local int rxtrace
            rxtrace = options['parsetrace']
            match = parsegrammar.'parse'(source, 'p'=>0, 'actions'=>parseactions, 'rxtrace'=>rxtrace)
            unless match goto err_parsefail
            .return (match)

          err_parsefail:
            self.'panic'('Unable to parse source')
            .return (match)
        
.annotate 'line', 472
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "past"  :subid("61_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_888
    .param pmc param_889
    .param pmc param_890 :slurpy :named
.annotate 'line', 521
    .lex "self", param_888
    .lex "$source", param_889
    .lex "%adverbs", param_890
.annotate 'line', 522

            .local pmc source, adverbs, self
            source = find_lex '$source'
            adverbs = find_lex '%adverbs'
            self = find_lex 'self'

          compile_astgrammar:
            .local pmc astgrammar_name
            astgrammar_name = self.'astgrammar'()
            $S0 = typeof astgrammar_name
            eq $S0, 'NameSpace', astgrammar_ns
            unless astgrammar_name goto compile_match

            .local pmc astgrammar_namelist
            .local pmc astgrammar, astbuilder
            astgrammar_namelist = self.'parse_name'(astgrammar_name)
            unless astgrammar_namelist goto err_past
            astgrammar = new astgrammar_namelist
            astbuilder = astgrammar.'apply'(source)
            .tailcall astbuilder.'get'('past')
          astgrammar_ns:
            $P0 = get_class astgrammar_name
            astgrammar = new $P0
            astbuilder = astgrammar.'apply'(source)
            .tailcall astbuilder.'get'('past')

          compile_match:
            .local pmc ast
            ast = source.'ast'()
            $I0 = isa ast, ['PAST';'Node']
            unless $I0 goto err_past
            .return (ast)

          err_past:
            $S0 = typeof source
            .tailcall self.'panic'('Unable to obtain PAST from ', $S0)
        
.annotate 'line', 521
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "post"  :subid("62_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_892
    .param pmc param_893
    .param pmc param_894 :slurpy :named
.annotate 'line', 561
    .lex "self", param_892
    .lex "$source", param_893
    .lex "%adverbs", param_894
.annotate 'line', 562
    compreg $P895, "PAST"
    find_lex $P896, "$source"
    find_lex $P897, "%adverbs"
    $P898 = $P895."to_post"($P896, $P897 :flat)
.annotate 'line', 561
    .return ($P898)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "pir"  :subid("63_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_900
    .param pmc param_901
    .param pmc param_902 :slurpy :named
.annotate 'line', 565
    .lex "self", param_900
    .lex "$source", param_901
    .lex "%adverbs", param_902
.annotate 'line', 566
    compreg $P903, "POST"
    find_lex $P904, "$source"
    find_lex $P905, "%adverbs"
    $P906 = $P903."to_pir"($P904, $P905 :flat)
.annotate 'line', 565
    .return ($P906)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "evalpmc"  :subid("64_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_908
    .param pmc param_909
    .param pmc param_910 :slurpy :named
.annotate 'line', 569
    .lex "self", param_908
    .lex "$source", param_909
    .lex "%adverbs", param_910
.annotate 'line', 570
    new $P911, "Undef"
    .lex "$compiler", $P911
    compreg $P912, "PIR"
    store_lex "$compiler", $P912
.annotate 'line', 571
    find_lex $P913, "$compiler"
    find_lex $P914, "$source"
    $P915 = $P913($P914)
.annotate 'line', 569
    .return ($P915)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "dumper"  :subid("65_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_917
    .param pmc param_918
    .param pmc param_919
    .param pmc param_920 :slurpy :named
.annotate 'line', 574
    .const 'Sub' $P926 = "66_1299602521.155" 
    capture_lex $P926
    .lex "self", param_917
    .lex "$obj", param_918
    .lex "$name", param_919
    .lex "%options", param_920
.annotate 'line', 575
    find_lex $P923, "%options"
    unless_null $P923, vivify_173
    $P923 = root_new ['parrot';'Hash']
  vivify_173:
    set $P924, $P923["dumper"]
    unless_null $P924, vivify_174
    new $P924, "Undef"
  vivify_174:
    if $P924, if_922
.annotate 'line', 581
    find_lex $P939, "$obj"
    find_lex $P940, "$name"
    $P941 = "_dumper"($P939, $P940)
.annotate 'line', 580
    set $P921, $P941
.annotate 'line', 575
    goto if_922_end
  if_922:
    .const 'Sub' $P926 = "66_1299602521.155" 
    capture_lex $P926
    $P938 = $P926()
    set $P921, $P938
  if_922_end:
.annotate 'line', 574
    .return ($P921)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block925"  :anon :subid("66_1299602521.155") :outer("65_1299602521.155")
.annotate 'line', 577
    new $P927, "Undef"
    .lex "$dumper", $P927
.annotate 'line', 576
    load_bytecode "PCT/Dumper.pbc"
.annotate 'line', 577
    find_lex $P928, "%options"
    unless_null $P928, vivify_175
    $P928 = root_new ['parrot';'Hash']
  vivify_175:
    set $P929, $P928["dumper"]
    unless_null $P929, vivify_176
    new $P929, "Undef"
  vivify_176:
    set $S930, $P929
    downcase $S931, $S930
    get_hll_global $P932, ["PCT"], "Dumper"
    unless_null $P932, vivify_177
    $P932 = root_new ['parrot';'Hash']
  vivify_177:
    set $P933, $P932[$S931]
    unless_null $P933, vivify_178
    new $P933, "Undef"
  vivify_178:
    store_lex "$dumper", $P933
.annotate 'line', 578
    find_lex $P934, "$dumper"
    find_lex $P935, "$obj"
    find_lex $P936, "$name"
    $P937 = $P934($P935, $P936)
.annotate 'line', 575
    .return ($P937)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "usage"  :subid("67_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_943
    .param pmc param_944 :optional
    .param int has_param_944 :opt_flag
.annotate 'line', 585
    .lex "self", param_943
    if has_param_944, optparam_179
    new $P945, "Undef"
    set param_944, $P945
  optparam_179:
    .lex "$name", param_944
.annotate 'line', 586
    find_lex $P947, "$name"
    unless $P947, if_946_end
.annotate 'line', 587
    find_lex $P948, "$name"
    "say"($P948)
  if_946_end:
.annotate 'line', 589
    find_lex $P949, "self"
    get_global $P950, "$?CLASS"
    getattribute $P951, $P949, $P950, "$!usage"
    unless_null $P951, vivify_180
    new $P951, "Undef"
  vivify_180:
    say $P951
.annotate 'line', 590
    exit 0
.annotate 'line', 585
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "version"  :subid("68_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_953
.annotate 'line', 593
    .lex "self", param_953
.annotate 'line', 594
    find_lex $P954, "self"
    get_global $P955, "$?CLASS"
    getattribute $P956, $P954, $P955, "$!version"
    unless_null $P956, vivify_181
    new $P956, "Undef"
  vivify_181:
    say $P956
.annotate 'line', 595
    exit 0
.annotate 'line', 593
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "removestage"  :subid("69_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_958
    .param pmc param_959
.annotate 'line', 598
    .const 'Sub' $P969 = "70_1299602521.155" 
    capture_lex $P969
    .lex "self", param_958
    .lex "$stagename", param_959
.annotate 'line', 599
    $P960 = root_new ['parrot';'ResizablePMCArray']
    .lex "@new_stages", $P960
    new $P961, "ResizableStringArray"
    store_lex "@new_stages", $P961
.annotate 'line', 600
    find_lex $P963, "self"
    get_global $P964, "$?CLASS"
    getattribute $P965, $P963, $P964, "@!stages"
    unless_null $P965, vivify_182
    $P965 = root_new ['parrot';'ResizablePMCArray']
  vivify_182:
    defined $I966, $P965
    unless $I966, for_undef_183
    iter $P962, $P965
    new $P982, 'ExceptionHandler'
    set_label $P982, loop981_handler
    $P982."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P982
  loop981_test:
    unless $P962, loop981_done
    shift $P967, $P962
  loop981_redo:
    .const 'Sub' $P969 = "70_1299602521.155" 
    capture_lex $P969
    $P969($P967)
  loop981_next:
    goto loop981_test
  loop981_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P983, exception, 'type'
    eq $P983, .CONTROL_LOOP_NEXT, loop981_next
    eq $P983, .CONTROL_LOOP_REDO, loop981_redo
  loop981_done:
    pop_eh 
  for_undef_183:
.annotate 'line', 605
    find_lex $P984, "@new_stages"
    find_lex $P985, "self"
    get_global $P986, "$?CLASS"
    setattribute $P985, $P986, "@!stages", $P984
.annotate 'line', 598
    .return ($P984)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block968"  :anon :subid("70_1299602521.155") :outer("69_1299602521.155")
    .param pmc param_970
.annotate 'line', 600
    .lex "$_", param_970
.annotate 'line', 601
    find_lex $P973, "$_"
    set $S974, $P973
    find_lex $P975, "$stagename"
    set $S976, $P975
    isne $I977, $S974, $S976
    if $I977, if_972
    new $P971, 'Integer'
    set $P971, $I977
    goto if_972_end
  if_972:
.annotate 'line', 602
    find_lex $P978, "@new_stages"
    find_lex $P979, "$_"
    $P980 = $P978."push"($P979)
.annotate 'line', 601
    set $P971, $P980
  if_972_end:
.annotate 'line', 600
    .return ($P971)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "addstage"  :subid("71_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_990
    .param pmc param_991
    .param pmc param_992 :slurpy :named
.annotate 'line', 608
    .const 'Sub' $P1029 = "73_1299602521.155" 
    capture_lex $P1029
    .const 'Sub' $P1011 = "72_1299602521.155" 
    capture_lex $P1011
    new $P989, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P989, control_988
    push_eh $P989
    .lex "self", param_990
    .lex "$stagename", param_991
    .lex "%adverbs", param_992
.annotate 'line', 609
    new $P993, "Undef"
    .lex "$position", $P993
.annotate 'line', 610
    new $P994, "Undef"
    .lex "$where", $P994
.annotate 'line', 623
    $P995 = root_new ['parrot';'ResizablePMCArray']
    .lex "@new-stages", $P995
.annotate 'line', 608
    find_lex $P996, "$position"
    find_lex $P997, "$where"
.annotate 'line', 611
    find_lex $P999, "%adverbs"
    unless_null $P999, vivify_184
    $P999 = root_new ['parrot';'Hash']
  vivify_184:
    set $P1000, $P999["before"]
    unless_null $P1000, vivify_185
    new $P1000, "Undef"
  vivify_185:
    if $P1000, if_998
.annotate 'line', 614
    find_lex $P1005, "%adverbs"
    unless_null $P1005, vivify_186
    $P1005 = root_new ['parrot';'Hash']
  vivify_186:
    set $P1006, $P1005["after"]
    unless_null $P1006, vivify_187
    new $P1006, "Undef"
  vivify_187:
    if $P1006, if_1004
.annotate 'line', 617
    .const 'Sub' $P1011 = "72_1299602521.155" 
    capture_lex $P1011
    $P1011()
    goto if_1004_end
  if_1004:
.annotate 'line', 615
    find_lex $P1007, "%adverbs"
    unless_null $P1007, vivify_188
    $P1007 = root_new ['parrot';'Hash']
  vivify_188:
    set $P1008, $P1007["after"]
    unless_null $P1008, vivify_189
    new $P1008, "Undef"
  vivify_189:
    store_lex "$where", $P1008
.annotate 'line', 616
    new $P1009, "String"
    assign $P1009, "after"
    store_lex "$position", $P1009
  if_1004_end:
.annotate 'line', 614
    goto if_998_end
  if_998:
.annotate 'line', 612
    find_lex $P1001, "%adverbs"
    unless_null $P1001, vivify_190
    $P1001 = root_new ['parrot';'Hash']
  vivify_190:
    set $P1002, $P1001["before"]
    unless_null $P1002, vivify_191
    new $P1002, "Undef"
  vivify_191:
    store_lex "$where", $P1002
.annotate 'line', 613
    new $P1003, "String"
    assign $P1003, "before"
    store_lex "$position", $P1003
  if_998_end:
.annotate 'line', 623
    new $P1022, "ResizableStringArray"
    store_lex "@new-stages", $P1022
.annotate 'line', 624
    find_lex $P1024, "self"
    $P1025 = $P1024."stages"()
    defined $I1026, $P1025
    unless $I1026, for_undef_192
    iter $P1023, $P1025
    new $P1054, 'ExceptionHandler'
    set_label $P1054, loop1053_handler
    $P1054."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P1054
  loop1053_test:
    unless $P1023, loop1053_done
    shift $P1027, $P1023
  loop1053_redo:
    .const 'Sub' $P1029 = "73_1299602521.155" 
    capture_lex $P1029
    $P1029($P1027)
  loop1053_next:
    goto loop1053_test
  loop1053_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P1055, exception, 'type'
    eq $P1055, .CONTROL_LOOP_NEXT, loop1053_next
    eq $P1055, .CONTROL_LOOP_REDO, loop1053_redo
  loop1053_done:
    pop_eh 
  for_undef_192:
.annotate 'line', 637
    find_lex $P1056, "self"
    find_lex $P1057, "@new-stages"
    $P1058 = $P1056."stages"($P1057)
.annotate 'line', 608
    .return ($P1058)
  control_988:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P1059, exception, "payload"
    .return ($P1059)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "_block1010"  :anon :subid("72_1299602521.155") :outer("71_1299602521.155")
.annotate 'line', 618
    $P1012 = root_new ['parrot';'ResizablePMCArray']
    .lex "@new-stages", $P1012
    find_lex $P1013, "self"
    $P1014 = $P1013."stages"()
    clone $P1015, $P1014
    store_lex "@new-stages", $P1015
.annotate 'line', 619
    find_lex $P1016, "@new-stages"
    find_lex $P1017, "$stagename"
    push $P1016, $P1017
.annotate 'line', 620
    find_lex $P1018, "self"
    find_lex $P1019, "@new-stages"
    $P1018."stages"($P1019)
.annotate 'line', 621
    new $P1020, "Exception"
    set $P1020['type'], .CONTROL_RETURN
    new $P1021, "Integer"
    assign $P1021, 1
    setattribute $P1020, 'payload', $P1021
    throw $P1020
.annotate 'line', 617
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block1028"  :anon :subid("73_1299602521.155") :outer("71_1299602521.155")
    .param pmc param_1030
.annotate 'line', 624
    .lex "$_", param_1030
.annotate 'line', 625
    find_lex $P1033, "$_"
    set $S1034, $P1033
    find_lex $P1035, "$where"
    set $S1036, $P1035
    iseq $I1037, $S1034, $S1036
    if $I1037, if_1032
.annotate 'line', 634
    find_lex $P1051, "@new-stages"
    find_lex $P1052, "$_"
    push $P1051, $P1052
.annotate 'line', 633
    set $P1031, $P1051
.annotate 'line', 625
    goto if_1032_end
  if_1032:
.annotate 'line', 626
    find_lex $P1040, "$position"
    set $S1041, $P1040
    iseq $I1042, $S1041, "before"
    if $I1042, if_1039
.annotate 'line', 630
    find_lex $P1047, "@new-stages"
    find_lex $P1048, "$_"
    push $P1047, $P1048
.annotate 'line', 631
    find_lex $P1049, "@new-stages"
    find_lex $P1050, "$stagename"
    push $P1049, $P1050
.annotate 'line', 629
    set $P1038, $P1049
.annotate 'line', 626
    goto if_1039_end
  if_1039:
.annotate 'line', 627
    find_lex $P1043, "@new-stages"
    find_lex $P1044, "$stagename"
    push $P1043, $P1044
.annotate 'line', 628
    find_lex $P1045, "@new-stages"
    find_lex $P1046, "$_"
    push $P1045, $P1046
.annotate 'line', 626
    set $P1038, $P1045
  if_1039_end:
.annotate 'line', 625
    set $P1031, $P1038
  if_1032_end:
.annotate 'line', 624
    .return ($P1031)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.include "except_types.pasm"
.sub "parse_name"  :subid("74_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_1061
    .param pmc param_1062
.annotate 'line', 640
    .const 'Sub' $P1100 = "75_1299602521.155" 
    capture_lex $P1100
    .lex "self", param_1061
    .lex "$name", param_1062
.annotate 'line', 641
    $P1063 = root_new ['parrot';'ResizablePMCArray']
    .lex "@ns", $P1063
.annotate 'line', 642
    new $P1064, "Undef"
    .lex "$sigil", $P1064
.annotate 'line', 645
    new $P1065, "Undef"
    .lex "$idx", $P1065
.annotate 'line', 653
    $P1066 = root_new ['parrot';'ResizablePMCArray']
    .lex "@actual_ns", $P1066
.annotate 'line', 641
    find_lex $P1067, "$name"
    set $S1068, $P1067
    split $P1069, "::", $S1068
    store_lex "@ns", $P1069
.annotate 'line', 642
    find_lex $P1070, "@ns"
    unless_null $P1070, vivify_193
    $P1070 = root_new ['parrot';'ResizablePMCArray']
  vivify_193:
    set $P1071, $P1070[0]
    unless_null $P1071, vivify_194
    new $P1071, "Undef"
  vivify_194:
    set $S1072, $P1071
    substr $S1073, $S1072, 0, 1
    new $P1074, 'String'
    set $P1074, $S1073
    store_lex "$sigil", $P1074
.annotate 'line', 645
    find_lex $P1075, "$sigil"
    set $S1076, $P1075
    index $I1077, "$@%&", $S1076
    new $P1078, 'Integer'
    set $P1078, $I1077
    store_lex "$idx", $P1078
.annotate 'line', 646
    find_lex $P1080, "$idx"
    set $N1081, $P1080
    isge $I1082, $N1081, 0.0
    unless $I1082, if_1079_end
.annotate 'line', 647
    find_lex $P1083, "@ns"
    unless_null $P1083, vivify_195
    $P1083 = root_new ['parrot';'ResizablePMCArray']
  vivify_195:
    set $P1084, $P1083[0]
    unless_null $P1084, vivify_196
    new $P1084, "Undef"
  vivify_196:
    set $S1085, $P1084
    substr $S1086, $S1085, 1
    new $P1087, 'String'
    set $P1087, $S1086
    find_lex $P1088, "@ns"
    unless_null $P1088, vivify_197
    $P1088 = root_new ['parrot';'ResizablePMCArray']
    store_lex "@ns", $P1088
  vivify_197:
    set $P1088[0], $P1087
.annotate 'line', 648
    find_lex $P1089, "$sigil"
    find_lex $P1090, "@ns"
    unless_null $P1090, vivify_198
    $P1090 = root_new ['parrot';'ResizablePMCArray']
  vivify_198:
    set $P1091, $P1090[-1]
    unless_null $P1091, vivify_199
    new $P1091, "Undef"
  vivify_199:
    concat $P1092, $P1089, $P1091
    find_lex $P1093, "@ns"
    unless_null $P1093, vivify_200
    $P1093 = root_new ['parrot';'ResizablePMCArray']
    store_lex "@ns", $P1093
  vivify_200:
    set $P1093[-1], $P1092
  if_1079_end:
.annotate 'line', 646
    find_lex $P1094, "@actual_ns"
.annotate 'line', 654
    find_lex $P1096, "@ns"
    defined $I1097, $P1096
    unless $I1097, for_undef_201
    iter $P1095, $P1096
    new $P1110, 'ExceptionHandler'
    set_label $P1110, loop1109_handler
    $P1110."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P1110
  loop1109_test:
    unless $P1095, loop1109_done
    shift $P1098, $P1095
  loop1109_redo:
    .const 'Sub' $P1100 = "75_1299602521.155" 
    capture_lex $P1100
    $P1100($P1098)
  loop1109_next:
    goto loop1109_test
  loop1109_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P1111, exception, 'type'
    eq $P1111, .CONTROL_LOOP_NEXT, loop1109_next
    eq $P1111, .CONTROL_LOOP_REDO, loop1109_redo
  loop1109_done:
    pop_eh 
  for_undef_201:
    find_lex $P1112, "@actual_ns"
.annotate 'line', 640
    .return ($P1112)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "_block1099"  :anon :subid("75_1299602521.155") :outer("74_1299602521.155")
    .param pmc param_1101
.annotate 'line', 654
    .lex "$_", param_1101
.annotate 'line', 655
    find_lex $P1104, "$_"
    set $S1105, $P1104
    iseq $I1106, $S1105, ""
    unless $I1106, unless_1103
    new $P1102, 'Integer'
    set $P1102, $I1106
    goto unless_1103_end
  unless_1103:
    find_lex $P1107, "@actual_ns"
    find_lex $P1108, "$_"
    push $P1107, $P1108
    set $P1102, $P1107
  unless_1103_end:
.annotate 'line', 654
    .return ($P1102)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler"]
.sub "lineof"  :subid("76_1299602521.155") :outer("12_1299602521.155")
    .param pmc param_1114
    .param pmc param_1115
    .param pmc param_1116
    .param pmc param_1117 :optional :named("cache")
    .param int has_param_1117 :opt_flag
.annotate 'line', 660
    .lex "self", param_1114
    .lex "$target", param_1115
    .lex "$pos", param_1116
    if has_param_1117, optparam_202
    new $P1118, "Undef"
    set param_1117, $P1118
  optparam_202:
    .lex "$cache", param_1117
.annotate 'line', 661

            .local pmc target, linepos
            .local int pos, cache
            target = find_lex '$target'
            $P0 = find_lex '$pos'
            pos = $P0
            $P0 = find_lex '$cache'
            cache = $P0

            .include 'cclass.pasm'

            # If we've previously cached C<linepos> for target, we use it.
            unless cache goto linepos_build
            linepos = getprop '!linepos', target
            unless null linepos goto linepos_done

            # calculate a new linepos array.
          linepos_build:
            linepos = new ['ResizableIntegerArray']
            unless cache goto linepos_build_1
            setprop target, '!linepos', linepos
          linepos_build_1:
            .local string s
            .local int jpos, eos
            s = target
            eos = length s
            jpos = 0
            # Search for all of the newline markers in C<target>.  When we
            # find one, mark the ending offset of the line in C<linepos>.
          linepos_loop:
            jpos = find_cclass .CCLASS_NEWLINE, s, jpos, eos
            unless jpos < eos goto linepos_done
            $I0 = ord s, jpos
            inc jpos
            push linepos, jpos
            # Treat \r\n as a single logical newline.
            if $I0 != 13 goto linepos_loop
            $I0 = ord s, jpos
            if $I0 != 10 goto linepos_loop
            inc jpos
            goto linepos_loop
          linepos_done:

            # We have C<linepos>, so now we search the array for the largest
            # element that is not greater than C<pos>.  The index of that
            # element is the line number to be returned.
            # (Potential optimization: use a binary search.)
            .local int line, count
            count = elements linepos
            line = 0
          line_loop:
            if line >= count goto line_done
            $I0 = linepos[line]
            if $I0 > pos goto line_done
            inc line
            goto line_loop
          line_done:
            .return (line)
        
.annotate 'line', 660
    .return ()
.end


.HLL "nqp"

.namespace []
.sub "_block1231" :load :anon :subid("78_1299602521.155")
.annotate 'line', 1
    .const 'Sub' $P1233 = "10_1299602521.155" 
    $P1234 = $P1233()
    .return ($P1234)
.end

### .include 'gen/hllcommandline.pir'

.HLL "nqp"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.namespace []
.sub "_block11"  :anon :subid("10_1299602522.66")
.annotate 'line', 0
    get_hll_global $P117, ["HLL";"CommandLine";"Parser"], "_block116" 
    capture_lex $P117
    get_hll_global $P19, ["HLL";"CommandLine";"Result"], "_block18" 
    capture_lex $P19
.annotate 'line', 1
    getinterp $P13
    get_class $P14, "LexPad"
    get_class $P15, "NQPLexPad"
    $P13."hll_map"($P14, $P15)
    get_hll_global $P16, ["HLL";"CommandLine"], "Parser"
    get_hll_global $P17, ["HLL";"CommandLine"], "Result"
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
.annotate 'line', 91
    get_hll_global $P19, ["HLL";"CommandLine";"Result"], "_block18" 
    capture_lex $P19
    $P19()
.annotate 'line', 124
    get_hll_global $P117, ["HLL";"CommandLine";"Parser"], "_block116" 
    capture_lex $P117
    $P575 = $P117()
.annotate 'line', 1
    .return ($P575)
    .const 'Sub' $P577 = "39_1299602522.66" 
    .return ($P577)
.end


.HLL "nqp"

.namespace []
.sub "" :load :init :subid("post40") :outer("10_1299602522.66")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1299602522.66" 
    .local pmc block
    set block, $P12
    nqp_get_sc $P581, "1299602521.877"
    isnull $I582, $P581
    if $I582, if_580
    goto if_580_end
  if_580:
    nqp_dynop_setup 
    load_bytecode "nqpmo.pbc"
    nqp_create_sc $P583, "1299602521.877"
    .local pmc cur_sc
    set cur_sc, $P583
    load_bytecode "SettingManager.pbc"
    get_hll_global $P584, ["HLL"], "SettingManager"
    $P585 = $P584."load_setting"("NQPCORE")
    block."set_outer_ctx"($P585)
    get_hll_global $P586, "NQPClassHOW"
    $P587 = $P586."new_type"("HLL::CommandLine::Result" :named("name"))
    nqp_set_sc_for_object $P587, cur_sc
    nqp_set_sc_object "1299602521.877", 0, $P587
    get_hll_global $P588, "NQPClassHOW"
    $P589 = $P588."new_type"("HLL::CommandLine::Parser" :named("name"))
    nqp_set_sc_for_object $P589, cur_sc
    nqp_set_sc_object "1299602521.877", 1, $P589
  if_580_end:
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "_block18"  :subid("11_1299602522.66") :outer("10_1299602522.66")
.annotate 'line', 91
    .const 'Sub' $P96 = "18_1299602522.66" 
    capture_lex $P96
    .const 'Sub' $P46 = "16_1299602522.66" 
    capture_lex $P46
    .const 'Sub' $P39 = "15_1299602522.66" 
    capture_lex $P39
    .const 'Sub' $P34 = "14_1299602522.66" 
    capture_lex $P34
    .const 'Sub' $P29 = "13_1299602522.66" 
    capture_lex $P29
    .const 'Sub' $P21 = "12_1299602522.66" 
    capture_lex $P21
    get_global $P20, "$?CLASS"
.annotate 'line', 107
    .const 'Sub' $P46 = "16_1299602522.66" 
    newclosure $P94, $P46
.annotate 'line', 91
    .return ($P94)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "" :load :init :subid("post41") :outer("11_1299602522.66")
.annotate 'line', 91
    get_hll_global $P19, ["HLL";"CommandLine";"Result"], "_block18" 
    .local pmc block
    set block, $P19
    .const 'Sub' $P96 = "18_1299602522.66" 
    capture_lex $P96
    $P96()
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "_block95"  :anon :subid("18_1299602522.66") :outer("11_1299602522.66")
.annotate 'line', 91
    nqp_get_sc_object $P97, "1299602521.877", 0
    .local pmc type_obj
    set type_obj, $P97
    set_hll_global ["HLL";"CommandLine"], "Result", type_obj
    set_global "$?CLASS", type_obj
    get_how $P98, type_obj
    get_hll_global $P99, "NQPAttribute"
    $P100 = $P99."new"("@!arguments" :named("name"))
    $P98."add_attribute"(type_obj, $P100)
    get_how $P101, type_obj
    get_hll_global $P102, "NQPAttribute"
    $P103 = $P102."new"("%!options" :named("name"))
    $P101."add_attribute"(type_obj, $P103)
    get_how $P104, type_obj
    .const 'Sub' $P105 = "12_1299602522.66" 
    $P104."add_method"(type_obj, "init", $P105)
    get_how $P106, type_obj
    .const 'Sub' $P107 = "13_1299602522.66" 
    $P106."add_method"(type_obj, "arguments", $P107)
    get_how $P108, type_obj
    .const 'Sub' $P109 = "14_1299602522.66" 
    $P108."add_method"(type_obj, "options", $P109)
    get_how $P110, type_obj
    .const 'Sub' $P111 = "15_1299602522.66" 
    $P110."add_method"(type_obj, "add-argument", $P111)
    get_how $P112, type_obj
    .const 'Sub' $P113 = "16_1299602522.66" 
    $P112."add_method"(type_obj, "add-option", $P113)
    get_how $P114, type_obj
    $P115 = $P114."compose"(type_obj)
    .return ($P115)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "init"  :subid("12_1299602522.66") :outer("11_1299602522.66")
    .param pmc param_22
.annotate 'line', 95
    .lex "self", param_22
.annotate 'line', 96
    new $P23, "ResizablePMCArray"
    find_lex $P24, "self"
    get_global $P25, "$?CLASS"
    setattribute $P24, $P25, "@!arguments", $P23
.annotate 'line', 97
    new $P26, "Hash"
    find_lex $P27, "self"
    get_global $P28, "$?CLASS"
    setattribute $P27, $P28, "%!options", $P26
.annotate 'line', 95
    .return ($P26)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "arguments"  :subid("13_1299602522.66") :outer("11_1299602522.66")
    .param pmc param_30
.annotate 'line', 100
    .lex "self", param_30
    find_lex $P31, "self"
    get_global $P32, "$?CLASS"
    getattribute $P33, $P31, $P32, "@!arguments"
    unless_null $P33, vivify_42
    $P33 = root_new ['parrot';'ResizablePMCArray']
  vivify_42:
    .return ($P33)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "options"  :subid("14_1299602522.66") :outer("11_1299602522.66")
    .param pmc param_35
.annotate 'line', 101
    .lex "self", param_35
    find_lex $P36, "self"
    get_global $P37, "$?CLASS"
    getattribute $P38, $P36, $P37, "%!options"
    unless_null $P38, vivify_43
    $P38 = root_new ['parrot';'Hash']
  vivify_43:
    .return ($P38)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "add-argument"  :subid("15_1299602522.66") :outer("11_1299602522.66")
    .param pmc param_40
    .param pmc param_41
.annotate 'line', 103
    .lex "self", param_40
    .lex "$x", param_41
.annotate 'line', 104
    find_lex $P42, "self"
    get_global $P43, "$?CLASS"
    getattribute $P44, $P42, $P43, "@!arguments"
    unless_null $P44, vivify_44
    $P44 = root_new ['parrot';'ResizablePMCArray']
  vivify_44:
    find_lex $P45, "$x"
    push $P44, $P45
.annotate 'line', 103
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "add-option"  :subid("16_1299602522.66") :outer("11_1299602522.66")
    .param pmc param_47
    .param pmc param_48
    .param pmc param_49
.annotate 'line', 107
    .const 'Sub' $P58 = "17_1299602522.66" 
    capture_lex $P58
    .lex "self", param_47
    .lex "$name", param_48
    .lex "$value", param_49
.annotate 'line', 110
    find_lex $P55, "$name"
    find_lex $P52, "self"
    get_global $P53, "$?CLASS"
    getattribute $P54, $P52, $P53, "%!options"
    unless_null $P54, vivify_45
    $P54 = root_new ['parrot';'Hash']
  vivify_45:
    exists $I56, $P54[$P55]
    if $I56, if_51
.annotate 'line', 119
    find_lex $P89, "$value"
    find_lex $P90, "$name"
    find_lex $P91, "self"
    get_global $P92, "$?CLASS"
    getattribute $P93, $P91, $P92, "%!options"
    unless_null $P93, vivify_46
    $P93 = root_new ['parrot';'Hash']
    setattribute $P91, $P92, "%!options", $P93
  vivify_46:
    set $P93[$P90], $P89
.annotate 'line', 118
    set $P50, $P89
.annotate 'line', 110
    goto if_51_end
  if_51:
    .const 'Sub' $P58 = "17_1299602522.66" 
    capture_lex $P58
    $P88 = $P58()
    set $P50, $P88
  if_51_end:
.annotate 'line', 107
    .return ($P50)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Result"]
.sub "_block57"  :anon :subid("17_1299602522.66") :outer("16_1299602522.66")
.annotate 'line', 111
    new $P59, "Undef"
    .lex "$t", $P59
    find_lex $P60, "self"
    get_global $P61, "$?CLASS"
    getattribute $P62, $P60, $P61, "%!options"
    unless_null $P62, vivify_47
    $P62 = root_new ['parrot';'Hash']
  vivify_47:
    typeof $S63, $P62
    new $P64, 'String'
    set $P64, $S63
    store_lex "$t", $P64
.annotate 'line', 112
    find_lex $P65, "$t"
    "say"($P65)
.annotate 'line', 113
    find_lex $P68, "$t"
    set $S69, $P68
    iseq $I70, $S69, "ResizablePMCArray"
    if $I70, if_67
.annotate 'line', 116
    find_lex $P77, "$name"
    find_lex $P78, "self"
    get_global $P79, "$?CLASS"
    getattribute $P80, $P78, $P79, "%!options"
    unless_null $P80, vivify_48
    $P80 = root_new ['parrot';'Hash']
  vivify_48:
    set $P81, $P80[$P77]
    unless_null $P81, vivify_49
    new $P81, "Undef"
  vivify_49:
    find_lex $P82, "$name"
    new $P83, "ResizablePMCArray"
    push $P83, $P81
    push $P83, $P82
    find_lex $P84, "$name"
    find_lex $P85, "self"
    get_global $P86, "$?CLASS"
    getattribute $P87, $P85, $P86, "%!options"
    unless_null $P87, vivify_50
    $P87 = root_new ['parrot';'Hash']
    setattribute $P85, $P86, "%!options", $P87
  vivify_50:
    set $P87[$P84], $P83
.annotate 'line', 115
    set $P66, $P83
.annotate 'line', 113
    goto if_67_end
  if_67:
.annotate 'line', 114
    find_lex $P71, "$name"
    find_lex $P72, "self"
    get_global $P73, "$?CLASS"
    getattribute $P74, $P72, $P73, "%!options"
    unless_null $P74, vivify_51
    $P74 = root_new ['parrot';'Hash']
  vivify_51:
    set $P75, $P74[$P71]
    unless_null $P75, vivify_52
    new $P75, "Undef"
  vivify_52:
    find_lex $P76, "$value"
    push $P75, $P76
.annotate 'line', 113
    set $P66, $P75
  if_67_end:
.annotate 'line', 110
    .return ($P66)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block116"  :subid("19_1299602522.66") :outer("10_1299602522.66")
.annotate 'line', 124
    .const 'Sub' $P541 = "38_1299602522.66" 
    capture_lex $P541
    .const 'Sub' $P256 = "30_1299602522.66" 
    capture_lex $P256
    .const 'Sub' $P244 = "29_1299602522.66" 
    capture_lex $P244
    .const 'Sub' $P220 = "28_1299602522.66" 
    capture_lex $P220
    .const 'Sub' $P171 = "26_1299602522.66" 
    capture_lex $P171
    .const 'Sub' $P165 = "25_1299602522.66" 
    capture_lex $P165
    .const 'Sub' $P157 = "24_1299602522.66" 
    capture_lex $P157
    .const 'Sub' $P133 = "22_1299602522.66" 
    capture_lex $P133
    .const 'Sub' $P128 = "21_1299602522.66" 
    capture_lex $P128
    .const 'Sub' $P119 = "20_1299602522.66" 
    capture_lex $P119
    get_global $P118, "$?CLASS"
.annotate 'line', 184
    .const 'Sub' $P256 = "30_1299602522.66" 
    newclosure $P539, $P256
.annotate 'line', 124
    .return ($P539)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "" :load :init :subid("post53") :outer("19_1299602522.66")
.annotate 'line', 124
    get_hll_global $P117, ["HLL";"CommandLine";"Parser"], "_block116" 
    .local pmc block
    set block, $P117
    .const 'Sub' $P541 = "38_1299602522.66" 
    capture_lex $P541
    $P541()
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block540"  :anon :subid("38_1299602522.66") :outer("19_1299602522.66")
.annotate 'line', 124
    nqp_get_sc_object $P542, "1299602521.877", 1
    .local pmc type_obj
    set type_obj, $P542
    set_hll_global ["HLL";"CommandLine"], "Parser", type_obj
    set_global "$?CLASS", type_obj
    get_how $P543, type_obj
    get_hll_global $P544, "NQPAttribute"
    $P545 = $P544."new"("@!specs" :named("name"))
    $P543."add_attribute"(type_obj, $P545)
    get_how $P546, type_obj
    get_hll_global $P547, "NQPAttribute"
    $P548 = $P547."new"("%!options" :named("name"))
    $P546."add_attribute"(type_obj, $P548)
    get_how $P549, type_obj
    get_hll_global $P550, "NQPAttribute"
    $P551 = $P550."new"("%!stopper" :named("name"))
    $P549."add_attribute"(type_obj, $P551)
    get_how $P552, type_obj
    get_hll_global $P553, "NQPAttribute"
    $P554 = $P553."new"("$!stop-after-first-arg" :named("name"))
    $P552."add_attribute"(type_obj, $P554)
    get_how $P555, type_obj
    .const 'Sub' $P556 = "20_1299602522.66" 
    $P555."add_method"(type_obj, "new", $P556)
    get_how $P557, type_obj
    .const 'Sub' $P558 = "21_1299602522.66" 
    $P557."add_method"(type_obj, "stop-after-first-arg", $P558)
    get_how $P559, type_obj
    .const 'Sub' $P560 = "22_1299602522.66" 
    $P559."add_method"(type_obj, "BUILD", $P560)
    get_how $P561, type_obj
    .const 'Sub' $P562 = "24_1299602522.66" 
    $P561."add_method"(type_obj, "add-stopper", $P562)
    get_how $P563, type_obj
    .const 'Sub' $P564 = "25_1299602522.66" 
    $P563."add_method"(type_obj, "split-option-aliases", $P564)
    get_how $P565, type_obj
    .const 'Sub' $P566 = "26_1299602522.66" 
    $P565."add_method"(type_obj, "add-spec", $P566)
    get_how $P567, type_obj
    .const 'Sub' $P568 = "28_1299602522.66" 
    $P567."add_method"(type_obj, "is-option", $P568)
    get_how $P569, type_obj
    .const 'Sub' $P570 = "29_1299602522.66" 
    $P569."add_method"(type_obj, "wants-value", $P570)
    get_how $P571, type_obj
    .const 'Sub' $P572 = "30_1299602522.66" 
    $P571."add_method"(type_obj, "parse", $P572)
    get_how $P573, type_obj
    $P574 = $P573."compose"(type_obj)
    .return ($P574)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "new"  :subid("20_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_120
    .param pmc param_121
.annotate 'line', 130
    .lex "self", param_120
    .lex "@specs", param_121
.annotate 'line', 131
    new $P122, "Undef"
    .lex "$obj", $P122
    find_lex $P123, "self"
    $P124 = $P123."CREATE"()
    store_lex "$obj", $P124
.annotate 'line', 132
    find_lex $P125, "$obj"
    find_lex $P126, "@specs"
    $P125."BUILD"($P126 :named("specs"))
    find_lex $P127, "$obj"
.annotate 'line', 130
    .return ($P127)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "stop-after-first-arg"  :subid("21_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_129
.annotate 'line', 136
    .lex "self", param_129
.annotate 'line', 137
    new $P130, "Integer"
    assign $P130, 1
    find_lex $P131, "self"
    get_global $P132, "$?CLASS"
    setattribute $P131, $P132, "$!stop-after-first-arg", $P130
.annotate 'line', 136
    .return ($P130)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.include "except_types.pasm"
.sub "BUILD"  :subid("22_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_134
    .param pmc param_135 :optional :named("specs")
    .param int has_param_135 :opt_flag
.annotate 'line', 140
    .const 'Sub' $P149 = "23_1299602522.66" 
    capture_lex $P149
    .lex "self", param_134
    if has_param_135, optparam_54
    $P136 = root_new ['parrot';'ResizablePMCArray']
    set param_135, $P136
  optparam_54:
    .lex "@specs", param_135
.annotate 'line', 141
    new $P137, "Integer"
    assign $P137, 1
    find_lex $P138, "self"
    get_global $P139, "$?CLASS"
    getattribute $P140, $P138, $P139, "%!stopper"
    unless_null $P140, vivify_55
    $P140 = root_new ['parrot';'Hash']
    setattribute $P138, $P139, "%!stopper", $P140
  vivify_55:
    set $P140["--"], $P137
.annotate 'line', 142
    new $P141, "Integer"
    assign $P141, 0
    find_lex $P142, "self"
    get_global $P143, "$?CLASS"
    setattribute $P142, $P143, "$!stop-after-first-arg", $P141
.annotate 'line', 143
    find_lex $P145, "@specs"
    defined $I146, $P145
    unless $I146, for_undef_56
    iter $P144, $P145
    new $P155, 'ExceptionHandler'
    set_label $P155, loop154_handler
    $P155."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P155
  loop154_test:
    unless $P144, loop154_done
    shift $P147, $P144
  loop154_redo:
    .const 'Sub' $P149 = "23_1299602522.66" 
    capture_lex $P149
    $P149($P147)
  loop154_next:
    goto loop154_test
  loop154_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P156, exception, 'type'
    eq $P156, .CONTROL_LOOP_NEXT, loop154_next
    eq $P156, .CONTROL_LOOP_REDO, loop154_redo
  loop154_done:
    pop_eh 
  for_undef_56:
.annotate 'line', 140
    .return ($P144)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block148"  :anon :subid("23_1299602522.66") :outer("22_1299602522.66")
    .param pmc param_150
.annotate 'line', 143
    .lex "$_", param_150
.annotate 'line', 144
    find_lex $P151, "self"
    find_lex $P152, "$_"
    $P153 = $P151."add-spec"($P152)
.annotate 'line', 143
    .return ($P153)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "add-stopper"  :subid("24_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_158
    .param pmc param_159
.annotate 'line', 147
    .lex "self", param_158
    .lex "$x", param_159
.annotate 'line', 148
    new $P160, "Integer"
    assign $P160, 1
    find_lex $P161, "$x"
    find_lex $P162, "self"
    get_global $P163, "$?CLASS"
    getattribute $P164, $P162, $P163, "%!stopper"
    unless_null $P164, vivify_57
    $P164 = root_new ['parrot';'Hash']
    setattribute $P162, $P163, "%!stopper", $P164
  vivify_57:
    set $P164[$P161], $P160
.annotate 'line', 147
    .return ($P160)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "split-option-aliases"  :subid("25_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_166
    .param pmc param_167
.annotate 'line', 151
    .lex "self", param_166
    .lex "$s", param_167
.annotate 'line', 152
    find_lex $P168, "$s"
    set $S169, $P168
    split $P170, "|", $S169
.annotate 'line', 151
    .return ($P170)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.include "except_types.pasm"
.sub "add-spec"  :subid("26_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_172
    .param pmc param_173
.annotate 'line', 156
    .const 'Sub' $P210 = "27_1299602522.66" 
    capture_lex $P210
    .lex "self", param_172
    .lex "$s", param_173
.annotate 'line', 157
    new $P174, "Undef"
    .lex "$i", $P174
.annotate 'line', 158
    new $P175, "Undef"
    .lex "$type", $P175
.annotate 'line', 159
    $P176 = root_new ['parrot';'ResizablePMCArray']
    .lex "@options", $P176
.annotate 'line', 157
    find_lex $P177, "$s"
    set $S178, $P177
    index $I179, $S178, "="
    new $P180, 'Integer'
    set $P180, $I179
    store_lex "$i", $P180
    find_lex $P181, "$type"
    find_lex $P182, "@options"
.annotate 'line', 160
    find_lex $P184, "$i"
    set $N185, $P184
    islt $I186, $N185, 0.0
    if $I186, if_183
.annotate 'line', 164
    find_lex $P191, "$s"
    set $S192, $P191
    find_lex $P193, "$i"
    add $P194, $P193, 1
    set $I195, $P194
    substr $S196, $S192, $I195
    new $P197, 'String'
    set $P197, $S196
    store_lex "$type", $P197
.annotate 'line', 165
    find_lex $P198, "self"
    find_lex $P199, "$s"
    set $S200, $P199
    find_lex $P201, "$i"
    set $I202, $P201
    substr $S203, $S200, 0, $I202
    $P204 = $P198."split-option-aliases"($S203)
    store_lex "@options", $P204
.annotate 'line', 163
    goto if_183_end
  if_183:
.annotate 'line', 161
    new $P187, "String"
    assign $P187, "b"
    store_lex "$type", $P187
.annotate 'line', 162
    find_lex $P188, "self"
    find_lex $P189, "$s"
    $P190 = $P188."split-option-aliases"($P189)
    store_lex "@options", $P190
  if_183_end:
.annotate 'line', 167
    find_lex $P206, "@options"
    defined $I207, $P206
    unless $I207, for_undef_58
    iter $P205, $P206
    new $P218, 'ExceptionHandler'
    set_label $P218, loop217_handler
    $P218."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P218
  loop217_test:
    unless $P205, loop217_done
    shift $P208, $P205
  loop217_redo:
    .const 'Sub' $P210 = "27_1299602522.66" 
    capture_lex $P210
    $P210($P208)
  loop217_next:
    goto loop217_test
  loop217_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P219, exception, 'type'
    eq $P219, .CONTROL_LOOP_NEXT, loop217_next
    eq $P219, .CONTROL_LOOP_REDO, loop217_redo
  loop217_done:
    pop_eh 
  for_undef_58:
.annotate 'line', 156
    .return ($P205)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block209"  :anon :subid("27_1299602522.66") :outer("26_1299602522.66")
    .param pmc param_211
.annotate 'line', 167
    .lex "$_", param_211
.annotate 'line', 168
    find_lex $P212, "$type"
    find_lex $P213, "$_"
    find_lex $P214, "self"
    get_global $P215, "$?CLASS"
    getattribute $P216, $P214, $P215, "%!options"
    unless_null $P216, vivify_59
    $P216 = root_new ['parrot';'Hash']
    setattribute $P214, $P215, "%!options", $P216
  vivify_59:
    set $P216[$P213], $P212
.annotate 'line', 167
    .return ($P212)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.include "except_types.pasm"
.sub "is-option"  :subid("28_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_223
    .param pmc param_224
.annotate 'line', 173
    new $P222, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P222, control_221
    push_eh $P222
    .lex "self", param_223
    .lex "$x", param_224
.annotate 'line', 174
    find_lex $P228, "$x"
    set $S229, $P228
    iseq $I230, $S229, "-"
    unless $I230, unless_227
    new $P226, 'Integer'
    set $P226, $I230
    goto unless_227_end
  unless_227:
    find_lex $P231, "$x"
    set $S232, $P231
    iseq $I233, $S232, "--"
    new $P226, 'Integer'
    set $P226, $I233
  unless_227_end:
    unless $P226, if_225_end
    new $P234, "Exception"
    set $P234['type'], .CONTROL_RETURN
    new $P235, "Integer"
    assign $P235, 0
    setattribute $P234, 'payload', $P235
    throw $P234
  if_225_end:
.annotate 'line', 175
    find_lex $P237, "$x"
    set $S238, $P237
    substr $S239, $S238, 0, 1
    iseq $I240, $S239, "-"
    unless $I240, if_236_end
    new $P241, "Exception"
    set $P241['type'], .CONTROL_RETURN
    new $P242, "Integer"
    assign $P242, 1
    setattribute $P241, 'payload', $P242
    throw $P241
  if_236_end:
.annotate 'line', 173
    .return (0)
  control_221:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P243, exception, "payload"
    .return ($P243)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "wants-value"  :subid("29_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_245
    .param pmc param_246
.annotate 'line', 179
    .lex "self", param_245
    .lex "$x", param_246
.annotate 'line', 180
    new $P247, "Undef"
    .lex "$spec", $P247
    find_lex $P248, "$x"
    find_lex $P249, "self"
    get_global $P250, "$?CLASS"
    getattribute $P251, $P249, $P250, "%!options"
    unless_null $P251, vivify_60
    $P251 = root_new ['parrot';'Hash']
  vivify_60:
    set $P252, $P251[$P248]
    unless_null $P252, vivify_61
    new $P252, "Undef"
  vivify_61:
    store_lex "$spec", $P252
.annotate 'line', 181
    find_lex $P253, "$spec"
    set $S254, $P253
    iseq $I255, $S254, "s"
.annotate 'line', 179
    .return ($I255)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.include "except_types.pasm"
.sub "parse"  :subid("30_1299602522.66") :outer("19_1299602522.66")
    .param pmc param_259
    .param pmc param_260
.annotate 'line', 184
    .const 'Sub' $P347 = "33_1299602522.66" 
    capture_lex $P347
    .const 'Sub' $P313 = "32_1299602522.66" 
    capture_lex $P313
    .const 'Sub' $P264 = "31_1299602522.66" 
    capture_lex $P264
    new $P258, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P258, control_257
    push_eh $P258
    .lex "self", param_259
    .lex "@args", param_260
.annotate 'line', 185
    new $P261, "Undef"
    .lex "$i", $P261
.annotate 'line', 186
    new $P262, "Undef"
    .lex "$arg-count", $P262
.annotate 'line', 188
    new $P263, "Undef"
    .lex "$result", $P263
.annotate 'line', 192
    .const 'Sub' $P264 = "31_1299602522.66" 
    newclosure $P312, $P264
    .lex "get-value", $P312
.annotate 'line', 207
    .const 'Sub' $P313 = "32_1299602522.66" 
    newclosure $P331, $P313
    .lex "slurp-rest", $P331
.annotate 'line', 185
    new $P332, "Integer"
    assign $P332, 0
    store_lex "$i", $P332
.annotate 'line', 186
    find_lex $P333, "@args"
    set $N334, $P333
    new $P335, 'Float'
    set $P335, $N334
    store_lex "$arg-count", $P335
.annotate 'line', 188
    get_hll_global $P336, ["HLL";"CommandLine"], "Result"
    $P337 = $P336."new"()
    store_lex "$result", $P337
.annotate 'line', 189
    find_lex $P338, "$result"
    $P338."init"()
    find_lex $P339, "get-value"
    find_lex $P340, "slurp-rest"
.annotate 'line', 215
    new $P534, 'ExceptionHandler'
    set_label $P534, loop533_handler
    $P534."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P534
  loop533_test:
    find_lex $P341, "$i"
    set $N342, $P341
    find_lex $P343, "$arg-count"
    set $N344, $P343
    islt $I345, $N342, $N344
    unless $I345, loop533_done
  loop533_redo:
    .const 'Sub' $P347 = "33_1299602522.66" 
    capture_lex $P347
    $P347()
  loop533_next:
    goto loop533_test
  loop533_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P535, exception, 'type'
    eq $P535, .CONTROL_LOOP_NEXT, loop533_next
    eq $P535, .CONTROL_LOOP_REDO, loop533_redo
  loop533_done:
    pop_eh 
.annotate 'line', 267
    new $P536, "Exception"
    set $P536['type'], .CONTROL_RETURN
    find_lex $P537, "$result"
    setattribute $P536, 'payload', $P537
    throw $P536
.annotate 'line', 184
    .return ()
  control_257:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P538, exception, "payload"
    .return ($P538)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "get-value"  :subid("31_1299602522.66") :outer("30_1299602522.66")
    .param pmc param_265
.annotate 'line', 192
    .lex "$opt", param_265
.annotate 'line', 193
    find_lex $P268, "$i"
    set $N269, $P268
    find_lex $P270, "$arg-count"
    sub $P271, $P270, 1
    set $N272, $P271
    iseq $I273, $N269, $N272
    if $I273, if_267
.annotate 'line', 195
    find_lex $P280, "self"
    find_lex $P281, "$i"
    add $P282, $P281, 1
    set $I283, $P282
    find_lex $P284, "@args"
    unless_null $P284, vivify_62
    $P284 = root_new ['parrot';'ResizablePMCArray']
  vivify_62:
    set $P285, $P284[$I283]
    unless_null $P285, vivify_63
    new $P285, "Undef"
  vivify_63:
    $P286 = $P280."is-option"($P285)
    if $P286, if_279
.annotate 'line', 197
    find_lex $P293, "$i"
    add $P294, $P293, 1
    set $I295, $P294
    find_lex $P296, "@args"
    unless_null $P296, vivify_64
    $P296 = root_new ['parrot';'ResizablePMCArray']
  vivify_64:
    set $P297, $P296[$I295]
    unless_null $P297, vivify_65
    new $P297, "Undef"
  vivify_65:
    find_lex $P298, "self"
    get_global $P299, "$?CLASS"
    getattribute $P300, $P298, $P299, "%!stopper"
    unless_null $P300, vivify_66
    $P300 = root_new ['parrot';'Hash']
  vivify_66:
    set $P301, $P300[$P297]
    unless_null $P301, vivify_67
    new $P301, "Undef"
  vivify_67:
    if $P301, if_292
.annotate 'line', 199
    find_lex $P306, "$i"
    clone $P307, $P306
    inc $P306
    find_lex $P308, "$i"
    set $I309, $P308
    find_lex $P310, "@args"
    unless_null $P310, vivify_68
    $P310 = root_new ['parrot';'ResizablePMCArray']
  vivify_68:
    set $P311, $P310[$I309]
    unless_null $P311, vivify_69
    new $P311, "Undef"
  vivify_69:
    set $P291, $P311
.annotate 'line', 197
    goto if_292_end
  if_292:
.annotate 'line', 198
    new $P302, 'String'
    set $P302, "Option "
    find_lex $P303, "$opt"
    concat $P304, $P302, $P303
    concat $P305, $P304, " needs a value, but is followed by a stopper"
    die $P305
  if_292_end:
.annotate 'line', 197
    set $P278, $P291
.annotate 'line', 195
    goto if_279_end
  if_279:
.annotate 'line', 196
    new $P287, 'String'
    set $P287, "Option "
    find_lex $P288, "$opt"
    concat $P289, $P287, $P288
    concat $P290, $P289, " needs a value, but is followed by an option"
    die $P290
  if_279_end:
.annotate 'line', 195
    set $P266, $P278
.annotate 'line', 193
    goto if_267_end
  if_267:
.annotate 'line', 194
    new $P274, 'String'
    set $P274, "Option "
    find_lex $P275, "$opt"
    concat $P276, $P274, $P275
    concat $P277, $P276, " needs a value"
    die $P277
  if_267_end:
.annotate 'line', 192
    .return ($P266)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.include "except_types.pasm"
.sub "slurp-rest"  :subid("32_1299602522.66") :outer("30_1299602522.66")
.annotate 'line', 207
    find_lex $P314, "$i"
    clone $P315, $P314
    inc $P314
.annotate 'line', 209
    new $P329, 'ExceptionHandler'
    set_label $P329, loop328_handler
    $P329."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P329
  loop328_test:
    find_lex $P316, "$i"
    set $N317, $P316
    find_lex $P318, "$arg-count"
    set $N319, $P318
    islt $I320, $N317, $N319
    unless $I320, loop328_done
  loop328_redo:
.annotate 'line', 210
    find_lex $P321, "$result"
    find_lex $P322, "$i"
    set $I323, $P322
    find_lex $P324, "@args"
    unless_null $P324, vivify_70
    $P324 = root_new ['parrot';'ResizablePMCArray']
  vivify_70:
    set $P325, $P324[$I323]
    unless_null $P325, vivify_71
    new $P325, "Undef"
  vivify_71:
    $P321."add-argument"($P325)
    find_lex $P326, "$i"
    clone $P327, $P326
    inc $P326
  loop328_next:
.annotate 'line', 209
    goto loop328_test
  loop328_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P330, exception, 'type'
    eq $P330, .CONTROL_LOOP_NEXT, loop328_next
    eq $P330, .CONTROL_LOOP_REDO, loop328_redo
  loop328_done:
    pop_eh 
.annotate 'line', 207
    .return ($I320)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block346"  :anon :subid("33_1299602522.66") :outer("30_1299602522.66")
.annotate 'line', 215
    .const 'Sub' $P449 = "35_1299602522.66" 
    capture_lex $P449
    .const 'Sub' $P363 = "34_1299602522.66" 
    capture_lex $P363
.annotate 'line', 216
    new $P348, "Undef"
    .lex "$cur", $P348
    find_lex $P349, "$i"
    set $I350, $P349
    find_lex $P351, "@args"
    unless_null $P351, vivify_72
    $P351 = root_new ['parrot';'ResizablePMCArray']
  vivify_72:
    set $P352, $P351[$I350]
    unless_null $P352, vivify_73
    new $P352, "Undef"
  vivify_73:
    store_lex "$cur", $P352
.annotate 'line', 217
    find_lex $P354, "self"
    find_lex $P355, "$cur"
    $P356 = $P354."is-option"($P355)
    if $P356, if_353
.annotate 'line', 259
    find_lex $P520, "$cur"
    find_lex $P521, "self"
    get_global $P522, "$?CLASS"
    getattribute $P523, $P521, $P522, "%!stopper"
    unless_null $P523, vivify_74
    $P523 = root_new ['parrot';'Hash']
  vivify_74:
    set $P524, $P523[$P520]
    unless_null $P524, vivify_75
    new $P524, "Undef"
  vivify_75:
    if $P524, if_519
.annotate 'line', 262
    find_lex $P525, "$result"
    find_lex $P526, "$cur"
    $P525."add-argument"($P526)
.annotate 'line', 263
    find_lex $P528, "self"
    get_global $P529, "$?CLASS"
    getattribute $P530, $P528, $P529, "$!stop-after-first-arg"
    unless_null $P530, vivify_76
    new $P530, "Undef"
  vivify_76:
    unless $P530, if_527_end
    "slurp-rest"()
  if_527_end:
.annotate 'line', 261
    goto if_519_end
  if_519:
.annotate 'line', 260
    "slurp-rest"()
  if_519_end:
.annotate 'line', 259
    goto if_353_end
  if_353:
.annotate 'line', 218
    find_lex $P358, "$cur"
    set $S359, $P358
    substr $S360, $S359, 0, 2
    iseq $I361, $S360, "--"
    if $I361, if_357
.annotate 'line', 237
    .const 'Sub' $P449 = "35_1299602522.66" 
    capture_lex $P449
    $P449()
    goto if_357_end
  if_357:
.annotate 'line', 218
    .const 'Sub' $P363 = "34_1299602522.66" 
    capture_lex $P363
    $P363()
  if_357_end:
  if_353_end:
.annotate 'line', 217
    find_lex $P531, "$i"
    clone $P532, $P531
    inc $P531
.annotate 'line', 215
    .return ($P532)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block448"  :anon :subid("35_1299602522.66") :outer("33_1299602522.66")
.annotate 'line', 237
    .const 'Sub' $P494 = "36_1299602522.66" 
    capture_lex $P494
.annotate 'line', 238
    new $P450, "Undef"
    .lex "$opt", $P450
    find_lex $P451, "$cur"
    set $S452, $P451
    substr $S453, $S452, 1
    new $P454, 'String'
    set $P454, $S453
    store_lex "$opt", $P454
.annotate 'line', 239
    find_lex $P457, "$opt"
    set $S458, $P457
    length $I459, $S458
    set $N460, $I459
    iseq $I461, $N460, 1.0
    if $I461, if_456
.annotate 'line', 249
    .const 'Sub' $P494 = "36_1299602522.66" 
    capture_lex $P494
    $P518 = $P494()
    set $P455, $P518
.annotate 'line', 239
    goto if_456_end
  if_456:
.annotate 'line', 241
    find_lex $P463, "$opt"
    find_lex $P464, "self"
    get_global $P465, "$?CLASS"
    getattribute $P466, $P464, $P465, "%!options"
    unless_null $P466, vivify_77
    $P466 = root_new ['parrot';'Hash']
  vivify_77:
    set $P467, $P466[$P463]
    unless_null $P467, vivify_78
    new $P467, "Undef"
  vivify_78:
    if $P467, unless_462_end
    new $P468, 'String'
    set $P468, "No such option -"
    find_lex $P469, "$opt"
    concat $P470, $P468, $P469
    die $P470
  unless_462_end:
.annotate 'line', 242
    find_lex $P472, "self"
    find_lex $P473, "$opt"
    $P474 = $P472."wants-value"($P473)
    if $P474, if_471
.annotate 'line', 246
    find_lex $P481, "$result"
    find_lex $P482, "$opt"
    $P481."add-option"($P482, 1)
.annotate 'line', 245
    goto if_471_end
  if_471:
.annotate 'line', 243
    find_lex $P475, "$result"
    find_lex $P476, "$opt"
.annotate 'line', 244
    new $P477, 'String'
    set $P477, "-"
    find_lex $P478, "$opt"
    concat $P479, $P477, $P478
    $P480 = "get-value"($P479)
    $P475."add-option"($P476, $P480)
  if_471_end:
.annotate 'line', 248
    new $P485, 'String'
    set $P485, "-"
    find_lex $P486, "$opt"
    concat $P487, $P485, $P486
    find_lex $P488, "self"
    get_global $P489, "$?CLASS"
    getattribute $P490, $P488, $P489, "%!stopper"
    unless_null $P490, vivify_79
    $P490 = root_new ['parrot';'Hash']
  vivify_79:
    set $P491, $P490[$P487]
    unless_null $P491, vivify_80
    new $P491, "Undef"
  vivify_80:
    if $P491, if_484
    set $P483, $P491
    goto if_484_end
  if_484:
    $P492 = "slurp-rest"()
    set $P483, $P492
  if_484_end:
.annotate 'line', 239
    set $P455, $P483
  if_456_end:
.annotate 'line', 237
    .return ($P455)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.include "except_types.pasm"
.sub "_block493"  :anon :subid("36_1299602522.66") :outer("35_1299602522.66")
.annotate 'line', 249
    .const 'Sub' $P500 = "37_1299602522.66" 
    capture_lex $P500
.annotate 'line', 251
    new $P495, "Undef"
    .lex "$iter", $P495
    find_lex $P496, "$opt"
    iter $P497, $P496
    store_lex "$iter", $P497
.annotate 'line', 252
    new $P516, 'ExceptionHandler'
    set_label $P516, loop515_handler
    $P516."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P516
  loop515_test:
    find_lex $P498, "$iter"
    unless $P498, loop515_done
  loop515_redo:
    .const 'Sub' $P500 = "37_1299602522.66" 
    capture_lex $P500
    $P500()
  loop515_next:
    goto loop515_test
  loop515_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P517, exception, 'type'
    eq $P517, .CONTROL_LOOP_NEXT, loop515_next
    eq $P517, .CONTROL_LOOP_REDO, loop515_redo
  loop515_done:
    pop_eh 
.annotate 'line', 249
    .return ($P498)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block499"  :anon :subid("37_1299602522.66") :outer("36_1299602522.66")
.annotate 'line', 253
    new $P501, "Undef"
    .lex "$o", $P501
    find_lex $P502, "$iter"
    shift $P503, $P502
    store_lex "$o", $P503
.annotate 'line', 254
    find_lex $P505, "self"
    find_lex $P506, "$o"
    $P507 = $P505."wants-value"($P506)
    unless $P507, if_504_end
    new $P508, 'String'
    set $P508, "Option -"
    find_lex $P509, "$o"
    concat $P510, $P508, $P509
    concat $P511, $P510, " requires a value and cannot be grouped"
    die $P511
  if_504_end:
.annotate 'line', 255
    find_lex $P512, "$result"
    find_lex $P513, "$o"
    $P514 = $P512."add-option"($P513, 1)
.annotate 'line', 252
    .return ($P514)
.end


.HLL "nqp"

.namespace ["HLL";"CommandLine";"Parser"]
.sub "_block362"  :anon :subid("34_1299602522.66") :outer("33_1299602522.66")
.annotate 'line', 220
    new $P364, "Undef"
    .lex "$opt", $P364
.annotate 'line', 221
    new $P365, "Undef"
    .lex "$idx", $P365
.annotate 'line', 222
    new $P366, "Undef"
    .lex "$value", $P366
.annotate 'line', 223
    new $P367, "Undef"
    .lex "$has-value", $P367
.annotate 'line', 220
    find_lex $P368, "$i"
    set $I369, $P368
    find_lex $P370, "@args"
    unless_null $P370, vivify_81
    $P370 = root_new ['parrot';'ResizablePMCArray']
  vivify_81:
    set $P371, $P370[$I369]
    unless_null $P371, vivify_82
    new $P371, "Undef"
  vivify_82:
    set $S372, $P371
    substr $S373, $S372, 2
    new $P374, 'String'
    set $P374, $S373
    store_lex "$opt", $P374
.annotate 'line', 221
    find_lex $P375, "$opt"
    set $S376, $P375
    index $I377, $S376, "="
    new $P378, 'Integer'
    set $P378, $I377
    store_lex "$idx", $P378
.annotate 'line', 222
    new $P379, "Integer"
    assign $P379, 1
    store_lex "$value", $P379
.annotate 'line', 223
    new $P380, "Integer"
    assign $P380, 0
    store_lex "$has-value", $P380
.annotate 'line', 225
    find_lex $P382, "$idx"
    set $N383, $P382
    isge $I384, $N383, 0.0
    unless $I384, if_381_end
.annotate 'line', 226
    find_lex $P385, "$opt"
    set $S386, $P385
    find_lex $P387, "$idx"
    add $P388, $P387, 1
    set $I389, $P388
    substr $S390, $S386, $I389
    new $P391, 'String'
    set $P391, $S390
    store_lex "$value", $P391
.annotate 'line', 227
    find_lex $P392, "$opt"
    set $S393, $P392
    find_lex $P394, "$idx"
    set $I395, $P394
    substr $S396, $S393, 0, $I395
    new $P397, 'String'
    set $P397, $S396
    store_lex "$opt", $P397
.annotate 'line', 228
    new $P398, "Integer"
    assign $P398, 1
    store_lex "$has-value", $P398
  if_381_end:
.annotate 'line', 230
    find_lex $P403, "$opt"
    find_lex $P400, "self"
    get_global $P401, "$?CLASS"
    getattribute $P402, $P400, $P401, "%!options"
    unless_null $P402, vivify_83
    $P402 = root_new ['parrot';'Hash']
  vivify_83:
    exists $I404, $P402[$P403]
    if $I404, unless_399_end
    new $P405, 'String'
    set $P405, "Illegal option --"
    find_lex $P406, "$opt"
    concat $P407, $P405, $P406
    die $P407
  unless_399_end:
.annotate 'line', 231
    find_lex $P411, "$opt"
    find_lex $P412, "self"
    get_global $P413, "$?CLASS"
    getattribute $P414, $P412, $P413, "%!options"
    unless_null $P414, vivify_84
    $P414 = root_new ['parrot';'Hash']
  vivify_84:
    set $P415, $P414[$P411]
    unless_null $P415, vivify_85
    new $P415, "Undef"
  vivify_85:
    set $S416, $P415
    isne $I417, $S416, "s"
    if $I417, if_410
    new $P409, 'Integer'
    set $P409, $I417
    goto if_410_end
  if_410:
    find_lex $P418, "$has-value"
    set $P409, $P418
  if_410_end:
    unless $P409, if_408_end
    new $P419, 'String'
    set $P419, "Option --"
    find_lex $P420, "$opt"
    concat $P421, $P419, $P420
    concat $P422, $P421, " does not allow a value"
    die $P422
  if_408_end:
.annotate 'line', 232
    find_lex $P426, "$has-value"
    isfalse $I427, $P426
    if $I427, if_425
    new $P424, 'Integer'
    set $P424, $I427
    goto if_425_end
  if_425:
    find_lex $P428, "self"
    find_lex $P429, "$opt"
    $P430 = $P428."wants-value"($P429)
    set $P424, $P430
  if_425_end:
    unless $P424, if_423_end
.annotate 'line', 233
    new $P431, 'String'
    set $P431, "--"
    find_lex $P432, "$opt"
    concat $P433, $P431, $P432
    $P434 = "get-value"($P433)
    store_lex "$value", $P434
  if_423_end:
.annotate 'line', 235
    find_lex $P435, "$result"
    find_lex $P436, "$opt"
    find_lex $P437, "$value"
    $P435."add-option"($P436, $P437)
.annotate 'line', 236
    new $P440, 'String'
    set $P440, "--"
    find_lex $P441, "$opt"
    concat $P442, $P440, $P441
    find_lex $P443, "self"
    get_global $P444, "$?CLASS"
    getattribute $P445, $P443, $P444, "%!stopper"
    unless_null $P445, vivify_86
    $P445 = root_new ['parrot';'Hash']
  vivify_86:
    set $P446, $P445[$P442]
    unless_null $P446, vivify_87
    new $P446, "Undef"
  vivify_87:
    if $P446, if_439
    set $P438, $P446
    goto if_439_end
  if_439:
    get_hll_global $P447, "slurp-rest"
    set $P438, $P447
  if_439_end:
.annotate 'line', 218
    .return ($P438)
.end


.HLL "nqp"

.namespace []
.sub "_block576" :load :anon :subid("39_1299602522.66")
.annotate 'line', 1
    .const 'Sub' $P578 = "10_1299602522.66" 
    $P579 = $P578()
    .return ($P579)
.end

### .include 'gen/hllserializationcontextbuilder.pir'

.HLL "nqp"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.namespace []
.sub "_block11"  :anon :subid("10_1299602523.815")
.annotate 'line', 0
    get_hll_global $P48, ["HLL";"Compiler";"SerializationContextBuilder"], "_block47" 
    capture_lex $P48
    get_hll_global $P19, ["HLL";"Compiler";"SerializationContextBuilder";"Event"], "_block18" 
    capture_lex $P19
.annotate 'line', 1
    getinterp $P13
    get_class $P14, "LexPad"
    get_class $P15, "NQPLexPad"
    $P13."hll_map"($P14, $P15)
    get_hll_global $P16, ["HLL";"Compiler"], "SerializationContextBuilder"
    get_hll_global $P17, ["HLL";"Compiler";"SerializationContextBuilder"], "Event"
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
.annotate 'line', 29
    get_hll_global $P19, ["HLL";"Compiler";"SerializationContextBuilder";"Event"], "_block18" 
    capture_lex $P19
    $P19()
.annotate 'line', 39
    get_hll_global $P48, ["HLL";"Compiler";"SerializationContextBuilder"], "_block47" 
    capture_lex $P48
    $P421 = $P48()
.annotate 'line', 1
    .return ($P421)
    .const 'Sub' $P423 = "35_1299602523.815" 
    .return ($P423)
.end


.HLL "nqp"

.namespace []
.sub "" :load :init :subid("post36") :outer("10_1299602523.815")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1299602523.815" 
    .local pmc block
    set block, $P12
    nqp_get_sc $P427, "1299602522.998"
    isnull $I428, $P427
    if $I428, if_426
    goto if_426_end
  if_426:
    nqp_dynop_setup 
    load_bytecode "nqpmo.pbc"
    nqp_create_sc $P429, "1299602522.998"
    .local pmc cur_sc
    set cur_sc, $P429
    load_bytecode "SettingManager.pbc"
    get_hll_global $P430, ["HLL"], "SettingManager"
    $P431 = $P430."load_setting"("NQPCORE")
    block."set_outer_ctx"($P431)
    get_hll_global $P432, "NQPClassHOW"
    $P433 = $P432."new_type"("HLL::Compiler::SerializationContextBuilder::Event" :named("name"))
    nqp_set_sc_for_object $P433, cur_sc
    nqp_set_sc_object "1299602522.998", 0, $P433
    get_hll_global $P434, "NQPClassHOW"
    $P435 = $P434."new_type"("HLL::Compiler::SerializationContextBuilder" :named("name"))
    nqp_set_sc_for_object $P435, cur_sc
    nqp_set_sc_object "1299602522.998", 1, $P435
  if_426_end:
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder";"Event"]
.sub "_block18"  :subid("11_1299602523.815") :outer("10_1299602523.815")
.annotate 'line', 29
    .const 'Sub' $P33 = "14_1299602523.815" 
    capture_lex $P33
    .const 'Sub' $P26 = "13_1299602523.815" 
    capture_lex $P26
    .const 'Sub' $P21 = "12_1299602523.815" 
    capture_lex $P21
    get_global $P20, "$?CLASS"
.annotate 'line', 36
    .const 'Sub' $P26 = "13_1299602523.815" 
    newclosure $P31, $P26
.annotate 'line', 29
    .return ($P31)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder";"Event"]
.sub "" :load :init :subid("post37") :outer("11_1299602523.815")
.annotate 'line', 29
    get_hll_global $P19, ["HLL";"Compiler";"SerializationContextBuilder";"Event"], "_block18" 
    .local pmc block
    set block, $P19
    .const 'Sub' $P33 = "14_1299602523.815" 
    capture_lex $P33
    $P33()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder";"Event"]
.sub "_block32"  :anon :subid("14_1299602523.815") :outer("11_1299602523.815")
.annotate 'line', 29
    nqp_get_sc_object $P34, "1299602522.998", 0
    .local pmc type_obj
    set type_obj, $P34
    set_hll_global ["HLL";"Compiler";"SerializationContextBuilder"], "Event", type_obj
    set_global "$?CLASS", type_obj
    get_how $P35, type_obj
    get_hll_global $P36, "NQPAttribute"
    $P37 = $P36."new"("$!deserialize_past" :named("name"))
    $P35."add_attribute"(type_obj, $P37)
    get_how $P38, type_obj
    .const 'Sub' $P39 = "12_1299602523.815" 
    $P38."add_method"(type_obj, "deserialize_past", $P39)
    get_how $P40, type_obj
    get_hll_global $P41, "NQPAttribute"
    $P42 = $P41."new"("$!fixup_past" :named("name"))
    $P40."add_attribute"(type_obj, $P42)
    get_how $P43, type_obj
    .const 'Sub' $P44 = "13_1299602523.815" 
    $P43."add_method"(type_obj, "fixup_past", $P44)
    get_how $P45, type_obj
    $P46 = $P45."compose"(type_obj)
    .return ($P46)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder";"Event"]
.sub "deserialize_past"  :subid("12_1299602523.815") :outer("11_1299602523.815")
    .param pmc param_22
.annotate 'line', 32
    .lex "self", param_22
    find_lex $P23, "self"
    get_global $P24, "$?CLASS"
    getattribute $P25, $P23, $P24, "$!deserialize_past"
    unless_null $P25, vivify_38
    new $P25, "Undef"
  vivify_38:
    .return ($P25)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder";"Event"]
.sub "fixup_past"  :subid("13_1299602523.815") :outer("11_1299602523.815")
    .param pmc param_27
.annotate 'line', 36
    .lex "self", param_27
    find_lex $P28, "self"
    get_global $P29, "$?CLASS"
    getattribute $P30, $P28, $P29, "$!fixup_past"
    unless_null $P30, vivify_39
    new $P30, "Undef"
  vivify_39:
    .return ($P30)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "_block47"  :subid("15_1299602523.815") :outer("10_1299602523.815")
.annotate 'line', 39
    .const 'Sub' $P375 = "34_1299602523.815" 
    capture_lex $P375
    .const 'Sub' $P309 = "32_1299602523.815" 
    capture_lex $P309
    .const 'Sub' $P304 = "31_1299602523.815" 
    capture_lex $P304
    .const 'Sub' $P290 = "30_1299602523.815" 
    capture_lex $P290
    .const 'Sub' $P284 = "29_1299602523.815" 
    capture_lex $P284
    .const 'Sub' $P278 = "28_1299602523.815" 
    capture_lex $P278
    .const 'Sub' $P209 = "27_1299602523.815" 
    capture_lex $P209
    .const 'Sub' $P176 = "25_1299602523.815" 
    capture_lex $P176
    .const 'Sub' $P162 = "24_1299602523.815" 
    capture_lex $P162
    .const 'Sub' $P137 = "23_1299602523.815" 
    capture_lex $P137
    .const 'Sub' $P129 = "22_1299602523.815" 
    capture_lex $P129
    .const 'Sub' $P114 = "21_1299602523.815" 
    capture_lex $P114
    .const 'Sub' $P97 = "20_1299602523.815" 
    capture_lex $P97
    .const 'Sub' $P83 = "19_1299602523.815" 
    capture_lex $P83
    .const 'Sub' $P65 = "18_1299602523.815" 
    capture_lex $P65
    .const 'Sub' $P56 = "17_1299602523.815" 
    capture_lex $P56
    .const 'Sub' $P50 = "16_1299602523.815" 
    capture_lex $P50
    get_global $P49, "$?CLASS"
.annotate 'line', 49
    .const 'Sub' $P50 = "16_1299602523.815" 
    newclosure $P54, $P50
    .lex "addr", $P54
.annotate 'line', 39
    find_lex $P55, "addr"
.annotate 'line', 210
    .const 'Sub' $P309 = "32_1299602523.815" 
    newclosure $P373, $P309
.annotate 'line', 39
    .return ($P373)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "" :load :init :subid("post40") :outer("15_1299602523.815")
.annotate 'line', 39
    get_hll_global $P48, ["HLL";"Compiler";"SerializationContextBuilder"], "_block47" 
    .local pmc block
    set block, $P48
    .const 'Sub' $P375 = "34_1299602523.815" 
    capture_lex $P375
    $P375()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "_block374"  :anon :subid("34_1299602523.815") :outer("15_1299602523.815")
.annotate 'line', 39
    nqp_get_sc_object $P376, "1299602522.998", 1
    .local pmc type_obj
    set type_obj, $P376
    set_hll_global ["HLL";"Compiler"], "SerializationContextBuilder", type_obj
    set_global "$?CLASS", type_obj
    get_how $P377, type_obj
    get_hll_global $P378, "NQPAttribute"
    $P379 = $P378."new"("$!sc" :named("name"))
    $P377."add_attribute"(type_obj, $P379)
    get_how $P380, type_obj
    get_hll_global $P381, "NQPAttribute"
    $P382 = $P381."new"("$!handle" :named("name"))
    $P380."add_attribute"(type_obj, $P382)
    get_how $P383, type_obj
    get_hll_global $P384, "NQPAttribute"
    $P385 = $P384."new"("%!addr_to_slot" :named("name"))
    $P383."add_attribute"(type_obj, $P385)
    get_how $P386, type_obj
    get_hll_global $P387, "NQPAttribute"
    $P388 = $P387."new"("@!event_stream" :named("name"))
    $P386."add_attribute"(type_obj, $P388)
    get_how $P389, type_obj
    .const 'Sub' $P390 = "17_1299602523.815" 
    $P389."add_method"(type_obj, "new", $P390)
    get_how $P391, type_obj
    .const 'Sub' $P392 = "18_1299602523.815" 
    $P391."add_method"(type_obj, "BUILD", $P392)
    get_how $P393, type_obj
    .const 'Sub' $P394 = "19_1299602523.815" 
    $P393."add_method"(type_obj, "slot_for_object", $P394)
    get_how $P395, type_obj
    .const 'Sub' $P396 = "20_1299602523.815" 
    $P395."add_method"(type_obj, "get_slot_past_for_object", $P396)
    get_how $P397, type_obj
    .const 'Sub' $P398 = "21_1299602523.815" 
    $P397."add_method"(type_obj, "set_slot_past", $P398)
    get_how $P399, type_obj
    .const 'Sub' $P400 = "22_1299602523.815" 
    $P399."add_method"(type_obj, "set_cur_sc", $P400)
    get_how $P401, type_obj
    .const 'Sub' $P402 = "23_1299602523.815" 
    $P401."add_method"(type_obj, "add_object", $P402)
    get_how $P403, type_obj
    .const 'Sub' $P404 = "24_1299602523.815" 
    $P403."add_method"(type_obj, "add_event", $P404)
    get_how $P405, type_obj
    .const 'Sub' $P406 = "25_1299602523.815" 
    $P405."add_method"(type_obj, "load_setting", $P406)
    get_how $P407, type_obj
    .const 'Sub' $P408 = "27_1299602523.815" 
    $P407."add_method"(type_obj, "pkg_create_mo", $P408)
    get_how $P409, type_obj
    .const 'Sub' $P410 = "28_1299602523.815" 
    $P409."add_method"(type_obj, "pkg_add_method", $P410)
    get_how $P411, type_obj
    .const 'Sub' $P412 = "29_1299602523.815" 
    $P411."add_method"(type_obj, "pkg_add_parent_or_role", $P412)
    get_how $P413, type_obj
    .const 'Sub' $P414 = "30_1299602523.815" 
    $P413."add_method"(type_obj, "pkg_compose", $P414)
    get_how $P415, type_obj
    .const 'Sub' $P416 = "31_1299602523.815" 
    $P415."add_method"(type_obj, "sc", $P416)
    get_how $P417, type_obj
    .const 'Sub' $P418 = "32_1299602523.815" 
    $P417."add_method"(type_obj, "to_past", $P418)
    get_how $P419, type_obj
    $P420 = $P419."compose"(type_obj)
    .return ($P420)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "addr"  :subid("16_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_51
.annotate 'line', 49
    .lex "$obj", param_51
.annotate 'line', 50
    find_lex $P52, "$obj"
    get_addr $I53, $P52
.annotate 'line', 49
    .return ($I53)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "new"  :subid("17_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_57
    .param pmc param_58 :named("handle")
.annotate 'line', 57
    .lex "self", param_57
    .lex "$handle", param_58
.annotate 'line', 58
    new $P59, "Undef"
    .lex "$obj", $P59
    find_lex $P60, "self"
    $P61 = $P60."CREATE"()
    store_lex "$obj", $P61
.annotate 'line', 59
    find_lex $P62, "$obj"
    find_lex $P63, "$handle"
    $P62."BUILD"($P63 :named("handle"))
    find_lex $P64, "$obj"
.annotate 'line', 57
    .return ($P64)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "BUILD"  :subid("18_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_66
    .param pmc param_67 :optional :named("handle")
    .param int has_param_67 :opt_flag
.annotate 'line', 63
    .lex "self", param_66
    if has_param_67, optparam_41
    new $P68, "Undef"
    set param_67, $P68
  optparam_41:
    .lex "$handle", param_67
.annotate 'line', 64
    find_lex $P69, "$handle"
    set $S70, $P69
    nqp_create_sc $P71, $S70
    find_lex $P72, "self"
    get_global $P73, "$?CLASS"
    setattribute $P72, $P73, "$!sc", $P71
.annotate 'line', 65
    find_lex $P74, "$handle"
    find_lex $P75, "self"
    get_global $P76, "$?CLASS"
    setattribute $P75, $P76, "$!handle", $P74
.annotate 'line', 66
    new $P77, "Hash"
    find_lex $P78, "self"
    get_global $P79, "$?CLASS"
    setattribute $P78, $P79, "%!addr_to_slot", $P77
.annotate 'line', 67
    new $P80, "ResizablePMCArray"
    find_lex $P81, "self"
    get_global $P82, "$?CLASS"
    setattribute $P81, $P82, "@!event_stream", $P80
.annotate 'line', 63
    .return ($P80)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "slot_for_object"  :subid("19_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_84
    .param pmc param_85
.annotate 'line', 71
    .lex "self", param_84
    .lex "$obj", param_85
.annotate 'line', 72
    new $P86, "Undef"
    .lex "$slot", $P86
    find_lex $P87, "$obj"
    $P88 = "addr"($P87)
    find_lex $P89, "self"
    get_global $P90, "$?CLASS"
    getattribute $P91, $P89, $P90, "%!addr_to_slot"
    unless_null $P91, vivify_42
    $P91 = root_new ['parrot';'Hash']
  vivify_42:
    set $P92, $P91[$P88]
    unless_null $P92, vivify_43
    new $P92, "Undef"
  vivify_43:
    store_lex "$slot", $P92
.annotate 'line', 73
    find_lex $P94, "$slot"
    defined $I95, $P94
    if $I95, unless_93_end
.annotate 'line', 74
    die "slot_for_object called on object not in context"
  unless_93_end:
.annotate 'line', 73
    find_lex $P96, "$slot"
.annotate 'line', 71
    .return ($P96)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.include "except_types.pasm"
.sub "get_slot_past_for_object"  :subid("20_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_100
    .param pmc param_101
.annotate 'line', 83
    new $P99, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P99, control_98
    push_eh $P99
    .lex "self", param_100
    .lex "$obj", param_101
.annotate 'line', 84
    new $P102, "Undef"
    .lex "$slot", $P102
    find_lex $P103, "self"
    find_lex $P104, "$obj"
    $P105 = $P103."slot_for_object"($P104)
    store_lex "$slot", $P105
.annotate 'line', 85
    new $P106, "Exception"
    set $P106['type'], .CONTROL_RETURN
    get_hll_global $P107, ["PAST"], "Op"
    find_lex $P108, "self"
    get_global $P109, "$?CLASS"
    getattribute $P110, $P108, $P109, "$!handle"
    unless_null $P110, vivify_44
    new $P110, "Undef"
  vivify_44:
    find_lex $P111, "$slot"
    $P112 = $P107."new"($P110, $P111, "nqp_get_sc_object Psi" :named("pirop"))
    setattribute $P106, 'payload', $P112
    throw $P106
.annotate 'line', 83
    .return ()
  control_98:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P113, exception, "payload"
    .return ($P113)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.include "except_types.pasm"
.sub "set_slot_past"  :subid("21_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_117
    .param pmc param_118
    .param pmc param_119
.annotate 'line', 89
    new $P116, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P116, control_115
    push_eh $P116
    .lex "self", param_117
    .lex "$slot", param_118
    .lex "$past_to_set", param_119
.annotate 'line', 90
    new $P120, "Exception"
    set $P120['type'], .CONTROL_RETURN
    get_hll_global $P121, ["PAST"], "Op"
    find_lex $P122, "self"
    get_global $P123, "$?CLASS"
    getattribute $P124, $P122, $P123, "$!handle"
    unless_null $P124, vivify_45
    new $P124, "Undef"
  vivify_45:
    find_lex $P125, "$slot"
    find_lex $P126, "$past_to_set"
    $P127 = $P121."new"($P124, $P125, $P126, "nqp_set_sc_object vsiP" :named("pirop"))
    setattribute $P120, 'payload', $P127
    throw $P120
.annotate 'line', 89
    .return ()
  control_115:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P128, exception, "payload"
    .return ($P128)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "set_cur_sc"  :subid("22_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_130
    .param pmc param_131
.annotate 'line', 96
    .lex "self", param_130
    .lex "$to_wrap", param_131
.annotate 'line', 97
    get_hll_global $P132, ["PAST"], "Op"
    find_lex $P133, "$to_wrap"
.annotate 'line', 100
    get_hll_global $P134, ["PAST"], "Var"
    $P135 = $P134."new"("cur_sc" :named("name"), "register" :named("scope"))
    $P136 = $P132."new"($P133, $P135, "nqp_set_sc_for_object__0PP" :named("pirop"))
.annotate 'line', 96
    .return ($P136)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "add_object"  :subid("23_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_138
    .param pmc param_139
.annotate 'line', 105
    .lex "self", param_138
    .lex "$obj", param_139
.annotate 'line', 107
    new $P140, "Undef"
    .lex "$idx", $P140
.annotate 'line', 106
    find_lex $P141, "$obj"
    find_lex $P142, "self"
    get_global $P143, "$?CLASS"
    getattribute $P144, $P142, $P143, "$!sc"
    unless_null $P144, vivify_46
    new $P144, "Undef"
  vivify_46:
    nqp_set_sc_for_object $P141, $P144
.annotate 'line', 107
    find_lex $P145, "self"
    get_global $P146, "$?CLASS"
    getattribute $P147, $P145, $P146, "$!sc"
    unless_null $P147, vivify_47
    new $P147, "Undef"
  vivify_47:
    $P148 = $P147."elems"()
    store_lex "$idx", $P148
.annotate 'line', 108
    find_lex $P149, "$obj"
    find_lex $P150, "$idx"
    set $I151, $P150
    find_lex $P152, "self"
    get_global $P153, "$?CLASS"
    getattribute $P154, $P152, $P153, "$!sc"
    unless_null $P154, vivify_48
    $P154 = root_new ['parrot';'ResizablePMCArray']
    setattribute $P152, $P153, "$!sc", $P154
  vivify_48:
    set $P154[$I151], $P149
.annotate 'line', 109
    find_lex $P155, "$idx"
    find_lex $P156, "$obj"
    $P157 = "addr"($P156)
    find_lex $P158, "self"
    get_global $P159, "$?CLASS"
    getattribute $P160, $P158, $P159, "%!addr_to_slot"
    unless_null $P160, vivify_49
    $P160 = root_new ['parrot';'Hash']
    setattribute $P158, $P159, "%!addr_to_slot", $P160
  vivify_49:
    set $P160[$P157], $P155
    find_lex $P161, "$idx"
.annotate 'line', 105
    .return ($P161)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "add_event"  :subid("24_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_163
    .param pmc param_164 :optional :named("deserialize_past")
    .param int has_param_164 :opt_flag
    .param pmc param_166 :optional :named("fixup_past")
    .param int has_param_166 :opt_flag
.annotate 'line', 114
    .lex "self", param_163
    if has_param_164, optparam_50
    new $P165, "Undef"
    set param_164, $P165
  optparam_50:
    .lex "$deserialize_past", param_164
    if has_param_166, optparam_51
    new $P167, "Undef"
    set param_166, $P167
  optparam_51:
    .lex "$fixup_past", param_166
.annotate 'line', 115
    find_lex $P168, "self"
    get_global $P169, "$?CLASS"
    getattribute $P170, $P168, $P169, "@!event_stream"
    unless_null $P170, vivify_52
    $P170 = root_new ['parrot';'ResizablePMCArray']
  vivify_52:
    get_hll_global $P171, ["HLL";"Compiler";"SerializationContextBuilder"], "Event"
    find_lex $P172, "$deserialize_past"
    find_lex $P173, "$fixup_past"
    $P174 = $P171."new"($P172 :named("deserialize_past"), $P173 :named("fixup_past"))
    $P175 = $P170."push"($P174)
.annotate 'line', 114
    .return ($P175)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "load_setting"  :subid("25_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_177
    .param pmc param_178
.annotate 'line', 121
    .const 'Sub' $P185 = "26_1299602523.815" 
    capture_lex $P185
    .lex "self", param_177
    .lex "$setting_name", param_178
.annotate 'line', 123
    find_lex $P181, "$setting_name"
    set $S182, $P181
    isne $I183, $S182, "NULL"
    if $I183, if_180
    new $P179, 'Integer'
    set $P179, $I183
    goto if_180_end
  if_180:
    .const 'Sub' $P185 = "26_1299602523.815" 
    capture_lex $P185
    $P208 = $P185()
    set $P179, $P208
  if_180_end:
.annotate 'line', 121
    .return ($P179)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "_block184"  :anon :subid("26_1299602523.815") :outer("25_1299602523.815")
.annotate 'line', 130
    new $P186, "Undef"
    .lex "$load_past", $P186
.annotate 'line', 127
    get_hll_global $P187, ["HLL"], "SettingManager"
    find_lex $P188, "$setting_name"
    $P189 = $P187."load_setting"($P188)
    find_dynamic_lex $P190, "%*COMPILING"
    unless_null $P190, vivify_53
    get_hll_global $P190, "%COMPILING"
    unless_null $P190, vivify_54
    die "Contextual %*COMPILING not found"
  vivify_54:
    store_dynamic_lex "%*COMPILING", $P190
  vivify_53:
    set $P191, $P190["%?OPTIONS"]
    unless_null $P191, vivify_55
    $P191 = root_new ['parrot';'Hash']
    set $P190["%?OPTIONS"], $P191
  vivify_55:
    set $P191["outer_ctx"], $P189
.annotate 'line', 130
    get_hll_global $P192, ["PAST"], "Stmts"
.annotate 'line', 131
    get_hll_global $P193, ["PAST"], "Op"
    $P194 = $P193."new"("SettingManager.pbc", "load_bytecode vs" :named("pirop"))
.annotate 'line', 134
    get_hll_global $P195, ["PAST"], "Op"
.annotate 'line', 136
    get_hll_global $P196, ["PAST"], "Var"
    $P197 = $P196."new"("block" :named("name"), "register" :named("scope"))
.annotate 'line', 137
    get_hll_global $P198, ["PAST"], "Op"
.annotate 'line', 139
    get_hll_global $P199, ["PAST"], "Var"
    $P200 = $P199."new"("SettingManager" :named("name"), "HLL" :named("namespace"), "package" :named("scope"))
    find_lex $P201, "$setting_name"
    $P202 = $P198."new"($P200, $P201, "callmethod" :named("pasttype"), "load_setting" :named("name"))
.annotate 'line', 137
    $P203 = $P195."new"($P197, $P202, "callmethod" :named("pasttype"), "set_outer_ctx" :named("name"))
.annotate 'line', 134
    $P204 = $P192."new"($P194, $P203)
.annotate 'line', 130
    store_lex "$load_past", $P204
.annotate 'line', 144
    find_lex $P205, "self"
    find_lex $P206, "$load_past"
    $P207 = $P205."add_event"($P206 :named("deserialize_past"))
.annotate 'line', 123
    .return ($P207)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.include "except_types.pasm"
.sub "pkg_create_mo"  :subid("27_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_212
    .param pmc param_213
    .param pmc param_214 :optional :named("name")
    .param int has_param_214 :opt_flag
    .param pmc param_216 :optional :named("repr")
    .param int has_param_216 :opt_flag
.annotate 'line', 150
    new $P211, ['ExceptionHandler'], .CONTROL_RETURN
    set_label $P211, control_210
    push_eh $P211
    .lex "self", param_212
    .lex "$how", param_213
    if has_param_214, optparam_56
    new $P215, "Undef"
    set param_214, $P215
  optparam_56:
    .lex "$name", param_214
    if has_param_216, optparam_57
    new $P217, "Undef"
    set param_216, $P217
  optparam_57:
    .lex "$repr", param_216
.annotate 'line', 152
    $P218 = root_new ['parrot';'Hash']
    .lex "%args", $P218
.annotate 'line', 155
    new $P219, "Undef"
    .lex "$mo", $P219
.annotate 'line', 156
    new $P220, "Undef"
    .lex "$slot", $P220
.annotate 'line', 160
    $P221 = root_new ['parrot';'ResizablePMCArray']
    .lex "@how_ns", $P221
.annotate 'line', 161
    new $P222, "Undef"
    .lex "$how_name", $P222
.annotate 'line', 162
    new $P223, "Undef"
    .lex "$setup_call", $P223
.annotate 'line', 150
    find_lex $P224, "%args"
.annotate 'line', 153
    find_lex $P226, "$name"
    defined $I227, $P226
    unless $I227, if_225_end
    find_lex $P228, "$name"
    find_lex $P229, "%args"
    unless_null $P229, vivify_58
    $P229 = root_new ['parrot';'Hash']
    store_lex "%args", $P229
  vivify_58:
    set $P229["name"], $P228
  if_225_end:
.annotate 'line', 154
    find_lex $P231, "$repr"
    defined $I232, $P231
    unless $I232, if_230_end
    find_lex $P233, "$repr"
    find_lex $P234, "%args"
    unless_null $P234, vivify_59
    $P234 = root_new ['parrot';'Hash']
    store_lex "%args", $P234
  vivify_59:
    set $P234["repr"], $P233
  if_230_end:
.annotate 'line', 155
    find_lex $P235, "$how"
    find_lex $P236, "%args"
    $P237 = $P235."new_type"($P236 :flat)
    store_lex "$mo", $P237
.annotate 'line', 156
    find_lex $P238, "self"
    find_lex $P239, "$mo"
    $P240 = $P238."add_object"($P239)
    store_lex "$slot", $P240
.annotate 'line', 160
    find_lex $P241, "$how"
    get_how $P242, $P241
    find_lex $P243, "$how"
    $S244 = $P242."name"($P243)
    split $P245, "::", $S244
    store_lex "@how_ns", $P245
.annotate 'line', 161
    find_lex $P246, "@how_ns"
    $P247 = $P246."pop"()
    store_lex "$how_name", $P247
.annotate 'line', 162
    get_hll_global $P248, ["PAST"], "Op"
.annotate 'line', 165
    get_hll_global $P249, ["PAST"], "Var"
    find_lex $P250, "$how_name"
    find_lex $P251, "@how_ns"
    $P252 = $P249."new"($P250 :named("name"), $P251 :named("namespace"), "package" :named("scope"))
    $P253 = $P248."new"($P252, "callmethod" :named("pasttype"), "new_type" :named("name"))
.annotate 'line', 162
    store_lex "$setup_call", $P253
.annotate 'line', 167
    find_lex $P255, "$name"
    defined $I256, $P255
    unless $I256, if_254_end
.annotate 'line', 168
    find_lex $P257, "$setup_call"
    get_hll_global $P258, ["PAST"], "Val"
    find_lex $P259, "$name"
    $P260 = $P258."new"($P259 :named("value"), "name" :named("named"))
    $P257."push"($P260)
  if_254_end:
.annotate 'line', 170
    find_lex $P262, "$repr"
    defined $I263, $P262
    unless $I263, if_261_end
.annotate 'line', 171
    find_lex $P264, "$setup_call"
    get_hll_global $P265, ["PAST"], "Val"
    find_lex $P266, "$repr"
    $P267 = $P265."new"($P266 :named("value"), "repr" :named("named"))
    $P264."push"($P267)
  if_261_end:
.annotate 'line', 173
    find_lex $P268, "self"
.annotate 'line', 174
    find_lex $P269, "self"
    find_lex $P270, "$slot"
    find_lex $P271, "self"
    find_lex $P272, "$setup_call"
    $P273 = $P271."set_cur_sc"($P272)
    $P274 = $P269."set_slot_past"($P270, $P273)
    $P268."add_event"($P274 :named("deserialize_past"))
.annotate 'line', 177
    new $P275, "Exception"
    set $P275['type'], .CONTROL_RETURN
    find_lex $P276, "$mo"
    setattribute $P275, 'payload', $P276
    throw $P275
.annotate 'line', 150
    .return ()
  control_210:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P277, exception, "payload"
    .return ($P277)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "pkg_add_method"  :subid("28_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_279
    .param pmc param_280
    .param pmc param_281
    .param pmc param_282
    .param pmc param_283
.annotate 'line', 183
    .lex "self", param_279
    .lex "$obj", param_280
    .lex "$meta_method_name", param_281
    .lex "$name", param_282
    .lex "$method_past", param_283
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "pkg_add_parent_or_role"  :subid("29_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_285
    .param pmc param_286
    .param pmc param_287
    .param pmc param_288
    .param pmc param_289
.annotate 'line', 189
    .lex "self", param_285
    .lex "$obj", param_286
    .lex "$meta_method_name", param_287
    .lex "$to_add", param_288
    .lex "$to_add_past", param_289
    .return ()
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "pkg_compose"  :subid("30_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_291
    .param pmc param_292
.annotate 'line', 193
    .lex "self", param_291
    .lex "$obj", param_292
.annotate 'line', 194
    new $P293, "Undef"
    .lex "$slot_past", $P293
    find_lex $P294, "$obj"
    $P295 = "get_slot_past_for_object"($P294)
    store_lex "$slot_past", $P295
.annotate 'line', 195
    find_lex $P296, "self"
    get_hll_global $P297, ["PAST"], "Op"
.annotate 'line', 197
    get_hll_global $P298, ["PAST"], "Op"
    find_lex $P299, "$slot_past"
    $P300 = $P298."new"($P299, "get_how PP" :named("pirop"))
    find_lex $P301, "$slot_past"
    $P302 = $P297."new"($P300, $P301, "callmethod" :named("pasttype"), "compose" :named("name"))
.annotate 'line', 195
    $P296."add_event"($P302 :named("deserialize_past"))
    find_lex $P303, "$obj"
.annotate 'line', 193
    .return ($P303)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "sc"  :subid("31_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_305
.annotate 'line', 204
    .lex "self", param_305
    find_lex $P306, "self"
    get_global $P307, "$?CLASS"
    getattribute $P308, $P306, $P307, "@!sc"
    unless_null $P308, vivify_60
    $P308 = root_new ['parrot';'ResizablePMCArray']
  vivify_60:
    .return ($P308)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.include "except_types.pasm"
.sub "to_past"  :subid("32_1299602523.815") :outer("15_1299602523.815")
    .param pmc param_310
.annotate 'line', 210
    .const 'Sub' $P324 = "33_1299602523.815" 
    capture_lex $P324
    .lex "self", param_310
.annotate 'line', 211
    new $P311, "Undef"
    .lex "$des", $P311
.annotate 'line', 212
    new $P312, "Undef"
    .lex "$fix", $P312
.annotate 'line', 211
    get_hll_global $P313, ["PAST"], "Stmts"
    $P314 = $P313."new"()
    store_lex "$des", $P314
.annotate 'line', 212
    get_hll_global $P315, ["PAST"], "Stmts"
    $P316 = $P315."new"()
    store_lex "$fix", $P316
.annotate 'line', 213
    find_lex $P318, "self"
    get_global $P319, "$?CLASS"
    getattribute $P320, $P318, $P319, "@!event_stream"
    unless_null $P320, vivify_61
    $P320 = root_new ['parrot';'ResizablePMCArray']
  vivify_61:
    defined $I321, $P320
    unless $I321, for_undef_62
    iter $P317, $P320
    new $P343, 'ExceptionHandler'
    set_label $P343, loop342_handler
    $P343."handle_types"(.CONTROL_LOOP_NEXT, .CONTROL_LOOP_REDO, .CONTROL_LOOP_LAST)
    push_eh $P343
  loop342_test:
    unless $P317, loop342_done
    shift $P322, $P317
  loop342_redo:
    .const 'Sub' $P324 = "33_1299602523.815" 
    capture_lex $P324
    $P324($P322)
  loop342_next:
    goto loop342_test
  loop342_handler:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P344, exception, 'type'
    eq $P344, .CONTROL_LOOP_NEXT, loop342_next
    eq $P344, .CONTROL_LOOP_REDO, loop342_redo
  loop342_done:
    pop_eh 
  for_undef_62:
.annotate 'line', 217
    find_dynamic_lex $P345, "$/"
    get_hll_global $P346, ["PAST"], "Op"
.annotate 'line', 219
    get_hll_global $P347, ["PAST"], "Op"
.annotate 'line', 221
    get_hll_global $P348, ["PAST"], "Op"
    find_lex $P349, "self"
    get_global $P350, "$?CLASS"
    getattribute $P351, $P349, $P350, "$!handle"
    unless_null $P351, vivify_63
    new $P351, "Undef"
  vivify_63:
    $P352 = $P348."new"($P351, "nqp_get_sc Ps" :named("pirop"))
    $P353 = $P347."new"($P352, "isnull IP" :named("pirop"))
.annotate 'line', 223
    get_hll_global $P354, ["PAST"], "Stmts"
.annotate 'line', 224
    get_hll_global $P355, ["PAST"], "Op"
    $P356 = $P355."new"("nqp_dynop_setup v" :named("pirop"))
.annotate 'line', 225
    get_hll_global $P357, ["PAST"], "Op"
    $P358 = $P357."new"("nqpmo.pbc", "load_bytecode vs" :named("pirop"))
.annotate 'line', 226
    get_hll_global $P359, ["PAST"], "Op"
.annotate 'line', 228
    get_hll_global $P360, ["PAST"], "Var"
    $P361 = $P360."new"("cur_sc" :named("name"), "register" :named("scope"), 1 :named("isdecl"))
.annotate 'line', 229
    get_hll_global $P362, ["PAST"], "Op"
    find_lex $P363, "self"
    get_global $P364, "$?CLASS"
    getattribute $P365, $P363, $P364, "$!handle"
    unless_null $P365, vivify_64
    new $P365, "Undef"
  vivify_64:
    $P366 = $P362."new"($P365, "nqp_create_sc Ps" :named("pirop"))
    $P367 = $P359."new"($P361, $P366, "bind" :named("pasttype"))
.annotate 'line', 226
    find_lex $P368, "$des"
    $P369 = $P354."new"($P356, $P358, $P367, $P368)
.annotate 'line', 223
    find_lex $P370, "$fix"
    $P371 = $P346."new"($P353, $P369, $P370, "if" :named("pasttype"))
.annotate 'line', 217
    $P372 = $P345."!make"($P371)
.annotate 'line', 210
    .return ($P372)
.end


.HLL "nqp"

.namespace ["HLL";"Compiler";"SerializationContextBuilder"]
.sub "_block323"  :anon :subid("33_1299602523.815") :outer("32_1299602523.815")
    .param pmc param_325
.annotate 'line', 213
    .lex "$_", param_325
.annotate 'line', 214
    find_lex $P327, "$_"
    $P328 = $P327."deserialize_past"()
    defined $I329, $P328
    unless $I329, if_326_end
    find_lex $P330, "$des"
    find_lex $P331, "$_"
    $P332 = $P331."deserialize_past"()
    $P330."push"($P332)
  if_326_end:
.annotate 'line', 215
    find_lex $P335, "$_"
    $P336 = $P335."fixup_past"()
    defined $I337, $P336
    if $I337, if_334
    new $P333, 'Integer'
    set $P333, $I337
    goto if_334_end
  if_334:
    find_lex $P338, "$fix"
    find_lex $P339, "$_"
    $P340 = $P339."fixup_past"()
    $P341 = $P338."push"($P340)
    set $P333, $P341
  if_334_end:
.annotate 'line', 213
    .return ($P333)
.end


.HLL "nqp"

.namespace []
.sub "_block422" :load :anon :subid("35_1299602523.815")
.annotate 'line', 1
    .const 'Sub' $P424 = "10_1299602523.815" 
    $P425 = $P424()
    .return ($P425)
.end


.sub '' :anon :load :init
    $P0 = get_hll_global ['HLL'], 'Compiler'
    $P0 = $P0.'new'()
    $P0.'language'('parrot')
.end

=back

=head1 AUTHOR

Patrick Michaud <pmichaud@pobox.com> is the author and maintainer.

=head1 COPYRIGHT

Copyright (C) 2009, The Perl Foundation.

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
