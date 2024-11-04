ENTITY booth_tb IS
END booth_tb;

ARCHITECTURE testbench OF booth_tb IS

    COMPONENT booth IS
        generic(n: integer := 8);
        PORT(
            clk, rst, bgn: in bit;
            inbus: in bit_vector(n-1 downto 0);
            stop: out bit;
            outbus: out bit_vector(n-1 downto 0)
        );
    END COMPONENT;

    signal clk_s, rst_s, bgn_s: bit;
    signal inbus: bit_vector(7 downto 0) := (others => '0');
    signal stop: bit;
    signal outbus: bit_vector(7 downto 0);


BEGIN

   
    booth_label: booth PORT MAP (
        clk => clk_s,
        rst => rst_s,
        bgn => bgn_s,
        inbus => inbus,
        stop => stop,
        outbus => outbus
    );

    
  PROCESS
  BEGIN
    clk_s <= '0'; 
    wait for 50 ns;
    clk_s <= '1'; 
    wait for 50 ns;
  END PROCESS;


  rst_s <= '0', '1' AFTER 50 ns;
  inbus <= "01000101", "11010011" AFTER 150 ns;
  bgn_s <='1';
    

END testbench;

