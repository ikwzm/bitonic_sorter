library ieee;
use     ieee.std_logic_1164.all;
entity  Bitonic_Sorter_Wrapper is
    generic (
        WORDS     :  integer :=  8;
        WORD_BITS :  integer := 32;
        COMP_HIGH :  integer := 31;
        COMP_LOW  :  integer :=  0;
        INFO_BITS :  integer :=  4
    );
    port (
        CLK       :  in  std_logic;
        RST       :  in  std_logic;
        CLR       :  in  std_logic;
        I_SORT    :  in  std_logic;
        I_UP      :  in  std_logic;
        I_ADDR    :  in  integer range 0 to WORDS-1;
        I_DATA    :  in  std_logic_vector(WORD_BITS-1 downto 0);
        I_INFO    :  in  std_logic_vector(INFO_BITS-1 downto 0);
        O_ADDR    :  in  integer range 0 to WORDS-1;
        O_DATA    :  out std_logic_vector(WORD_BITS-1 downto 0);
        O_INFO    :  out std_logic_vector(INFO_BITS-1 downto 0)
    );
end Bitonic_Sorter_Wrapper;
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of Bitonic_Sorter_Wrapper is
    component Bitonic_Sorter
        generic (
            WORDS     :  integer :=  1;
            WORD_BITS :  integer := 64;
            COMP_HIGH :  integer := 64;
            COMP_LOW  :  integer := 32;
            INFO_BITS :  integer :=  4
        );
        port (
            CLK       :  in  std_logic;
            RST       :  in  std_logic;
            CLR       :  in  std_logic;
            I_SORT    :  in  std_logic;
            I_UP      :  in  std_logic;
            I_DATA    :  in  std_logic_vector(WORDS*WORD_BITS-1 downto 0);
            I_INFO    :  in  std_logic_vector(      INFO_BITS-1 downto 0);
            O_SORT    :  out std_logic;
            O_UP      :  out std_logic;
            O_DATA    :  out std_logic_vector(WORDS*WORD_BITS-1 downto 0);
            O_INFO    :  out std_logic_vector(      INFO_BITS-1 downto 0)
        );
    end component;
    signal  s_data    :  std_logic_vector(WORDS*WORD_BITS-1 downto 0);
    signal  q_data    :  std_logic_vector(WORDS*WORD_BITS-1 downto 0);
begin
    process(CLK, RST) begin
        if (RST = '1') then
                s_data <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                s_data <= (others => '0');
            else
                for i in 0 to WORDS-1 loop
                    if (I_ADDR = i) then
                        s_data(WORD_BITS*(i+1)-1 downto WORD_BITS*i) <= I_DATA;
                    end if;
                end loop;
            end if;
        end if;
    end process;
    U: Bitonic_Sorter
        generic map (
            WORDS     => WORDS     , -- 
            WORD_BITS => WORD_BITS , -- 
            COMP_HIGH => COMP_HIGH , -- 
            COMP_LOW  => COMP_LOW  , -- 
            INFO_BITS => INFO_BITS   -- 
        )
        port map (
            CLK       => CLK       , -- 
            RST       => RST       , -- 
            CLR       => CLR       , -- 
            I_SORT    => I_SORT    , -- 
            I_UP      => I_UP      , -- 
            I_DATA    => s_data    , -- 
            I_INFO    => I_INFO    , -- 
            O_SORT    => open      , -- 
            O_UP      => open      , -- 
            O_DATA    => q_data    , -- 
            O_INFO    => O_INFO      -- 
        );
    process(CLK, RST) begin
        if (RST = '1') then
                O_DATA <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                O_DATA <= (others => '0');
            else
                for i in 0 to WORDS-1 loop
                    if (O_ADDR = i) then
                        O_DATA <= q_data(WORD_BITS*(i+1)-1 downto WORD_BITS*i);
                    end if;
                end loop;
            end if;
        end if;
    end process;
end RTL;
