ENTITY shift_register IS
  generic(tp: time := 5 ns; n: integer := 8);
  port(
      data_in: in bit_vector(n-1 downto 0);
      load, shift, clk: in bit;                  
      data_out: out bit_vector(n-1 downto 0) 
  );
END shift_register;

ARCHITECTURE shift_register_architecture OF shift_register IS
  signal register_content: bit_vector(n-1 downto 0); 
BEGIN
  PROCESS(clk)
  BEGIN
    if clk = '1' then  
      if load = '1' then --sa vedem daca avem nevoie de load!!!! - scopul ar fi shiftarea valorii din registru
        register_content <= data_in;
      elsif shift = '1' then
        -- deplasare aritmetica la dreapta
        register_content <= register_content(n-1) & register_content(n-1 downto 1);
      end if;
    end if;
  END PROCESS;
  
  data_out <= register_content;

END shift_register_architecture;
