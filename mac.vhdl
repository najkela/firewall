LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mac_io IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        in_read_enable : OUT STD_LOGIC := '0';
        in_index : OUT INTEGER;
        in_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        out_write_enable : OUT STD_LOGIC := '0';
        out_index : OUT INTEGER;
        out_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        in_buff_size : OUT INTEGER := 1;
        mal : out std_logic := '0';
        out_buff_size : OUT INTEGER := 1
    );
END ENTITY mac_io;

ARCHITECTURE behavioural OF mac_io IS
    SIGNAL temp_data : STD_LOGIC_VECTOR (7 DOWNTO 0) := (others => '1');
    SIGNAL done_s : STD_LOGIC := '0';
    SIGNAL state_s : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    signal counter : integer range 0 to 12 := 0;
    signal mac : integer range 0 to 12 := 0;
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            in_read_enable <= '0';
            out_write_enable <= '0';
            done <= '0';
        ELSIF rising_edge(clk) THEN
            IF enable = '1' AND done_s = '0' AND state_s = "000" THEN
                in_read_enable <= '1';
                out_write_enable <= '0';
                in_index <= 0;
                state_s <= "001";
            ELSIF enable = '1' AND state_s = "001" THEN
                in_read_enable <= '0';
                out_index <= 0;
                state_s <= "010";
            ELSIF enable = '1' AND state_s = "010" THEN
                temp_data <= in_data;
                state_s <= "011";
              -- Ispravka: koristi in_data umesto temp_data
    if (in_data = "11111111" and mac < 12) then
        counter <= counter + 1;
    end if;

    if (mac < 12) then
        mac <= mac + 1;
    end if;

    -- Ispravljena logika za postavljanje mal
    if (mac = 11) then
        if (counter = 11) then
            mal <= '0';  -- svi bajtovi su sumnjivi
        else
            mal <= '0';  -- nije maliciozan
        end if;
    
                end if;

            ELSIF enable = '1' AND state_s = "011" THEN
                out_write_enable <= '1';
                out_data <= temp_data;

                state_s <= "100";
            ELSIF enable = '1' AND state_s = "100" THEN
                done <= '1';
                done_s <= '1';
                out_write_enable <= '0';
                state_s <= "000";
            ELSIF done_s = '1' THEN
                done <= '0';
                done_s <= '0';
            ELSE
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioural;