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

    signal input_signal : in std_logic_vector(7 downto 0);
    signal index_signal : integer := 0;
    signal index_byte : integer := 0;
    signal flag : std_logic := '0';

    pisanje : process
    begin 
        if index_signal = 0 then 
            i_destination_mac <= i_destination_mac(4 downto 0) & input_signal;
            index_byte <= index_byte + 1;
            if index_byte = 6 then
                index_byte <= 0;
                index_signal <= 1;
            end if;
        elsif index_signal = 1 then
            i_source_mac <= i_source_mac(4 downto 0) & input_signal;
            index_byte <= index_byte + 1;
            if index_byte = 6 then
                index_byte <= 0;
                index_signal <= 2;
            end if;
        elsif index_signal = 2 then
            i_ip <= i_ip(0) & input_signal;
            index_byte <= index_byte + 1;
            if index_byte = 2 then
                index_byte <= 0;
                index_signal <= 3;
                flag <= '1';
            end if;
        end if;
    end process pisanje;

    provera_ip : process
    begin
        if flag = '1' then
            if not (i_ip(0) = "00001000" and i_ip(1) = "00000000") then
                mal <= '1';
            end if;
        end if;
    end process provera_ip;

end architecture behavioural;