library verilog;
use verilog.vl_types.all;
entity test_vlg_check_tst is
    port(
        decodeout0      : in     vl_logic_vector(6 downto 0);
        decodeout1      : in     vl_logic_vector(6 downto 0);
        decodeout2      : in     vl_logic_vector(6 downto 0);
        decodeout3      : in     vl_logic_vector(6 downto 0);
        decodeout4      : in     vl_logic_vector(6 downto 0);
        decodeout5      : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end test_vlg_check_tst;
