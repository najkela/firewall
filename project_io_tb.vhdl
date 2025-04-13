LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity project_io_tb is
end entity project_io_tb;

architecture test of project_io_tb is
    signal input_signal_tb : std_logic_vector(7 downto 0);
    signal destination_mac_tb : byte_array_m;
    signal source_mac_tb : byte_array_m;
    signal ip_tb : byte_array_ip;
    signal mal_tb : std_logic := '0';

begin
    testiramo : entity work.project_io_tb
    port map(
    input_signal => temp_data,
    mal => mal_ip
    );

    proba : process
    begin
        destination_mac_tb(0) <= '00000000';
        destination_mac_tb(1) <= '00000000';
        destination_mac_tb(2) <= '00000000';
        destination_mac_tb(3) <= '00000000';
        destination_mac_tb(4) <= '00000000';
        destination_mac_tb(5) <= '00000000';

        source_mac_tb(0) <= '00000000';
        source_mac_tb(1) <= '00000000';
        source_mac_tb(2) <= '00000000';
        source_mac_tb(3) <= '00000000';
        source_mac_tb(4) <= '00000000';
        source_mac_tb(5) <= '00000000';

        ip_tb(0) <= '00001000';
        ip_tb(1) <= '00000000';




    end process proba;


end architecture test;