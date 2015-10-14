=begin
%%{
  machine simple_lexer;

  integer     = ('+'|'-')?[0-9]+;
  float       = ('+'|'-')?[0-9]+'.'[0-9]+;
  assignment  = '=';
  identifier  = [a-zA-Z][a-zA-Z_]*;
  invalid     = any+;

  main := |*

    integer => {
      emit(:integer_literal, data, token_array, ts, te)
    };

    float => {
      emit(:float_literal, data, token_array, ts, te)
    };

    assignment => {
      emit(:assignment_operator, data, token_array, ts, te)
    };

    identifier => {
      emit(:identifier, data, token_array, ts, te)
    };

    space;

  *|;
}%%
=end

%% write data;

def emit(token_name, data, target_array, ts, te)
  target_array << {:name => token_name.to_sym, :value => data[ts...te].pack("c*") }
end

def run_lexer(data)
  data = data.unpack("c*") if(data.is_a?(String))
  eof = data.length
  token_array = []

  %% write init;
  %% write exec;

  puts token_array.inspect
end

run_lexer("a = 1 b = 2 c = 100.1")
