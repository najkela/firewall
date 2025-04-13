LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY mac_io_tb IS
END ENTITY;

ARCHITECTURE test OF mac_io_tb IS

    COMPONENT mac_io IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            in_read_enable : OUT STD_LOGIC;
            in_index : OUT INTEGER;
            in_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            out_write_enable : OUT STD_LOGIC;
            out_index : OUT INTEGER;
            out_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            in_buff_size : OUT INTEGER;
            mal : OUT STD_LOGIC;
            out_buff_size : OUT INTEGER
        );
    END COMPONENT;

    SIGNAL clk              : STD_LOGIC := '0';
    SIGNAL rst              : STD_LOGIC := '0';
    SIGNAL enable           : STD_LOGIC := '0';
    SIGNAL done             : STD_LOGIC;
    SIGNAL in_read_enable   : STD_LOGIC;
    SIGNAL in_index         : INTEGER := 0;
    SIGNAL in_data          : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL out_write_enable : STD_LOGIC;
    SIGNAL out_index        : INTEGER;
    SIGNAL out_data         : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL in_buff_size     : INTEGER;
    SIGNAL mal              : std_logic := '0';
    SIGNAL out_buff_size    : INTEGER;

    TYPE memory_array IS ARRAY (0 TO 11) OF STD_LOGIC_VECTOR(7 DOWNTO 0);

    CONSTANT normal_mac : memory_array := (
        X"12", X"34", X"56", X"78", X"9A", X"BC",
        X"00", X"11", X"22", X"33", X"44", X"55"
    );

    CONSTANT malicious_mac : memory_array := (OTHERS => X"FF");

    SIGNAL test_data : memory_array;
    SIGNAL test_index : INTEGER := 0;
    SIGNAL test_num : INTEGER := 0;

BEGIN

    uut : mac_io PORT MAP (
        clk => clk,
        rst => rst,
        enable => enable,
        done => done,
        in_read_enable => in_read_enable,
        in_index => in_index,
        in_data => in_data,
        out_write_enable => out_write_enable,
        out_index => out_index,
        out_data => out_data,
        in_buff_size => in_buff_size,
        mal => mal,
        out_buff_size => out_buff_size
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            clk <= '0';
            WAIT FOR 10 ns;
            clk <= '1';
            WAIT FOR 10 ns;
        END LOOP;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
        VARIABLE line_out : line;
    BEGIN
        -- Reset
        rst <= '1';
        WAIT FOR 40 ns;
        rst <= '0';

        -- First test: normal MAC
        test_data <= normal_mac;
        enable <= '1';

        WAIT UNTIL done = '1';
        write(line_out, STRING'("Test 1 (normal): MAL = "));
        IF mal <= '1' THEN
    write(line_out, STRING'("1"));
ELSE
    write(line_out, STRING'("0"));
END IF;
        writeline(output, line_out);
        ASSERT mal <= '0' REPORT "FAIL: Normal MAC marked as malicious!" SEVERITY ERROR;

        WAIT FOR 100 ns;

        -- Second test: malicious MAC
        test_data <= malicious_mac;
        enable <= '1';

        WAIT UNTIL done = '1';
        write(line_out, STRING'("Test 2 (malicious): MAL = "));
        IF mal <= '1' THEN
        write(line_out, STRING'("1"));
    ELSE
        write(line_out, STRING'("0"));
    END IF;
        writeline(output, line_out);
        ASSERT mal <= '1' REPORT "FAIL: Malicious MAC not detected!" SEVERITY ERROR;

        -- End simulation
        WAIT FOR 100 ns;
        REPORT "SIMULATION COMPLETED" SEVERITY FAILURE;
    END PROCESS;

    -- Provide input data when requested
    ram_reader : PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF enable = '1' AND in_read_enable = '1' THEN
                in_data <= test_data(in_index);
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;

