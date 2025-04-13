LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity project_io_tb is
end entity project_io_tb;

architecture test of project_io_tb is
    signal input_signal_tb : std_logic_vector(7 downto 0);
    signal mal_tb : std_logic := '0';

    CONSTANT CLK_PERIOD : TIME := 50 ms;
    SIGNAL clk_int : STD_LOGIC;
    SIGNAL rst_int : STD_LOGIC;
    signal en : STD_LOGIC := '1';

begin
    testiramo : entity work.project_io(behavioural)
    port map(
        clk => clk_int,
        rst => rst_int,
        enable => en,

        in_data => input_signal_tb,
        mal_ip => mal_tb
    );

    proba : process
    begin
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;

        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;

        input_signal_tb <= "00001000";
        wait for CLK_PERIOD;
        input_signal_tb <= "00000000";
        wait for CLK_PERIOD;

        wait;

    end process proba;

    nesto : process 
    begin
        wait for 1000 ns;
        report "kraj" severity failure;
    end process nesto;


end architecture test;