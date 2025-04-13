LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity project_io_tb is
    type byte_array_m is array (5 downto 0) of std_logic_vector(7 downto 0);
    type byte_array_ip is array (1 downto 0) of std_logic_vector(7 downto 0);
end entity project_io_tb;

architecture test of project_io_tb is
    signal input_signal_tb : std_logic_vector(7 downto 0);
    signal destination_mac_tb : byte_array_m;
    signal source_mac_tb : byte_array_m;
    signal ip_tb : byte_array_ip;
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

    clock : PROCESS
    BEGIN
        clk_int <= '0';
        WAIT FOR CLK_PERIOD/2;
        clk_int <= '1';
        WAIT FOR CLK_PERIOD/2;
    END PROCESS clock;

    proba : process
    begin
        destination_mac_tb(0) <= "00000000";
        destination_mac_tb(1) <= "00000000";
        destination_mac_tb(2) <= "00000000";
        destination_mac_tb(3) <= "00000000";
        destination_mac_tb(4) <= "00000000";
        destination_mac_tb(5) <= "00000000";

        source_mac_tb(0) <= "00000000";
        source_mac_tb(1) <= "00000000";
        source_mac_tb(2) <= "00000000";
        source_mac_tb(3) <= "00000000";
        source_mac_tb(4) <= "00000000";
        source_mac_tb(5) <= "00000000";

        ip_tb(0) <= "00001000";
        ip_tb(1) <= "00000000";

    end process proba;


end architecture test;