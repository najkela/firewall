LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity ethernet is
    type byte_array_m is array (5 downto 0) of std_logic_vector(7 downto 0);
    type byte_array_ip is array (1 downto 0) of std_logic_vector(7 downto 0);

    port(
        signal i_destination_mac : in byte_array_m;
        signal i_source_mac : in byte_array_m;
        signal i_ip : in byte_array_ip;

        signal mal : out std_logic := '0';
    );
end entity ethernet;

architecture behavioural of ethernet is 

    transfer : entity work.project_io(behavioural);
    constant clk_period : time := 50 us;
    signal new_data : in std_logic_vector(7 downto 0);
    signal clk_ether : std_logic;
    signal rst_ether : std_logic;

    port map(
        new_data <= temp_data,
        clk_ether <= clk,
        rst_ether <= rst
    )

    clock : process 
    begin 
        clk_ether <= '0';
        WAIT FOR clk_period/2;
        clk_ether <= '1';
        WAIT FOR clk_period/2;
    end process clock;

    

end architecture behavioural;