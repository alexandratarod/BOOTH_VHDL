ENTITY booth IS	
	generic( n: integer:=8);
	PORT(
    clk, rst, bgn: in bit;
    inbus: in bit_vector(n-1 DOWNTO 0);
    stop: out bit;
    outbus: out bit_vector(n-1 downto 0)  
  );
END booth;

ARCHITECTURE booth_architecture OF booth IS

  COMPONENT alu IS
    generic(tp: time := 5 ns; n: integer:=8);
    port(op1, op2: in bit_vector(n-1 downto 0);
         cin: in bit;
         result: out bit_vector(n-1 downto 0));
  END COMPONENT;
  
  COMPONENT load_register_m IS
    generic(tp: time := 5 ns; n: integer := 8);
    port(
        data_in: in bit_vector(n-1 downto 0);
        load, clk, rst: in bit;                  
        data_out: out bit_vector(n-1 downto 0));
  END COMPONENT;
  
  COMPONENT shift_register_a_q IS
    generic(tp: time := 5 ns; n: integer := 8);
    port(
        data_in_a, data_in_q: in bit_vector(n-1 downto 0);
        load_a, load_q, shift, clk, rst: in bit;                  
        data_out: out bit_vector(2*n downto 0));
  END COMPONENT;
  
  COMPONENT control_unit IS
    generic(tp:TIME:=5ns; n: integer:=8);
    port(clk, rst, bgn, q_0, q_m1: in bit;
       c0, c1, c2, c3, c4, c5, c6, stop: out bit);
  END COMPONENT;


  signal m_reg_data, alu_result: bit_vector(n-1 downto 0);
  signal a_q_reg_data: bit_vector(2*n downto 0);
  signal c0_s, c1_s, c2_s, c3_s, c4_s, c5_s, c6_s, stop_s: bit; 
  
  
BEGIN
  
  alu_label: alu PORT MAP (
            op1 => a_q_reg_data(2*n downto n+1),
            op2 => m_reg_data,
            cin => c3_s,
            result => alu_result);

  m_reg_label: load_register_m PORT MAP (
            data_in => inbus,
            load => c0_s,  
            clk => clk,
            rst => rst,
            data_out => m_reg_data
        );
        
  a_q_reg_label: shift_register_a_q PORT MAP (
            data_in_a => alu_result,
            data_in_q => inbus,
            load_q => c1_s,  
            load_a => c2_s,  
            shift => c4_s,    
            clk => clk,
            rst => rst,
            data_out => a_q_reg_data
        );
        
  control_unit_label: control_unit PORT MAP (
            clk => clk,
            rst => rst,
            bgn => bgn,
            q_0 => a_q_reg_data(1),
            q_m1 => a_q_reg_data(0),      
            c0 => c0_s,
            c1 => c1_s,
            c2 => c2_s,
            c3 => c3_s,
            c4 => c4_s,
            c5 => c5_s,
            c6 => c6_s,
            stop => stop_s);
            
  stop <= stop_s;
  outbus <= x"00" when (c5_s = '0' and c6_s = '0') else
              a_q_reg_data(2*n downto n+1) when c5_s = '1' else
              a_q_reg_data(n downto 1) when c6_s = '1';
  
END;