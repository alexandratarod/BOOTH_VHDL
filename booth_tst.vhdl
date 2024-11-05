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
    wait for 100 ns;
    clk_s <= '1'; 
    wait for 100 ns;
  END PROCESS;


  rst_s <= '0', '1' AFTER 25 ns, '0' AFTER 5500 ns, '1' AFTER 5525 ns, '0' AFTER 10300 ns, '1' AFTER 10325 ns;
  inbus <= "01000101" AFTER 125 ns, "11010011" AFTER 325 ns, "00000011" AFTER 5720 ns, "00000010" AFTER 5925 ns, "00100101" AFTER 10500 ns, "11010011" AFTER 10725 ns;
  bgn_s <='1', '0' AFTER 10725 ns;
    

END testbench;

