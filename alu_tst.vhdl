ENTITY alu_tst IS	
	generic( n: integer:=8);
END alu_tst;

ARCHITECTURE t OF alu_tst IS
  COMPONENT alu IS
    generic(tp: time := 5 ns; n: integer:=8);
    port(op1, op2: in bit_vector(n-1 downto 0);
    cin: in bit;
    result: out bit_vector(n-1 downto 0));
  END COMPONENT;
  signal op1_s, op2_s, result_s: bit_vector(7 downto 0);
  signal cin_s: bit:='0';
BEGIN
  
  eticheta1: alu  PORT MAP ( cin => cin_s, op1 => op1_s, op2 => op2_s, result => result_s);
	
	op1_s <= x"00" AFTER 0 ns,
	         x"01" AFTER 50 ns, 
	         x"04" AFTER 100 ns, 
	         x"01" AFTER 150 ns,
	         x"03" AFTER 200 ns;
	         
	op2_s <= x"00" AFTER 0 ns, 
	         x"03" AFTER 50 ns, 
	         x"02" AFTER 100 ns, 
	         x"04" AFTER 150 ns,
	         x"05" AFTER 200 ns;
	           
	           
	cin_s <= '0' AFTER 0 ns, 
	         '0' AFTER 50 ns, 
	         '1' AFTER 100 ns, 
	         '1' AFTER 150 ns;

  
  
  
END t;





