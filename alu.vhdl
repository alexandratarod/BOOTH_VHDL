ENTITY alu IS  
  generic(tp: time := 5 ns; n: integer:=8);
  port(op1, op2: in bit_vector(n-1 downto 0);
  cin: in bit;
  result: out bit_vector(n-1 downto 0));
END ALU;

ARCHITECTURE alu_architecture OF alu IS
BEGIN
  PROCESS(op1, op2, cin)
    variable carry_temp: bit;
		variable res: bit_vector(op1'high downto op1'low);
	BEGIN
		carry_temp:= cin;
		for i in op1'low to op1'high loop
		  if cin = '0' then --ADD
			   res(i):= op1(i) xor op2(i) xor carry_temp;
			   carry_temp:= (op1(i) and op2(i)) or (op1(i) and carry_temp) or (op2(i) and carry_temp);
			elsif cin = '1' then --SUB
			   res(i):= op1(i) xor (not op2(i)) xor carry_temp;
			   carry_temp:= (op1(i) and (not op2(i))) or (op1(i) and carry_temp) or ((not op2(i)) and carry_temp);
			end if;	
		end loop;
		
		result <= res;
			
  END PROCESS;
  
END;
