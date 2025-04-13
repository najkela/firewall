LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity ethernet is
    port(
        signal input_signal : in std_logic_vector(7 downto 0);
        signal clk : std_logic;
        signal mal : out std_logic := '0'
    );
    type byte_array_m is array (11 downto 0) of std_logic_vector(7 downto 0);
    type byte_array_ip is array (1 downto 0) of std_logic_vector(7 downto 0);

end entity ethernet;

architecture behavioural of ethernet is 

    signal index_signal : integer := 0;
    signal index_byte : integer := 0;
    signal flag : std_logic := '0';
    signal mac_flag : std_logic := '0';

    signal array_mac : byte_array_m;
    signal i_ip : byte_array_ip;
    signal priv_mal : std_logic := '1';
    signal i : integer :=0;
    signal i_pro :  std_logic_vector(7 downto 0);
    signal pro_flag : std_logic := '0';
    signal pro_1 : std_logic_vector(7 downto 0);
    signal pro_2 : std_logic_vector(7 downto 0);
    signal flag_1024 : std_logic := '0';
    signal pro_1024 : std_logic_vector(13 downto 0);
    begin
    pisanje : process
    begin 
        if index_signal = 0 then 
            array_mac <= array_mac(4 downto 0) & input_signal;
            index_byte <= index_byte + 1;
            if index_byte = 6 then
                index_signal <= 1;
            end if;
        elsif index_signal = 1 then
            array_mac <= array_mac(4 downto 0) & input_signal;
            index_byte <= index_byte + 1;
            if index_byte = 6 then
                index_byte <= 0;
                index_signal <= 2;
                mac_flag <= '1';
            end if;
        elsif index_signal = 2 then
            i_ip <= i_ip(0) & input_signal;
            index_byte <= index_byte + 1;
            if index_byte = 2 then
                index_byte <= 0;
                index_signal <= 3;
                flag <= '1';
            end if;
        elsif (index_signal = 3) then
            index_byte <= index_byte +1;
            if index_byte = 2  then
                pro_1 <= input_signal;
                if index_byte = 3 then
                pro_2 <= input_signal;
                index_byte <=0;
                index_signal  <= 4;
                flag_1024 <= '1';
                end if;
            end if;
            
        elsif index_signal = 4 then
            index_byte <= index_byte +1;
            if (index_byte = 7) then
            index_byte <= 0;
            i_pro <= input_signal; 
            index_signal <= 4;
            pro_flag <= '1'; 
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
    provera_mac : process(clk)
         begin   
        if (mac_flag ='1' )then
            while i<11 loop
                if (array_mac(i) /= "11111111") then
                priv_mal <= '0';
                end if;
                i <= i +1;
            
            end loop;
        end if;
        if (priv_mal = '1') then
            mal <= '1';
        end if;
    end process provera_mac;
    pro : process
    begin
        if (pro_flag = '1') then
            if not (i_pro = "00000110" or i_pro = "00010001") then
                mal <='1';
            end if;
        end if;
    end process pro;
    pro1024 : process
    begin 
        if (flag_1024 = '1') then
        pro_1024 <= pro_1 & pro_2;
        if (pro_1024 < "10000000000000000") then
            mal <= '1';
        end if;
        end if;
    end process pro1024;
end architecture behavioural;