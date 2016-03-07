clear
clc

base_bigd = java.math.BigDecimal('4712947136781656124127497958710790561');
power_bigd = java.math.BigDecimal('4712947136781656124127599157917451764979');
modulus_bigd = java.math.BigDecimal('471294713678165124761561241274979');


res_bigd = javaFastPowerMod(base_bigd, power_bigd, modulus_bigd)





