#!/usr/bin/ruby

class Lexer
   class LexError < StandardError; end

   EOB_ACT_CONTINUE_SCAN = 0
   EOB_ACT_END_OF_FILE = 1
   EOB_ACT_LAST_MATCH = 2
   YY_BUFFER_NEW = 0
   YY_BUFFER_NORMAL = 1
   YY_BUFFER_EOF_PENDING = 2
   YY_NUM_RULES = 12
   YY_END_OF_BUFFER = 13
   YY_ACCEPT = [
        0,
        0,    0,   13,   11,    1,    1,    4,    5,    6,    9,
        8,   11,   10,    3,    2,    7,    3,    2,    0
   ]
   YY_EC = [
        0,
        1,    1,    1,    1,    1,    1,    1,    1,    2,    3,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    2,    1,    1,    1,    1,    1,    1,    1,    4,
        5,    1,    1,    6,    7,    8,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    9,   10,
        1,    1,   11,    1,   12,   12,   12,   12,   12,   12,
       12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
       12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
        1,    1,    1,    1,    1,    1,   13,   13,   13,   13,

       13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
       13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
       13,   13,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1
   ]
   YY_META = [
        0,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1
   ]
   YY_BASE = [
        0,
        0,    0,   19,   20,   20,   20,   20,   20,   20,   20,
       20,   11,   20,    5,    3,   20,    3,    1,   20
   ]
   YY_DEF = [
        0,
       19,    1,   19,   19,   19,   19,   19,   19,   19,   19,
       19,   19,   19,   19,   19,   19,   19,   19,    0
   ]
   YY_NXT = [
        0,
        4,    5,    6,    7,    8,    9,    4,   10,   11,   12,
       13,   14,   15,   18,   17,   18,   17,   16,   19,    3,
       19,   19,   19,   19,   19,   19,   19,   19,   19,   19,
       19,   19,   19
   ]
   YY_CHK = [
        0,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,   18,   17,   15,   14,   12,    3,   19,
       19,   19,   19,   19,   19,   19,   19,   19,   19,   19,
       19,   19,   19
   ]
   YY_MORE_ADJ = 0
   INITIAL = 0
attr_accessor :error
   SMALL_STR = 258
   BIG_STR = 259
   ENTER_S = 260
   END_S = 261
   ZAP = 262
   RULE_NEXT = 263
   DOT_ZAP = 264
   DOT = 265
   QUESTION = 266
   YY_READ_BUF_SIZE = 8192
   @@yy_init = true
   @@yy_start = 1
   @@yyout = @@yyerr = nil
   attr_reader  :yylineno
   def initialize
      @yy_c_buf_p = 0
      @yy_did_buffer_switch_on_eof = false
      @yyfilename = nil
      @yy_lp = 0
   end
   def yylex(parser=nil)
      @yyparser = parser
      yy_current_state = yy_cp = yy_bp = yy_act = 0
      yy_full_match = 0
      if @@yy_init == true
         @@yy_init = false
         @@yyout = $stdout if @@yyout == nil
         @@yyerr = $stderr if @@yyerr == nil
         @@yybase = @@yynext = 0
         YY_BASE.each { |i| @@yybase = i if i > @@yybase }
         YY_NXT.each { |i| @@yynext = i if i > @@yynext }
         yy_create_buffer()
         @yylineno = 1
         @yyleng = 0
      end
      @yyin = $stdin if @yyin == nil
      state = :START
      loop do
         case state
            when :START
               yy_cp = @yy_c_buf_p
               @yy_ch_buf[yy_cp] = @yy_hold_char
               yy_bp = yy_cp
               state = :YY_MATCH
               yy_current_state = @@yy_start
               next
            when :YY_MATCH
               loop do
                  yy_c = YY_EC[ @yy_ch_buf[yy_cp] ]
                  if YY_ACCEPT[yy_current_state] != 0
                     @yy_last_accepting_state = yy_current_state
                     @yy_last_accepting_cpos = yy_cp
                  end
                  while YY_CHK[ YY_BASE[yy_current_state] + yy_c] != yy_current_state
                     yy_current_state = YY_DEF[yy_current_state]
                     yy_c = YY_META[yy_c] if yy_current_state > @@yynext
                  end
                  yy_current_state = YY_NXT[ YY_BASE[yy_current_state] + yy_c]
                  yy_cp += 1
                  break if YY_BASE[yy_current_state] == @@yybase
               end
               state = :YY_FIND_ACTION
               next
            when :YY_FIND_ACTION
               yy_act = YY_ACCEPT[yy_current_state]
               if yy_act == 0
                  yy_cp = @yy_last_accepting_cpos
                  yy_current_state = @yy_last_accepting_state
                  yy_act = YY_ACCEPT[yy_current_state]
               end
               state = :YY_FIND_ACTION_END
               next
            when :YY_FIND_ACTION_END
               @yytext = yy_bp
               @yyleng = yy_cp - yy_bp
               @yy_hold_char = @yy_ch_buf[yy_cp]
               if yy_cp == @yy_ch_buf.length
                  @yy_ch_buf += " "
               else
                  @yy_ch_buf[yy_cp] = " "
               end
               @yy_c_buf_p = yy_cp
               state = :DO_ACTION
               next
            when :DO_ACTION
               case yy_act
                  when 0
                     @yy_ch_buf[yy_cp] = @yy_hold_char
                     yy_cp = @yy_last_accepting_cpos
                     yy_current_state = @yy_last_accepting_state
                     state = :YY_FIND_ACTION
                     next
                  when 1
                  when 2
                     return SMALL_STR, yytext
                  when 3
                     return BIG_STR, yytext
                  when 4
                     return ENTER_S, yytext
                  when 5
                     return END_S, yytext
                  when 6
                     return ZAP, yytext
                  when 7
                     return RULE_NEXT,yytext
                  when 8
                     return DOT_ZAP, yytext
                  when 9
                     return DOT, yytext
                  when 10
                     return QUESTION, yytext
                  when 11
                     @error="Wrong Symbol"
                  when 12
                     # @@yyout.printf "%-*.*s", @yyleng, @yyleng, @yy_ch_buf[@yytext..-1]
                     state = :START
                     next
                  when YY_END_OF_BUFFER + INITIAL + 1
 # sidorovis changes: returning -1 on EOF
                     return [-1, nil]
                  when YY_END_OF_BUFFER
                     yy_amount_of_matched_text = (yy_cp - @yytext) - 1
                     @yy_ch_buf[yy_cp] = @yy_hold_char
                     @yy_buffer_status = YY_BUFFER_NORMAL if @yy_buffer_status == YY_BUFFER_NEW
                     if @yy_c_buf_p <= @yy_n_chars
                        @yy_c_buf_p = @yytext + yy_amount_of_matched_text
                        yy_current_state = yy_get_previous_state()
                        yy_next_state = yy_try_NUL_trans(yy_current_state)
                        yy_bp = @yytext + YY_MORE_ADJ 
                        if @yy_next_state != 0
                           @yy_c_buf_p += 1
                           yy_cp = @yy_c_buf_p
                           yy_current_state = yy_next_state
                           state = :YY_MATCH
                           next
                        else
                           yy_cp = @yy_c_buf_p
                           state = :YY_FIND_ACTION
                           next
                        end
                     else
                        case yy_get_next_buffer()
                           when EOB_ACT_END_OF_FILE
                              @yy_did_buffer_switch_on_eof = false
                              if yywrap() != 0
                                 @yy_c_buf_p = @yytext + YY_MORE_ADJ
                                 yy_act = YY_END_OF_BUFFER + ((@@yy_start - 1) / 2) + 1
                                 state = :DO_ACTION
                                 next
                              else
                                 yyrestart() if @yy_did_buffer_switch_on_eof == false
                                 state = :START
                                 next
                              end
                           when EOB_ACT_CONTINUE_SCAN
                              @yy_c_buf_p = @yytext + yy_amount_of_matched_text
                              yy_current_state = yy_get_previous_state()
                              yy_cp = @yy_c_buf_p
                              yy_bp = @yytext + YY_MORE_ADJ
                              state = :YY_MATCH
                              next
                           when EOB_ACT_LAST_MATCH
                              @yy_c_buf_p = @yy_n_chars
                              yy_current_state = yy_get_previous_state()
                              yy_cp = @yy_c_buf_p
                              yy_bp = @yytext + YY_MORE_ADJ
                              state = :YY_FIND_ACTION
                              next
                           else
                              state = :START
                              next
                        end
                     end
                  else
                     yyerror("fatal internal error -- no action found")
                     exit 2
               end # case yy_act
         end # case state
         state = :START
      end # loop
   end # yylex
   private
   def yy_get_next_buffer
      if @yy_fill_buffer == 0
         return EOB_ACT_END_OF_FILE if @yy_c_buf_p - @yytext - YY_MORE_ADJ == 1
         return EOB_ACT_LAST_MATCH
      end
      number_to_move = @yy_c_buf_p - @yytext - 1
      for i in 0..number_to_move do
         @yy_ch_buf[i] = @yy_ch_buf[@yytext + i]
      end
      if @yy_buffer_status == YY_BUFFER_EOF_PENDING
         @yy_n_chars = 0
      else
         num_to_read = @yy_buf_size - number_to_move - 1
         num_to_read = YY_READ_BUF_SIZE if num_to_read > YY_READ_BUF_SIZE
         case @yyin.class.to_s
            when "File"
               input = @yyin.read(num_to_read)
            when "String"
 # sidorovis: correcly working with a strings
               input, @yyin = @yyin, ""
            when "Array"
               input, @yyin = @yyin.to_s, ""
         end
         if input == nil
            @yy_n_chars = 0
         else
            @yy_n_chars = input.length
            @yy_ch_buf[number_to_move..-1] = input + "  "
         end
      end
      if @yy_n_chars == 0
         if number_to_move == YY_MORE_ADJ
            ret_val = EOB_ACT_END_OF_FILE
            yyrestart()
         else
            ret_val = EOB_ACT_LAST_MATCH
            @yy_buffer_status = YY_BUFFER_EOF_PENDING
         end
      else
         ret_val = EOB_ACT_CONTINUE_SCAN
      end
      @yy_n_chars += number_to_move
      @yy_ch_buf[@yy_n_chars] = " "
      @yy_ch_buf[@yy_n_chars + 1] = " "
      @yytext = 0
      ret_val
   end
   def yy_get_previous_state
      yy_cp = 0
      yy_current_state = @@yy_start
      b = @yytext + YY_MORE_ADJ
      e = @yy_c_buf_p
      for yy_cp in b...e do
         yy_c = (@yy_ch_buf[yy_cp] != " ") ? YY_EC[ @yy_ch_buf[yy_cp] ] : 1
         if YY_ACCEPT[yy_current_state] != 0
             @yy_last_accepting_state = yy_current_state
             @yy_last_accepting_cpos = yy_cp
         end
         while YY_CHK[YY_BASE[yy_current_state] + yy_c] != yy_current_state
            yy_current_state = YY_DEF[yy_current_state]
            yy_c = YY_META[yy_c] if yy_current_state > @@yynext
         end
         yy_current_state = YY_NXT[YY_BASE[yy_current_state] + yy_c]
      end
      yy_current_state
   end
   def yy_try_NUL_trans(yy_current_state)
      yy_is_jam = 0
      yy_cp = @yy_c_buf_p
      yy_c = 1
      if YY_ACCEPT[yy_current_state] != 0
         @yy_last_accepting_state = yy_current_state
         @yy_last_accepting_cpos = yy_cp
      end
      while YY_CHK[YY_BASE[yy_current_state] + yy_c] != yy_current_state
         yy_current_state = YY_DEF[yy_current_state]
         yy_c = YY_META[yy_c] if yy_current_state > @@yynext
      end
      yy_current_state = YY_NXT[YY_BASE[yy_current_state] + yy_c]
      yy_is_jam = (yy_current_state == @@yynext) ? 1 : 0
      (yy_is_jam != 0) ? 0 : yy_current_state
   end
   def unput(c)
      yy_unput(c, @yytext)
   end
   alias yyunput unput
   def yy_unput(c, yy_bp)
      src = dest = 0
      yy_cp = @yy_c_buf_p
      @yy_ch_buf[yy_cp] = @yy_hold_char
      if yy_cp < 2
         number_to_move = @yy_n_chars + 2
         dest = @yy_buf_size + 2
         src = number_to_move
         while src > 0
            dest -= 1
            src -= 1
            @yy_ch_buf[dest] = @yy_ch_buf[src]
         end
         yy_cp += (dest - src)
         yy_bp += (dest - src)
         @yy_n_chars = @yy_buf_size
         if yy_cp < 2
            yyerror("flex scanner push-back overflow")
            exit 2
         end
      end
      yy_cp -= 1
      @yy_ch_buf[yy_cp] = c
      @yytext = yy_bp
      @yy_hold_char = @yy_ch_buf[yy_cp]
      @yy_c_buf_p = yy_cp
   end
   def yy_input(cnt, pos, nor)
      c = 0
      @yy_ch_buf[@yy_c_buf_p] = @yy_hold_char
      if @yy_ch_buf[@yy_c_buf_p] == 0
         if @yy_c_buf_p < @yy_n_chars
            @yy_ch_buf[@yy_c_buf_p] = " "
         else
            offset = @yy_c_buf_p - @yytext
            @yy_c_buf_p += 1
            act = yy_get_next_buffer()
            loop do
               case act
                  when EOB_ACT_LAST_MATCH
                     yyrestart()
                     act = EOB_ACT_END_OF_FILE
                  when EOB_ACT_END_OF_FILE
                     return EOF if yywrap() != 0
                     yyrestart() if @yy_did_buffer_switch_on_eof == true
                     return yy_input()
                  when EOB_ACT_CONTINUE_SCAN
                     @yy_c_buf_p = @yytext + offset
                     break
               end
            end
         end
      end
      c = @yy_ch_buf[@yy_c_buf_p]
      @yy_ch_buf[@yy_c_buf_p] = " "
      @yy_c_buf_p += 1
      @yy_hold_char = @yy_ch_buf[@yy_c_buf_p]
      @yy_at_bol = 1 if c == 10
      c
   end
   def yyrestart
      yy_init_buffer()
      yy_load_buffer_state()
   end
   def yy_load_buffer_state
      @yy_c_buf_p = @yy_ch_buf_pos
      @yytext = @yy_c_buf_p
      @yy_hold_char = @yy_ch_buf[@yy_c_buf_p]
   end
   def yy_create_buffer
      @yy_ch_buf = ""
      @yy_buf_size = 16384
      yy_init_buffer()
      @yy_last_accepting_state = 0
      @yy_last_accepting_cpos = 0
   end
   def yy_init_buffer
      yy_flush_buffer()
      @yy_fill_buffer = 1
   end
   def yy_flush_buffer
      @yy_n_chars = 0
      @yy_ch_buf = " "
      @yy_ch_buf += " "
      @yy_ch_buf_pos = 0
      @yy_at_bol = 1
      @yy_buffer_status = YY_BUFFER_NEW
      yy_load_buffer_state()
   end
   def yytext
      a = @yytext
      e = @yytext + @yyleng
      e -= 1 if @yy_ch_buf[e..e] <= ""
      @yy_ch_buf[a..e]
   end
   def yyin=(val)
      @yyin = val
   end
   def yyout=(val)
      @@yyout = val
   end
   def yyerr=(val)
      @@yyerr = val
   end
   def yyerror(mess)
      if @yyin.class == File && @yyfilename != nil
         @@yyerr.print "`#{@yyfilename}' "
      else
         @@yyerr.print "`#{@yyin.class}' "
      end
      @@yyerr.print "line #{@yylineno}: #{mess}"
      m = @yy_ch_buf[@yytext..-1]
      m = $1 if m =~ /(.+)\n/o
      @@yyerr.print ", near `#{m}'" if @yy_ch_buf.length > @yytext
      @@yyerr.puts
   end
   def yywrap
      1
   end
   def filename
      @yyfilename
   end
   def filename=(val)
      @yyfilename = val
   end
   public   :yytext, :yyin=, :yyout=, :yyerr=, :yyerror, :yywrap,
            :filename, :filename=
end # class lexer


