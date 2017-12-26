library ieee;
use ieee.std_logic_1164.all;

entity top_level is
  port( clk                 : in std_logic;
        reset               : in std_logic;
        D_out               : in  std_logic; -- ADC
        CS_ADC             : out std_logic; -- ADC
        SCK_ADC             : out std_logic; -- ADC
        D_in                : out std_logic; -- ADC
        SDI                 : out std_logic; -- DAC
        SCK_DAC             : out std_logic; -- DAC
        LDAC               : out std_logic; -- DAC
        CS_DAC             : out std_logic); --DAC
end entity;


architecture arch of top_level is

  signal ADC2DAC_data : std_logic_vector(11 downto 0);
  signal  start : std_logic;
  signal  sample_clk : std_logic;


  component clk_enable is
    port( clk         : in std_logic;
          reset       : in std_logic;
          sample_clk  : out std_logic);
  end component clk_enable;
  
  component DAC_controller is 
    port( clk             : in  std_logic;
          start           : in  std_logic;
          data            : in  std_logic_vector(11 downto 0);
          reset           : in  std_logic;
          finished        : out std_logic;
          CS             : out std_logic;
          SDI             : out std_logic;
          SCK            : out std_logic; 
          LDAC           : out std_logic);
  end component DAC_controller;
  
  component ADC_controller is
  port( clk         : in std_logic;
        start       : in std_logic;
        reset       : in std_logic;
        D_out       : in std_logic;
        finished    : out std_logic;
        CSn         : out std_logic;
        SCL         : out std_logic;
        D_in        : out std_logic;
        data        : out std_logic_vector(11 downto 0));  
  end component ADC_controller;

  begin
    
    clk_enable_comp:  component clk_enable
                      port map( clk => clk,
                                reset => reset,
                                sample_clk => start);
                                
    ADC_controller_comp:  component ADC_controller
                          port map( clk => clk,
                                    start => start,
                                    reset => reset,
                                    D_out => D_out, 
                                  --  finished => finished  -- Same as in the DAC
                                    CSn => CS_ADC,
                                    SCL => SCK_ADC,
                                    D_in => D_in,
                                    data => ADC2DAC_data);
                                
    DAC_controller_comp:  component DAC_controller
                          port map( clk => clk,
                                    start => start, 
                                    data => ADC2DAC_data, 
                                    reset => reset,
                                   -- finished => '0';    -- How do I connect this signal that just of importance to the controller?
                                    CS => CS_DAC,
                                    SDI => SDI,    
                                    SCK => SCK_DAC,     
                                    LDAC => LDAC);
end arch;