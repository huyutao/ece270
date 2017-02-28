-- VHDL netlist-file
library mach;
use mach.components.all;

library ieee;
use ieee.std_logic_1164.all;
entity isp4256ZEio is
  port (
    DIP0 : in std_logic;
    DIP1 : in std_logic;
    DIP2 : in std_logic;
    DIP3 : in std_logic;
    DIP4 : in std_logic;
    DIP5 : in std_logic;
    DIP6 : in std_logic;
    DIP7 : in std_logic;
    S1_NC : in std_logic;
    S1_NO : in std_logic;
    S2_NC : in std_logic;
    S2_NO : in std_logic;
    LED0 : out std_logic;
    LED1 : out std_logic;
    LED2 : out std_logic;
    LED3 : out std_logic;
    LED4 : out std_logic;
    LED5 : out std_logic;
    LED6 : out std_logic;
    LED7 : out std_logic;
    LED8 : out std_logic;
    LED9 : out std_logic;
    LED10 : out std_logic;
    LED11 : out std_logic;
    LED12 : out std_logic;
    LED13 : out std_logic;
    LED14 : out std_logic;
    LED15 : out std_logic;
    DIS1a : out std_logic;
    DIS1b : out std_logic;
    DIS1c : out std_logic;
    DIS1d : out std_logic;
    DIS1e : out std_logic;
    DIS1f : out std_logic;
    DIS1g : out std_logic;
    DIS2a : out std_logic;
    DIS2b : out std_logic;
    DIS2c : out std_logic;
    DIS2d : out std_logic;
    DIS2e : out std_logic;
    DIS2f : out std_logic;
    DIS2g : out std_logic;
    DIS3a : out std_logic;
    DIS3b : out std_logic;
    DIS3c : out std_logic;
    DIS3d : out std_logic;
    DIS3e : out std_logic;
    DIS3f : out std_logic;
    DIS3g : out std_logic;
    DIS4a : out std_logic;
    DIS4b : out std_logic;
    DIS4c : out std_logic;
    DIS4d : out std_logic;
    DIS4e : out std_logic;
    DIS4f : out std_logic;
    DIS4g : out std_logic;
    LED16 : out std_logic;
    LED17 : out std_logic;
    LED18 : out std_logic;
    LED19 : in std_logic;
    LED20 : in std_logic;
    LED21 : in std_logic;
    LED22 : in std_logic;
    LED23 : in std_logic;
    LED24 : in std_logic;
    LED25 : in std_logic;
    LED26 : in std_logic;
    LED27 : in std_logic;
    LED28 : in std_logic;
    LED29 : in std_logic;
    X0 : out std_logic;
    X1 : out std_logic;
    X2 : out std_logic;
    X3 : out std_logic;
    X4 : out std_logic;
    X5 : out std_logic;
    X6 : out std_logic;
    X7 : out std_logic;
    Y0 : out std_logic;
    Y1 : out std_logic;
    Y2 : out std_logic;
    Y3 : out std_logic;
    Y4 : out std_logic;
    Y5 : out std_logic;
    Y6 : out std_logic;
    Y7 : out std_logic;
    S1 : out std_logic;
    Q3 : out std_logic;
    Q2 : out std_logic;
    Q1 : out std_logic;
    Q0 : out std_logic;
    P3 : out std_logic;
    P2 : out std_logic;
    P1 : out std_logic;
    P0 : out std_logic;
    L16 : out std_logic
  );
end isp4256ZEio;

architecture NetList of isp4256ZEio is

  signal DIP0PIN : std_logic;
  signal DIP1PIN : std_logic;
  signal DIP2PIN : std_logic;
  signal DIP3PIN : std_logic;
  signal DIP4PIN : std_logic;
  signal DIP5PIN : std_logic;
  signal DIP6PIN : std_logic;
  signal DIP7PIN : std_logic;
  signal S1_NCPIN : std_logic;
  signal S1_NOPIN : std_logic;
  signal S2_NCPIN : std_logic;
  signal S2_NOPIN : std_logic;
  signal LED0COM : std_logic;
  signal LED1COM : std_logic;
  signal LED2COM : std_logic;
  signal LED3COM : std_logic;
  signal LED4COM : std_logic;
  signal LED5COM : std_logic;
  signal LED6COM : std_logic;
  signal LED7COM : std_logic;
  signal LED8COM : std_logic;
  signal LED9COM : std_logic;
  signal LED10COM : std_logic;
  signal LED11COM : std_logic;
  signal LED12COM : std_logic;
  signal LED13COM : std_logic;
  signal LED14COM : std_logic;
  signal LED15COM : std_logic;
  signal DIS1aCOM : std_logic;
  signal DIS1bCOM : std_logic;
  signal DIS1cCOM : std_logic;
  signal DIS1dCOM : std_logic;
  signal DIS1eCOM : std_logic;
  signal DIS1fCOM : std_logic;
  signal DIS1gCOM : std_logic;
  signal DIS2aQ : std_logic;
  signal DIS2bQ : std_logic;
  signal DIS2cQ : std_logic;
  signal DIS2dQ : std_logic;
  signal DIS2eQ : std_logic;
  signal DIS2fQ : std_logic;
  signal DIS2gQ : std_logic;
  signal DIS3aQ : std_logic;
  signal DIS3bQ : std_logic;
  signal DIS3cQ : std_logic;
  signal DIS3dQ : std_logic;
  signal DIS3eQ : std_logic;
  signal DIS3fQ : std_logic;
  signal DIS3gQ : std_logic;
  signal DIS4aQ : std_logic;
  signal DIS4bQ : std_logic;
  signal DIS4cQ : std_logic;
  signal DIS4dQ : std_logic;
  signal DIS4eQ : std_logic;
  signal DIS4fQ : std_logic;
  signal DIS4gQ : std_logic;
  signal LED16COM : std_logic;
  signal LED17COM : std_logic;
  signal LED18COM : std_logic;
  signal LED19PIN : std_logic;
  signal LED20PIN : std_logic;
  signal LED21PIN : std_logic;
  signal LED22PIN : std_logic;
  signal LED23PIN : std_logic;
  signal LED24PIN : std_logic;
  signal LED25PIN : std_logic;
  signal LED26PIN : std_logic;
  signal LED27PIN : std_logic;
  signal LED28PIN : std_logic;
  signal LED29PIN : std_logic;
  signal X0Q : std_logic;
  signal X1Q : std_logic;
  signal X2Q : std_logic;
  signal X3Q : std_logic;
  signal X4Q : std_logic;
  signal X5Q : std_logic;
  signal X6Q : std_logic;
  signal X7Q : std_logic;
  signal Y0Q : std_logic;
  signal Y1Q : std_logic;
  signal Y2Q : std_logic;
  signal Y3Q : std_logic;
  signal Y4Q : std_logic;
  signal Y5Q : std_logic;
  signal Y6Q : std_logic;
  signal Y7Q : std_logic;
  signal S1Q : std_logic;
  signal Q3Q : std_logic;
  signal Q2Q : std_logic;
  signal Q1Q : std_logic;
  signal Q0Q : std_logic;
  signal P3Q : std_logic;
  signal P2Q : std_logic;
  signal P1Q : std_logic;
  signal P0Q : std_logic;
  signal L16Q : std_logic;
  signal osc_out : std_logic;
  signal tmr_out : std_logic;
  signal timedivQ : std_logic;
  signal timediv2Q : std_logic;
  signal dd7Q : std_logic;
  signal dd8Q : std_logic;
  signal dd9Q : std_logic;
  signal dd10Q : std_logic;
  signal dd11Q : std_logic;
  signal dd12Q : std_logic;
  signal dd13Q : std_logic;
  signal dd14Q : std_logic;
  signal dd15Q : std_logic;
  signal dd16Q : std_logic;
  signal dd17Q : std_logic;
  signal dd18Q : std_logic;
  signal dd19Q : std_logic;
  signal dd20Q : std_logic;
  signal T_0 : std_logic;
  signal T_1 : std_logic;
  signal T_2 : std_logic;
  signal T_3 : std_logic;
  signal T_4 : std_logic;
  signal T_5 : std_logic;
  signal T_6 : std_logic;
  signal T_7 : std_logic;
  signal T_8 : std_logic;
  signal T_9 : std_logic;
  signal T_10 : std_logic;
  signal T_11 : std_logic;
  signal T_12 : std_logic;
  signal T_13 : std_logic;
  signal T_14 : std_logic;
  signal T_15 : std_logic;
  signal DIS2e_D : std_logic;
  signal T_16 : std_logic;
  signal DIS2g_D : std_logic;
  signal T_17 : std_logic;
  signal T_18 : std_logic;
  signal T_19 : std_logic;
  signal T_20 : std_logic;
  signal T_21 : std_logic;
  signal T_22 : std_logic;
  signal T_23 : std_logic;
  signal T_24 : std_logic;
  signal T_25 : std_logic;
  signal T_26 : std_logic;
  signal T_27 : std_logic;
  signal T_28 : std_logic;
  signal T_29 : std_logic;
  signal T_30 : std_logic;
  signal T_31 : std_logic;
  signal T_32 : std_logic;
  signal X0_T : std_logic;
  signal Y0_D : std_logic;
  signal T_33 : std_logic;
  signal T_34 : std_logic;
  signal T_35 : std_logic;
  signal T_36 : std_logic;
  signal T_37 : std_logic;
  signal T_38 : std_logic;
  signal T_39 : std_logic;
  signal T_40 : std_logic;
  signal S1_AR : std_logic;
  signal S1_AP : std_logic;
  signal Q3_D : std_logic;
  signal Q2_D_X1 : std_logic;
  signal Q1_D_X1 : std_logic;
  signal Q1_D_X2 : std_logic;
  signal Q0_D_X1 : std_logic;
  signal Q0_D_X2 : std_logic;
  signal P3_D : std_logic;
  signal P2_D : std_logic;
  signal P1_D : std_logic;
  signal T_41 : std_logic;
  signal L16_D : std_logic;
  signal timediv_D : std_logic;
  signal timediv2_D : std_logic;
  signal dd7_D : std_logic;
  signal dd8_D : std_logic;
  signal dd9_D : std_logic;
  signal dd10_D : std_logic;
  signal T_42 : std_logic;
  signal dd12_D : std_logic;
  signal T_43 : std_logic;
  signal dd14_D : std_logic;
  signal dd15_D : std_logic;
  signal dd16_D : std_logic;
  signal dd17_D : std_logic;
  signal dd18_D : std_logic;
  signal dd19_D : std_logic;
  signal dd20_D : std_logic;
  signal Q3_AR : std_logic;
  signal Q2_D : std_logic;
  signal Q1_D : std_logic;
  signal Q0_D : std_logic;
  signal DIS2a_D : std_logic;
  signal DIS2b_D : std_logic;
  signal DIS2c_D : std_logic;
  signal DIS2d_D : std_logic;
  signal DIS2f_D : std_logic;
  signal DIS3a_D : std_logic;
  signal DIS3b_D : std_logic;
  signal DIS3c_D : std_logic;
  signal DIS3d_D : std_logic;
  signal DIS3e_D : std_logic;
  signal DIS3f_D : std_logic;
  signal DIS3g_D : std_logic;
  signal DIS4a_D : std_logic;
  signal DIS4b_D : std_logic;
  signal DIS4c_D : std_logic;
  signal DIS4d_D : std_logic;
  signal DIS4e_D : std_logic;
  signal DIS4f_D : std_logic;
  signal DIS4g_D : std_logic;
  signal Y0_CE : std_logic;
  signal Y1_CE : std_logic;
  signal Y2_CE : std_logic;
  signal Y3_CE : std_logic;
  signal Y4_CE : std_logic;
  signal Y5_CE : std_logic;
  signal Y6_CE : std_logic;
  signal Y7_CE : std_logic;
  signal P0_T : std_logic;
  signal dd11_D : std_logic;
  signal dd13_D : std_logic;
  signal T_44 : std_logic;
  signal T_45 : std_logic;
  signal T_46 : std_logic;
  signal T_47 : std_logic;
  signal T_48 : std_logic;
  signal T_49 : std_logic;
  signal T_50 : std_logic;
  signal T_51 : std_logic;
  signal T_52 : std_logic;
  signal T_53 : std_logic;
  signal T_54 : std_logic;
  signal T_55 : std_logic;
  signal T_56 : std_logic;
  signal T_57 : std_logic;
  signal T_58 : std_logic;
  signal T_59 : std_logic;
  signal T_60 : std_logic;
  signal T_61 : std_logic;
  signal T_62 : std_logic;
  signal T_63 : std_logic;
  signal T_64 : std_logic;
  signal T_65 : std_logic;
  signal T_66 : std_logic;
  signal T_67 : std_logic;
  signal T_68 : std_logic;
  signal T_69 : std_logic;
  signal T_70 : std_logic;
  signal T_71 : std_logic;
  signal T_72 : std_logic;
  signal T_73 : std_logic;
  signal T_74 : std_logic;
  signal T_75 : std_logic;
  signal T_76 : std_logic;
  signal T_77 : std_logic;
  signal T_78 : std_logic;
  signal T_79 : std_logic;
  signal T_80 : std_logic;
  signal T_81 : std_logic;
  signal T_82 : std_logic;
  signal T_83 : std_logic;
  signal T_84 : std_logic;
  signal T_85 : std_logic;
  signal T_86 : std_logic;
  signal T_87 : std_logic;
  signal T_88 : std_logic;
  signal T_89 : std_logic;
  signal T_90 : std_logic;
  signal T_91 : std_logic;
  signal T_92 : std_logic;
  signal T_93 : std_logic;
  signal T_94 : std_logic;
  signal T_95 : std_logic;
  signal T_96 : std_logic;
  signal T_97 : std_logic;
  signal T_98 : std_logic;
  signal T_99 : std_logic;
  signal T_100 : std_logic;
  signal T_101 : std_logic;
  signal T_102 : std_logic;
  signal T_103 : std_logic;
  signal T_104 : std_logic;
  signal T_105 : std_logic;
  signal T_106 : std_logic;
  signal T_107 : std_logic;
  signal T_108 : std_logic;
  signal T_109 : std_logic;
  signal T_110 : std_logic;
  signal T_111 : std_logic;
  signal T_112 : std_logic;
  signal T_113 : std_logic;
  signal T_114 : std_logic;
  signal T_115 : std_logic;
  signal T_116 : std_logic;
  signal T_117 : std_logic;
  signal T_118 : std_logic;
  signal T_119 : std_logic;
  signal T_120 : std_logic;
  signal T_121 : std_logic;
  signal T_122 : std_logic;
  signal T_123 : std_logic;
  signal T_124 : std_logic;
  signal T_125 : std_logic;
  signal T_126 : std_logic;
  signal T_127 : std_logic;
  signal T_128 : std_logic;
  signal T_129 : std_logic;
  signal T_130 : std_logic;
  signal T_131 : std_logic;
  signal T_132 : std_logic;
  signal T_133 : std_logic;
  signal T_134 : std_logic;
  signal T_135 : std_logic;
  signal T_136 : std_logic;
  signal T_137 : std_logic;
  signal T_138 : std_logic;
  signal T_139 : std_logic;
  signal T_140 : std_logic;
  signal T_141 : std_logic;
  signal T_142 : std_logic;
  signal T_143 : std_logic;
  signal T_144 : std_logic;
  signal T_145 : std_logic;
  signal T_146 : std_logic;
  signal T_147 : std_logic;
  signal T_148 : std_logic;
  signal T_149 : std_logic;
  signal T_150 : std_logic;
  signal T_151 : std_logic;
  signal T_152 : std_logic;
  signal T_153 : std_logic;
  signal T_154 : std_logic;
  signal T_155 : std_logic;
  signal T_156 : std_logic;
  signal T_157 : std_logic;
  signal T_158 : std_logic;
  signal T_159 : std_logic;
  signal T_160 : std_logic;
  signal T_161 : std_logic;
  signal T_162 : std_logic;
  signal T_163 : std_logic;
  signal T_164 : std_logic;
  signal T_165 : std_logic;
  signal T_166 : std_logic;
  signal T_167 : std_logic;
  signal T_168 : std_logic;
  signal T_169 : std_logic;
  signal T_170 : std_logic;
  signal T_171 : std_logic;
  signal T_172 : std_logic;
  signal T_173 : std_logic;
  signal T_174 : std_logic;
  signal T_175 : std_logic;
  signal T_176 : std_logic;
  signal T_177 : std_logic;
  signal T_178 : std_logic;
  signal T_179 : std_logic;
  signal T_180 : std_logic;
  signal T_181 : std_logic;
  signal T_182 : std_logic;
  signal T_183 : std_logic;
  signal T_184 : std_logic;
  signal T_185 : std_logic;
  signal T_186 : std_logic;
  signal T_187 : std_logic;
  signal T_188 : std_logic;
  signal T_189 : std_logic;
  signal T_190 : std_logic;
  signal T_191 : std_logic;
  signal T_192 : std_logic;
  signal T_193 : std_logic;
  signal T_194 : std_logic;
  signal T_195 : std_logic;
  signal T_196 : std_logic;
  signal T_197 : std_logic;
  signal T_198 : std_logic;
  signal T_199 : std_logic;
  signal T_200 : std_logic;
  signal T_201 : std_logic;
  signal T_202 : std_logic;
  signal T_203 : std_logic;
  signal T_204 : std_logic;
  signal T_205 : std_logic;
  signal T_206 : std_logic;
  signal T_207 : std_logic;
  signal T_208 : std_logic;
  signal T_209 : std_logic;
  signal T_210 : std_logic;
  signal T_211 : std_logic;
  signal T_212 : std_logic;
  signal T_213 : std_logic;
  signal T_214 : std_logic;
  signal T_215 : std_logic;
  signal T_216 : std_logic;
  signal T_217 : std_logic;
  signal T_218 : std_logic;
  signal T_219 : std_logic;
  signal T_220 : std_logic;
  signal T_221 : std_logic;
  signal T_222 : std_logic;
  signal T_223 : std_logic;
  signal T_224 : std_logic;
  signal T_225 : std_logic;
  signal T_226 : std_logic;
  signal T_227 : std_logic;
  signal T_228 : std_logic;
  signal T_229 : std_logic;
  signal T_230 : std_logic;
  signal T_231 : std_logic;
  signal T_232 : std_logic;
  signal T_233 : std_logic;
  signal T_234 : std_logic;
  signal T_235 : std_logic;
  signal T_236 : std_logic;
  signal T_237 : std_logic;
  signal T_238 : std_logic;
  signal T_239 : std_logic;
  signal T_240 : std_logic;
  signal T_241 : std_logic;
  signal T_242 : std_logic;
  signal T_243 : std_logic;
  signal T_244 : std_logic;
  signal T_245 : std_logic;
  signal T_246 : std_logic;
  signal T_247 : std_logic;
  signal T_248 : std_logic;
  signal T_249 : std_logic;
  signal T_250 : std_logic;
  signal T_251 : std_logic;
  signal T_252 : std_logic;
  signal T_253 : std_logic;
  signal T_254 : std_logic;
  signal T_255 : std_logic;
  signal T_256 : std_logic;
  signal T_257 : std_logic;
  signal T_258 : std_logic;
  signal T_259 : std_logic;
  signal T_260 : std_logic;
  signal T_261 : std_logic;
  signal T_262 : std_logic;
  signal T_263 : std_logic;
  signal T_264 : std_logic;
  signal T_265 : std_logic;
  signal T_266 : std_logic;
  signal T_267 : std_logic;
  signal T_268 : std_logic;
  signal T_269 : std_logic;
  signal T_270 : std_logic;
  signal T_271 : std_logic;
  signal T_272 : std_logic;
  signal T_273 : std_logic;
  signal T_274 : std_logic;
  signal T_275 : std_logic;
  signal T_276 : std_logic;
  signal T_277 : std_logic;
  signal T_278 : std_logic;
  signal T_279 : std_logic;
  signal T_280 : std_logic;
  signal T_281 : std_logic;
  signal T_282 : std_logic;
  signal T_283 : std_logic;
  signal T_284 : std_logic;
  signal T_285 : std_logic;
  signal T_286 : std_logic;
  signal T_287 : std_logic;
  signal T_288 : std_logic;
  signal T_289 : std_logic;
  signal T_290 : std_logic;
  signal T_291 : std_logic;
  signal T_292 : std_logic;
  signal T_293 : std_logic;
  signal T_294 : std_logic;
  signal T_295 : std_logic;
  signal T_296 : std_logic;
  signal T_297 : std_logic;
  signal T_298 : std_logic;
  signal T_299 : std_logic;
  signal T_300 : std_logic;
  signal T_301 : std_logic;
  signal T_302 : std_logic;
  signal T_303 : std_logic;
  signal T_304 : std_logic;
  signal T_305 : std_logic;
  signal T_306 : std_logic;
  signal T_307 : std_logic;
  signal T_308 : std_logic;
  signal T_309 : std_logic;
  signal T_310 : std_logic;
  signal T_311 : std_logic;
  signal T_312 : std_logic;
  signal T_313 : std_logic;
  signal T_314 : std_logic;
  signal T_315 : std_logic;
  signal T_316 : std_logic;
  signal T_317 : std_logic;
  signal T_318 : std_logic;
  signal T_319 : std_logic;
  signal T_320 : std_logic;
  signal T_321 : std_logic;
  signal T_322 : std_logic;
  signal T_323 : std_logic;
  signal T_324 : std_logic;
  signal T_325 : std_logic;
  signal T_326 : std_logic;
  signal T_327 : std_logic;
  signal T_328 : std_logic;
  signal T_329 : std_logic;
  signal T_330 : std_logic;
  signal T_331 : std_logic;
  signal T_332 : std_logic;
  signal T_333 : std_logic;
  signal T_334 : std_logic;
  signal T_335 : std_logic;
  signal T_336 : std_logic;
  signal T_337 : std_logic;
  signal T_338 : std_logic;
  signal T_339 : std_logic;
  signal T_340 : std_logic;
  signal T_341 : std_logic;
  signal T_342 : std_logic;
  signal T_343 : std_logic;
  signal T_344 : std_logic;
  signal T_345 : std_logic;
  signal T_346 : std_logic;
  signal T_347 : std_logic;
  signal T_348 : std_logic;
  signal T_349 : std_logic;
  signal T_350 : std_logic;
  signal T_351 : std_logic;
  signal T_352 : std_logic;
  signal T_353 : std_logic;
  signal T_354 : std_logic;
  signal T_355 : std_logic;
  signal T_356 : std_logic;
  signal T_357 : std_logic;
  signal T_358 : std_logic;
  signal T_359 : std_logic;
  signal T_360 : std_logic;
  signal T_361 : std_logic;
  signal T_362 : std_logic;
  signal T_363 : std_logic;
  signal T_364 : std_logic;
  signal T_365 : std_logic;
  signal T_366 : std_logic;
  signal T_367 : std_logic;
  signal T_368 : std_logic;
  signal T_369 : std_logic;
  signal T_370 : std_logic;
  signal T_371 : std_logic;
  signal T_372 : std_logic;
  signal T_373 : std_logic;
  signal T_374 : std_logic;
  signal T_375 : std_logic;
  signal T_376 : std_logic;
  signal T_377 : std_logic;
  signal T_378 : std_logic;
  signal T_379 : std_logic;
  signal T_380 : std_logic;
  signal T_381 : std_logic;
  signal T_382 : std_logic;
  signal T_383 : std_logic;
  signal T_384 : std_logic;
  signal T_385 : std_logic;
  signal T_386 : std_logic;
  signal T_387 : std_logic;
  signal T_388 : std_logic;
  signal T_389 : std_logic;
  signal T_390 : std_logic;
  signal T_391 : std_logic;
  signal T_392 : std_logic;
  signal T_393 : std_logic;
  signal T_394 : std_logic;
  signal T_395 : std_logic;
  signal T_396 : std_logic;
  signal T_397 : std_logic;
  signal T_398 : std_logic;
  signal T_399 : std_logic;
  signal T_400 : std_logic;
  signal T_401 : std_logic;
  signal T_402 : std_logic;
  signal T_403 : std_logic;
  signal T_404 : std_logic;
  signal T_405 : std_logic;
  signal T_406 : std_logic;
  signal T_407 : std_logic;
  signal T_408 : std_logic;
  signal T_409 : std_logic;
  signal T_410 : std_logic;
  signal T_411 : std_logic;
  signal T_412 : std_logic;
  signal T_413 : std_logic;
  signal T_414 : std_logic;
  signal GND_net : std_logic;
  signal FF_X0_T1 : std_logic;
  signal GATE_T_17_A : std_logic;
  signal GATE_T_18_A : std_logic;
  signal GATE_T_19_A : std_logic;
  signal GATE_T_20_A : std_logic;
  signal GATE_T_21_A : std_logic;
  signal GATE_T_22_A : std_logic;
  signal GATE_T_23_A : std_logic;
  signal GATE_T_24_A : std_logic;
  signal GATE_T_25_A : std_logic;
  signal GATE_T_26_A : std_logic;
  signal GATE_T_27_A : std_logic;
  signal GATE_T_28_A : std_logic;
  signal GATE_T_29_A : std_logic;
  signal GATE_T_30_A : std_logic;
  signal GATE_T_32_DN : std_logic;
  signal GATE_Y0_D_A : std_logic;
  signal GATE_T_33_DN : std_logic;
  signal GATE_T_34_DN : std_logic;
  signal GATE_T_35_DN : std_logic;
  signal GATE_T_36_DN : std_logic;
  signal GATE_T_37_DN : std_logic;
  signal GATE_T_38_DN : std_logic;
  signal GATE_T_39_DN : std_logic;
  signal GATE_T_40_DN : std_logic;
  signal GATE_Q1_D_X2_A : std_logic;
  signal GATE_Q1_D_X2_B : std_logic;
  signal GATE_Q0_D_X2_A : std_logic;
  signal GATE_Q0_D_X2_B : std_logic;
  signal GATE_dd14_D_A : std_logic;
  signal GATE_dd15_D_A : std_logic;
  signal GATE_dd16_D_A : std_logic;
  signal GATE_dd17_D_A : std_logic;
  signal GATE_dd18_D_A : std_logic;
  signal GATE_dd19_D_A : std_logic;
  signal GATE_dd20_D_A : std_logic;
  signal GATE_Q2_D_Y : std_logic;
  signal GATE_T_45_DN : std_logic;
  signal GATE_T_46_B : std_logic;
  signal GATE_T_46_A : std_logic;
  signal GATE_T_47_B : std_logic;
  signal GATE_T_47_A : std_logic;
  signal GATE_T_48_A : std_logic;
  signal GATE_T_54_A : std_logic;
  signal GATE_T_55_B : std_logic;
  signal GATE_T_55_A : std_logic;
  signal GATE_T_58_A : std_logic;
  signal GATE_T_58_B : std_logic;
  signal GATE_T_68_B : std_logic;
  signal GATE_T_68_A : std_logic;
  signal GATE_T_70_DN : std_logic;
  signal GATE_T_71_DN : std_logic;
  signal GATE_T_72_DN : std_logic;
  signal GATE_T_73_A : std_logic;
  signal GATE_T_73_B : std_logic;
  signal GATE_T_75_B : std_logic;
  signal GATE_T_75_A : std_logic;
  signal GATE_T_76_DN : std_logic;
  signal GATE_T_77_A : std_logic;
  signal GATE_T_77_B : std_logic;
  signal GATE_T_78_A : std_logic;
  signal GATE_T_78_B : std_logic;
  signal GATE_T_79_A : std_logic;
  signal GATE_T_82_B : std_logic;
  signal GATE_T_82_A : std_logic;
  signal GATE_T_83_A : std_logic;
  signal GATE_T_84_A : std_logic;
  signal GATE_T_85_DN : std_logic;
  signal GATE_T_86_DN : std_logic;
  signal GATE_T_87_A : std_logic;
  signal GATE_T_87_B : std_logic;
  signal GATE_T_88_A : std_logic;
  signal GATE_T_89_A : std_logic;
  signal GATE_T_92_B : std_logic;
  signal GATE_T_92_A : std_logic;
  signal GATE_T_93_B : std_logic;
  signal GATE_T_93_A : std_logic;
  signal GATE_T_94_B : std_logic;
  signal GATE_T_94_A : std_logic;
  signal GATE_T_95_B : std_logic;
  signal GATE_T_95_A : std_logic;
  signal GATE_T_96_B : std_logic;
  signal GATE_T_96_A : std_logic;
  signal GATE_T_97_A : std_logic;
  signal GATE_T_97_B : std_logic;
  signal GATE_T_106_A : std_logic;
  signal GATE_T_110_DN : std_logic;
  signal GATE_T_113_A : std_logic;
  signal GATE_T_114_A : std_logic;
  signal GATE_T_119_A : std_logic;
  signal GATE_T_120_A : std_logic;
  signal GATE_T_121_A : std_logic;
  signal GATE_T_122_DN : std_logic;
  signal GATE_T_126_A : std_logic;
  signal GATE_T_127_A : std_logic;
  signal GATE_T_128_A : std_logic;
  signal GATE_T_136_A : std_logic;
  signal GATE_T_137_A : std_logic;
  signal GATE_T_144_DN : std_logic;
  signal GATE_T_147_A : std_logic;
  signal GATE_T_148_A : std_logic;
  signal GATE_T_149_A : std_logic;
  signal GATE_T_152_B : std_logic;
  signal GATE_T_152_A : std_logic;
  signal GATE_T_154_DN : std_logic;
  signal GATE_T_155_DN : std_logic;
  signal GATE_T_156_DN : std_logic;
  signal GATE_T_157_A : std_logic;
  signal GATE_T_157_B : std_logic;
  signal GATE_T_159_B : std_logic;
  signal GATE_T_159_A : std_logic;
  signal GATE_T_160_DN : std_logic;
  signal GATE_T_161_A : std_logic;
  signal GATE_T_161_B : std_logic;
  signal GATE_T_162_A : std_logic;
  signal GATE_T_162_B : std_logic;
  signal GATE_T_163_A : std_logic;
  signal GATE_T_166_B : std_logic;
  signal GATE_T_166_A : std_logic;
  signal GATE_T_167_A : std_logic;
  signal GATE_T_168_A : std_logic;
  signal GATE_T_169_DN : std_logic;
  signal GATE_T_170_DN : std_logic;
  signal GATE_T_171_A : std_logic;
  signal GATE_T_171_B : std_logic;
  signal GATE_T_172_B : std_logic;
  signal GATE_T_172_A : std_logic;
  signal GATE_T_175_A : std_logic;
  signal GATE_T_178_A : std_logic;
  signal GATE_T_179_A : std_logic;
  signal GATE_T_179_B : std_logic;
  signal GATE_T_180_A : std_logic;
  signal GATE_T_181_A : std_logic;
  signal GATE_T_182_DN : std_logic;
  signal GATE_T_183_DN : std_logic;
  signal GATE_T_184_A : std_logic;
  signal GATE_T_185_A : std_logic;
  signal GATE_T_186_DN : std_logic;
  signal GATE_T_187_DN : std_logic;
  signal GATE_T_188_A : std_logic;
  signal GATE_T_188_B : std_logic;
  signal GATE_T_189_A : std_logic;
  signal GATE_T_189_B : std_logic;
  signal GATE_T_190_A : std_logic;
  signal GATE_T_199_A : std_logic;
  signal GATE_T_200_A : std_logic;
  signal GATE_T_202_A : std_logic;
  signal GATE_T_205_A : std_logic;
  signal GATE_T_214_A : std_logic;
  signal GATE_T_216_A : std_logic;
  signal GATE_T_217_A : std_logic;
  signal GATE_T_219_A : std_logic;
  signal GATE_T_220_A : std_logic;
  signal GATE_T_222_A : std_logic;
  signal GATE_T_223_A : std_logic;
  signal GATE_T_225_A : std_logic;
  signal GATE_T_226_A : std_logic;
  signal GATE_T_228_A : std_logic;
  signal GATE_T_231_A : std_logic;
  signal GATE_T_234_A : std_logic;
  signal GATE_T_239_A : std_logic;
  signal GATE_T_241_A : std_logic;
  signal GATE_T_244_A : std_logic;
  signal GATE_T_248_A : std_logic;
  signal GATE_T_250_A : std_logic;
  signal GATE_T_251_A : std_logic;
  signal GATE_T_253_A : std_logic;
  signal GATE_T_254_A : std_logic;
  signal GATE_T_257_A : std_logic;
  signal GATE_T_264_A : std_logic;
  signal GATE_T_266_A : std_logic;
  signal GATE_T_268_A : std_logic;
  signal GATE_T_269_A : std_logic;
  signal GATE_T_271_A : std_logic;
  signal GATE_T_273_A : std_logic;
  signal GATE_T_274_A : std_logic;
  signal GATE_T_276_A : std_logic;
  signal GATE_T_277_A : std_logic;
  signal GATE_T_279_A : std_logic;
  signal GATE_T_280_A : std_logic;
  signal GATE_T_284_A : std_logic;
  signal GATE_T_285_A : std_logic;
  signal GATE_T_287_A : std_logic;
  signal GATE_T_288_A : std_logic;
  signal GATE_T_299_A : std_logic;
  signal GATE_T_304_A : std_logic;
  signal GATE_T_305_A : std_logic;
  signal GATE_T_306_A : std_logic;
  signal GATE_T_307_A : std_logic;
  signal GATE_T_308_A : std_logic;
  signal GATE_T_309_A : std_logic;
  signal GATE_T_310_A : std_logic;
  signal GATE_T_314_A : std_logic;
  signal GATE_T_317_A : std_logic;
  signal GATE_T_320_A : std_logic;
  signal GATE_T_328_A : std_logic;
  signal GATE_T_334_A : std_logic;
  signal GATE_T_341_A : std_logic;
  signal GATE_T_343_A : std_logic;
  signal GATE_T_348_A : std_logic;
  signal GATE_T_350_A : std_logic;
  signal GATE_T_352_A : std_logic;
  signal GATE_T_360_A : std_logic;
  signal GATE_T_366_A : std_logic;
  signal GATE_T_368_A : std_logic;
  signal GATE_T_370_A : std_logic;
  signal GATE_T_372_A : std_logic;
  signal GATE_T_374_A : std_logic;
  signal GATE_T_376_A : std_logic;
  signal GATE_T_382_A : std_logic;
  signal GATE_T_385_A : std_logic;
  signal GATE_T_388_A : std_logic;
  signal GATE_T_391_A : std_logic;
  signal GATE_T_395_A : std_logic;
  signal GATE_T_398_A : std_logic;
  signal GATE_T_409_A : std_logic;
  signal GATE_T_411_A : std_logic;
  signal GATE_T_414_A : std_logic;

begin
  I1:   OSCTIMER
 generic map( TIMER_DIV => "1048576", NORM_FREQ => "500", CO_DELAY => "1250")
 port map ( OSCOUT=>osc_out, 
            TIMEROUT=>tmr_out, 
            DYNOSCDIS=>GND_net, 
            TIMERRES=>GND_net );
  GND_I_I_1:   GND port map ( X=>GND_net );
  IN_DIP0_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP0PIN, 
            I0=>DIP0 );
  IN_DIP1_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP1PIN, 
            I0=>DIP1 );
  IN_DIP2_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP2PIN, 
            I0=>DIP2 );
  IN_DIP3_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP3PIN, 
            I0=>DIP3 );
  IN_DIP4_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP4PIN, 
            I0=>DIP4 );
  IN_DIP5_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP5PIN, 
            I0=>DIP5 );
  IN_DIP6_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP6PIN, 
            I0=>DIP6 );
  IN_DIP7_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>DIP7PIN, 
            I0=>DIP7 );
  IN_S1_NC_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>S1_NCPIN, 
            I0=>S1_NC );
  IN_S1_NO_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>S1_NOPIN, 
            I0=>S1_NO );
  IN_S2_NC_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>S2_NCPIN, 
            I0=>S2_NC );
  IN_S2_NO_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>S2_NOPIN, 
            I0=>S2_NO );
  OUT_LED0_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED0, 
            I0=>LED0COM );
  OUT_LED1_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED1, 
            I0=>LED1COM );
  OUT_LED2_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED2, 
            I0=>LED2COM );
  OUT_LED3_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED3, 
            I0=>LED3COM );
  OUT_LED4_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED4, 
            I0=>LED4COM );
  OUT_LED5_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED5, 
            I0=>LED5COM );
  OUT_LED6_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED6, 
            I0=>LED6COM );
  OUT_LED7_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED7, 
            I0=>LED7COM );
  OUT_LED8_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED8, 
            I0=>LED8COM );
  OUT_LED9_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED9, 
            I0=>LED9COM );
  OUT_LED10_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED10, 
            I0=>LED10COM );
  OUT_LED11_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED11, 
            I0=>LED11COM );
  OUT_LED12_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED12, 
            I0=>LED12COM );
  OUT_LED13_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED13, 
            I0=>LED13COM );
  OUT_LED14_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED14, 
            I0=>LED14COM );
  OUT_LED15_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED15, 
            I0=>LED15COM );
  OUT_DIS1a_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS1a, 
            I0=>DIS1aCOM );
  OUT_DIS1b_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS1b, 
            I0=>DIS1bCOM );
  OUT_DIS1c_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS1c, 
            I0=>DIS1cCOM );
  OUT_DIS1d_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS1d, 
            I0=>DIS1dCOM );
  OUT_DIS1e_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS1e, 
            I0=>DIS1eCOM );
  OUT_DIS1f_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS1f, 
            I0=>DIS1fCOM );
  OUT_DIS1g_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS1g, 
            I0=>DIS1gCOM );
  OUT_DIS2a_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS2a, 
            I0=>DIS2aQ );
  OUT_DIS2b_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS2b, 
            I0=>DIS2bQ );
  OUT_DIS2c_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS2c, 
            I0=>DIS2cQ );
  OUT_DIS2d_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS2d, 
            I0=>DIS2dQ );
  OUT_DIS2e_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS2e, 
            I0=>DIS2eQ );
  OUT_DIS2f_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS2f, 
            I0=>DIS2fQ );
  OUT_DIS2g_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS2g, 
            I0=>DIS2gQ );
  OUT_DIS3a_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS3a, 
            I0=>DIS3aQ );
  OUT_DIS3b_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS3b, 
            I0=>DIS3bQ );
  OUT_DIS3c_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS3c, 
            I0=>DIS3cQ );
  OUT_DIS3d_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS3d, 
            I0=>DIS3dQ );
  OUT_DIS3e_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS3e, 
            I0=>DIS3eQ );
  OUT_DIS3f_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS3f, 
            I0=>DIS3fQ );
  OUT_DIS3g_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS3g, 
            I0=>DIS3gQ );
  OUT_DIS4a_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS4a, 
            I0=>DIS4aQ );
  OUT_DIS4b_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS4b, 
            I0=>DIS4bQ );
  OUT_DIS4c_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS4c, 
            I0=>DIS4cQ );
  OUT_DIS4d_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS4d, 
            I0=>DIS4dQ );
  OUT_DIS4e_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS4e, 
            I0=>DIS4eQ );
  OUT_DIS4f_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS4f, 
            I0=>DIS4fQ );
  OUT_DIS4g_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>DIS4g, 
            I0=>DIS4gQ );
  OUT_LED16_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED16, 
            I0=>LED16COM );
  OUT_LED17_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED17, 
            I0=>LED17COM );
  OUT_LED18_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>LED18, 
            I0=>LED18COM );
  IN_LED19_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED19PIN, 
            I0=>LED19 );
  IN_LED20_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED20PIN, 
            I0=>LED20 );
  IN_LED21_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED21PIN, 
            I0=>LED21 );
  IN_LED22_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED22PIN, 
            I0=>LED22 );
  IN_LED23_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED23PIN, 
            I0=>LED23 );
  IN_LED24_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED24PIN, 
            I0=>LED24 );
  IN_LED25_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED25PIN, 
            I0=>LED25 );
  IN_LED26_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED26PIN, 
            I0=>LED26 );
  IN_LED27_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED27PIN, 
            I0=>LED27 );
  IN_LED28_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED28PIN, 
            I0=>LED28 );
  IN_LED29_I_1:   IBUF
 generic map( PULL => "Down")
 port map ( O=>LED29PIN, 
            I0=>LED29 );
  OUT_X0_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X0, 
            I0=>X0Q );
  OUT_X1_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X1, 
            I0=>X1Q );
  OUT_X2_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X2, 
            I0=>X2Q );
  OUT_X3_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X3, 
            I0=>X3Q );
  OUT_X4_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X4, 
            I0=>X4Q );
  OUT_X5_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X5, 
            I0=>X5Q );
  OUT_X6_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X6, 
            I0=>X6Q );
  OUT_X7_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>X7, 
            I0=>X7Q );
  OUT_Y0_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y0, 
            I0=>Y0Q );
  OUT_Y1_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y1, 
            I0=>Y1Q );
  OUT_Y2_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y2, 
            I0=>Y2Q );
  OUT_Y3_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y3, 
            I0=>Y3Q );
  OUT_Y4_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y4, 
            I0=>Y4Q );
  OUT_Y5_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y5, 
            I0=>Y5Q );
  OUT_Y6_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y6, 
            I0=>Y6Q );
  OUT_Y7_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Y7, 
            I0=>Y7Q );
  OUT_S1_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>S1, 
            I0=>S1Q );
  OUT_Q3_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Q3, 
            I0=>Q3Q );
  OUT_Q2_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Q2, 
            I0=>Q2Q );
  OUT_Q1_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Q1, 
            I0=>Q1Q );
  OUT_Q0_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>Q0, 
            I0=>Q0Q );
  OUT_P3_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>P3, 
            I0=>P3Q );
  OUT_P2_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>P2, 
            I0=>P2Q );
  OUT_P1_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>P1, 
            I0=>P1Q );
  OUT_P0_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>P0, 
            I0=>P0Q );
  OUT_L16_I_1:   OBUF
 generic map( PULL => "Down")
 port map ( O=>L16, 
            I0=>L16Q );
  FF_DIS2a_I_1:   DFF port map ( D=>DIS2a_D, 
            Q=>DIS2aQ, 
            CLK=>timediv2Q );
  FF_DIS2b_I_1:   DFF port map ( D=>DIS2b_D, 
            Q=>DIS2bQ, 
            CLK=>timediv2Q );
  FF_DIS2c_I_1:   DFF port map ( D=>DIS2c_D, 
            Q=>DIS2cQ, 
            CLK=>timediv2Q );
  FF_DIS2d_I_1:   DFF port map ( D=>DIS2d_D, 
            Q=>DIS2dQ, 
            CLK=>timediv2Q );
  FF_DIS2e_I_1:   DFF port map ( D=>DIS2e_D, 
            Q=>DIS2eQ, 
            CLK=>timediv2Q );
  FF_DIS2f_I_1:   DFF port map ( D=>DIS2f_D, 
            Q=>DIS2fQ, 
            CLK=>timediv2Q );
  FF_DIS2g_I_1:   DFF port map ( D=>DIS2g_D, 
            Q=>DIS2gQ, 
            CLK=>timediv2Q );
  FF_DIS3a_I_1:   DFF port map ( D=>DIS3a_D, 
            Q=>DIS3aQ, 
            CLK=>timediv2Q );
  FF_DIS3b_I_1:   DFF port map ( D=>DIS3b_D, 
            Q=>DIS3bQ, 
            CLK=>timediv2Q );
  FF_DIS3c_I_1:   DFF port map ( D=>DIS3c_D, 
            Q=>DIS3cQ, 
            CLK=>timediv2Q );
  FF_DIS3d_I_1:   DFF port map ( D=>DIS3d_D, 
            Q=>DIS3dQ, 
            CLK=>timediv2Q );
  FF_DIS3e_I_1:   DFF port map ( D=>DIS3e_D, 
            Q=>DIS3eQ, 
            CLK=>timediv2Q );
  FF_DIS3f_I_1:   DFF port map ( D=>DIS3f_D, 
            Q=>DIS3fQ, 
            CLK=>timediv2Q );
  FF_DIS3g_I_1:   DFF port map ( D=>DIS3g_D, 
            Q=>DIS3gQ, 
            CLK=>timediv2Q );
  FF_DIS4a_I_1:   DFF port map ( D=>DIS4a_D, 
            Q=>DIS4aQ, 
            CLK=>timediv2Q );
  FF_DIS4b_I_1:   DFF port map ( D=>DIS4b_D, 
            Q=>DIS4bQ, 
            CLK=>timediv2Q );
  FF_DIS4c_I_1:   DFF port map ( D=>DIS4c_D, 
            Q=>DIS4cQ, 
            CLK=>timediv2Q );
  FF_DIS4d_I_1:   DFF port map ( D=>DIS4d_D, 
            Q=>DIS4dQ, 
            CLK=>timediv2Q );
  FF_DIS4e_I_1:   DFF port map ( D=>DIS4e_D, 
            Q=>DIS4eQ, 
            CLK=>timediv2Q );
  FF_DIS4f_I_1:   DFF port map ( D=>DIS4f_D, 
            Q=>DIS4fQ, 
            CLK=>timediv2Q );
  FF_DIS4g_I_1:   DFF port map ( D=>DIS4g_D, 
            Q=>DIS4gQ, 
            CLK=>timediv2Q );
  FF_X0_I_1:   TFFRH port map ( R=>DIP7PIN, 
            Q=>X0Q, 
            T=>FF_X0_T1, 
            CLK=>timediv2Q );
  FF_X0_I_2:   AND2 port map ( I1=>X0_T, 
            O=>FF_X0_T1, 
            I0=>DIP0PIN );
  FF_X1_I_1:   DFFCRH port map ( Q=>X1Q, 
            R=>DIP7PIN, 
            CLK=>timediv2Q, 
            CE=>DIP0PIN, 
            D=>X0Q );
  FF_X2_I_1:   DFFCRH port map ( Q=>X2Q, 
            R=>DIP7PIN, 
            CLK=>timediv2Q, 
            CE=>DIP0PIN, 
            D=>X1Q );
  FF_X3_I_1:   DFFCRH port map ( Q=>X3Q, 
            R=>DIP7PIN, 
            CLK=>timediv2Q, 
            CE=>DIP0PIN, 
            D=>X2Q );
  FF_X4_I_1:   DFFCRH port map ( Q=>X4Q, 
            R=>DIP7PIN, 
            CLK=>timediv2Q, 
            CE=>DIP0PIN, 
            D=>X3Q );
  FF_X5_I_1:   DFFCRH port map ( Q=>X5Q, 
            R=>DIP7PIN, 
            CLK=>timediv2Q, 
            CE=>DIP0PIN, 
            D=>X4Q );
  FF_X6_I_1:   DFFCRH port map ( Q=>X6Q, 
            R=>DIP7PIN, 
            CLK=>timediv2Q, 
            CE=>DIP0PIN, 
            D=>X5Q );
  FF_X7_I_1:   DFFCRH port map ( Q=>X7Q, 
            R=>DIP7PIN, 
            CLK=>timediv2Q, 
            CE=>DIP0PIN, 
            D=>X6Q );
  FF_Y0_I_1:   DFFCSH port map ( Q=>Y0Q, 
            S=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y0_CE, 
            D=>Y0_D );
  FF_Y1_I_1:   DFFCRH port map ( Q=>Y1Q, 
            R=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y1_CE, 
            D=>Y0Q );
  FF_Y2_I_1:   DFFCRH port map ( Q=>Y2Q, 
            R=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y2_CE, 
            D=>Y1Q );
  FF_Y3_I_1:   DFFCRH port map ( Q=>Y3Q, 
            R=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y3_CE, 
            D=>Y2Q );
  FF_Y4_I_1:   DFFCRH port map ( Q=>Y4Q, 
            R=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y4_CE, 
            D=>Y3Q );
  FF_Y5_I_1:   DFFCRH port map ( Q=>Y5Q, 
            R=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y5_CE, 
            D=>Y4Q );
  FF_Y6_I_1:   DFFCRH port map ( Q=>Y6Q, 
            R=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y6_CE, 
            D=>Y5Q );
  FF_Y7_I_1:   DFFCRH port map ( Q=>Y7Q, 
            R=>DIP7PIN, 
            CLK=>S1Q, 
            CE=>Y7_CE, 
            D=>Y6Q );
  FF_S1_I_1:   DFFRSH port map ( Q=>S1Q, 
            R=>S1_AR, 
            S=>S1_AP, 
            CLK=>GND_net, 
            D=>GND_net );
  FF_Q3_I_1:   DFFRH port map ( Q=>Q3Q, 
            R=>Q3_AR, 
            CLK=>S1Q, 
            D=>Q3_D );
  FF_Q2_I_1:   DFFRH port map ( Q=>Q2Q, 
            R=>Q3_AR, 
            CLK=>S1Q, 
            D=>Q2_D );
  FF_Q1_I_1:   DFFRH port map ( Q=>Q1Q, 
            R=>Q3_AR, 
            CLK=>S1Q, 
            D=>Q1_D );
  FF_Q0_I_1:   DFFRH port map ( Q=>Q0Q, 
            R=>Q3_AR, 
            CLK=>S1Q, 
            D=>Q0_D );
  FF_P3_I_1:   DFF port map ( D=>P3_D, 
            Q=>P3Q, 
            CLK=>timediv2Q );
  FF_P2_I_1:   DFF port map ( D=>P2_D, 
            Q=>P2Q, 
            CLK=>timediv2Q );
  FF_P1_I_1:   DFF port map ( D=>P1_D, 
            Q=>P1Q, 
            CLK=>timediv2Q );
  FF_P0_I_1:   TFF port map ( T=>P0_T, 
            Q=>P0Q, 
            CLK=>timediv2Q );
  FF_L16_I_1:   DFF port map ( D=>L16_D, 
            Q=>L16Q, 
            CLK=>timediv2Q );
  FF_timediv_I_1:   DFF port map ( D=>timediv_D, 
            Q=>timedivQ, 
            CLK=>tmr_out );
  FF_timediv2_I_1:   DFF port map ( D=>timediv2_D, 
            Q=>timediv2Q, 
            CLK=>timedivQ );
  FF_dd7_I_1:   DFF port map ( D=>dd7_D, 
            Q=>dd7Q, 
            CLK=>timediv2Q );
  FF_dd8_I_1:   DFF port map ( D=>dd8_D, 
            Q=>dd8Q, 
            CLK=>timediv2Q );
  FF_dd9_I_1:   DFF port map ( D=>dd9_D, 
            Q=>dd9Q, 
            CLK=>timediv2Q );
  FF_dd10_I_1:   DFF port map ( D=>dd10_D, 
            Q=>dd10Q, 
            CLK=>timediv2Q );
  FF_dd11_I_1:   DFF port map ( D=>dd11_D, 
            Q=>dd11Q, 
            CLK=>timediv2Q );
  FF_dd12_I_1:   DFF port map ( D=>dd12_D, 
            Q=>dd12Q, 
            CLK=>timediv2Q );
  FF_dd13_I_1:   DFF port map ( D=>dd13_D, 
            Q=>dd13Q, 
            CLK=>timediv2Q );
  FF_dd14_I_1:   DFF port map ( D=>dd14_D, 
            Q=>dd14Q, 
            CLK=>timediv2Q );
  FF_dd15_I_1:   DFF port map ( D=>dd15_D, 
            Q=>dd15Q, 
            CLK=>timediv2Q );
  FF_dd16_I_1:   DFF port map ( D=>dd16_D, 
            Q=>dd16Q, 
            CLK=>timediv2Q );
  FF_dd17_I_1:   DFF port map ( D=>dd17_D, 
            Q=>dd17Q, 
            CLK=>timediv2Q );
  FF_dd18_I_1:   DFF port map ( D=>dd18_D, 
            Q=>dd18Q, 
            CLK=>timediv2Q );
  FF_dd19_I_1:   DFF port map ( D=>dd19_D, 
            Q=>dd19Q, 
            CLK=>timediv2Q );
  FF_dd20_I_1:   DFF port map ( D=>dd20_D, 
            Q=>dd20Q, 
            CLK=>timediv2Q );
  GATE_T_0_I_1:   AND2 port map ( O=>T_0, 
            I1=>DIP1PIN, 
            I0=>X0Q );
  GATE_T_1_I_1:   AND2 port map ( O=>T_1, 
            I1=>DIP1PIN, 
            I0=>X1Q );
  GATE_T_2_I_1:   AND2 port map ( O=>T_2, 
            I1=>DIP1PIN, 
            I0=>X2Q );
  GATE_T_3_I_1:   AND2 port map ( O=>T_3, 
            I1=>DIP1PIN, 
            I0=>X3Q );
  GATE_T_4_I_1:   AND2 port map ( O=>T_4, 
            I1=>DIP1PIN, 
            I0=>X4Q );
  GATE_T_5_I_1:   AND2 port map ( O=>T_5, 
            I1=>DIP1PIN, 
            I0=>X5Q );
  GATE_T_6_I_1:   AND2 port map ( O=>T_6, 
            I1=>DIP1PIN, 
            I0=>X6Q );
  GATE_T_7_I_1:   AND2 port map ( O=>T_7, 
            I1=>DIP1PIN, 
            I0=>X7Q );
  GATE_LED8_I_1:   INV port map ( I0=>Y0Q, 
            O=>LED8COM );
  GATE_LED9_I_1:   INV port map ( I0=>Y1Q, 
            O=>LED9COM );
  GATE_LED10_I_1:   INV port map ( I0=>Y2Q, 
            O=>LED10COM );
  GATE_LED11_I_1:   INV port map ( I0=>Y3Q, 
            O=>LED11COM );
  GATE_LED12_I_1:   INV port map ( I0=>Y4Q, 
            O=>LED12COM );
  GATE_LED13_I_1:   INV port map ( I0=>Y5Q, 
            O=>LED13COM );
  GATE_LED14_I_1:   INV port map ( I0=>Y6Q, 
            O=>LED14COM );
  GATE_LED15_I_1:   INV port map ( I0=>Y7Q, 
            O=>LED15COM );
  GATE_T_8_I_1:   OR3 port map ( O=>T_8, 
            I2=>T_189, 
            I1=>T_188, 
            I0=>T_190 );
  GATE_T_9_I_1:   OR2 port map ( O=>T_9, 
            I1=>T_187, 
            I0=>T_186 );
  GATE_T_10_I_1:   OR4 port map ( I0=>T_182, 
            I1=>T_183, 
            O=>T_10, 
            I2=>T_184, 
            I3=>T_185 );
  GATE_T_11_I_1:   OR4 port map ( I0=>T_178, 
            I1=>T_179, 
            O=>T_11, 
            I2=>T_180, 
            I3=>T_181 );
  GATE_DIS1e_I_1:   NOR3 port map ( O=>DIS1eCOM, 
            I2=>P2Q, 
            I1=>P3Q, 
            I0=>P1Q );
  GATE_DIS1f_I_1:   OR4 port map ( I0=>T_174, 
            I1=>T_175, 
            O=>DIS1fCOM, 
            I2=>T_176, 
            I3=>T_177 );
  GATE_DIS1g_I_1:   OR2 port map ( O=>DIS1gCOM, 
            I1=>T_173, 
            I0=>T_172 );
  GATE_T_12_I_1:   OR3 port map ( O=>T_12, 
            I2=>T_170, 
            I1=>T_169, 
            I0=>T_171 );
  GATE_T_13_I_1:   OR2 port map ( O=>T_13, 
            I1=>T_168, 
            I0=>T_167 );
  GATE_T_14_I_1:   OR4 port map ( I0=>T_163, 
            I1=>T_164, 
            O=>T_14, 
            I2=>T_165, 
            I3=>T_166 );
  GATE_T_15_I_1:   OR4 port map ( I0=>T_159, 
            I1=>T_160, 
            O=>T_15, 
            I2=>T_161, 
            I3=>T_162 );
  GATE_DIS2e_D_I_1:   OR2 port map ( O=>DIS2e_D, 
            I1=>T_158, 
            I0=>DIP7PIN );
  GATE_T_16_I_1:   OR4 port map ( I0=>T_154, 
            I1=>T_155, 
            O=>T_16, 
            I2=>T_156, 
            I3=>T_157 );
  GATE_DIS2g_D_I_1:   OR3 port map ( O=>DIS2g_D, 
            I2=>T_152, 
            I1=>DIP7PIN, 
            I0=>T_153 );
  GATE_T_17_I_1:   AND2 port map ( O=>T_17, 
            I1=>dd7Q, 
            I0=>GATE_T_17_A );
  GATE_T_17_I_2:   INV port map ( O=>GATE_T_17_A, 
            I0=>DIP7PIN );
  GATE_T_18_I_1:   AND2 port map ( O=>T_18, 
            I1=>dd8Q, 
            I0=>GATE_T_18_A );
  GATE_T_18_I_2:   INV port map ( O=>GATE_T_18_A, 
            I0=>DIP7PIN );
  GATE_T_19_I_1:   AND2 port map ( O=>T_19, 
            I1=>dd9Q, 
            I0=>GATE_T_19_A );
  GATE_T_19_I_2:   INV port map ( O=>GATE_T_19_A, 
            I0=>DIP7PIN );
  GATE_T_20_I_1:   AND2 port map ( O=>T_20, 
            I1=>dd10Q, 
            I0=>GATE_T_20_A );
  GATE_T_20_I_2:   INV port map ( O=>GATE_T_20_A, 
            I0=>DIP7PIN );
  GATE_T_21_I_1:   AND2 port map ( O=>T_21, 
            I1=>dd11Q, 
            I0=>GATE_T_21_A );
  GATE_T_21_I_2:   INV port map ( O=>GATE_T_21_A, 
            I0=>DIP7PIN );
  GATE_T_22_I_1:   AND2 port map ( O=>T_22, 
            I1=>dd12Q, 
            I0=>GATE_T_22_A );
  GATE_T_22_I_2:   INV port map ( O=>GATE_T_22_A, 
            I0=>DIP7PIN );
  GATE_T_23_I_1:   AND2 port map ( O=>T_23, 
            I1=>dd13Q, 
            I0=>GATE_T_23_A );
  GATE_T_23_I_2:   INV port map ( O=>GATE_T_23_A, 
            I0=>DIP7PIN );
  GATE_T_24_I_1:   AND2 port map ( O=>T_24, 
            I1=>dd14Q, 
            I0=>GATE_T_24_A );
  GATE_T_24_I_2:   INV port map ( O=>GATE_T_24_A, 
            I0=>DIP7PIN );
  GATE_T_25_I_1:   AND2 port map ( O=>T_25, 
            I1=>dd15Q, 
            I0=>GATE_T_25_A );
  GATE_T_25_I_2:   INV port map ( O=>GATE_T_25_A, 
            I0=>DIP7PIN );
  GATE_T_26_I_1:   AND2 port map ( O=>T_26, 
            I1=>dd16Q, 
            I0=>GATE_T_26_A );
  GATE_T_26_I_2:   INV port map ( O=>GATE_T_26_A, 
            I0=>DIP7PIN );
  GATE_T_27_I_1:   AND2 port map ( O=>T_27, 
            I1=>dd17Q, 
            I0=>GATE_T_27_A );
  GATE_T_27_I_2:   INV port map ( O=>GATE_T_27_A, 
            I0=>DIP7PIN );
  GATE_T_28_I_1:   AND2 port map ( O=>T_28, 
            I1=>dd18Q, 
            I0=>GATE_T_28_A );
  GATE_T_28_I_2:   INV port map ( O=>GATE_T_28_A, 
            I0=>DIP7PIN );
  GATE_T_29_I_1:   AND2 port map ( O=>T_29, 
            I1=>dd19Q, 
            I0=>GATE_T_29_A );
  GATE_T_29_I_2:   INV port map ( O=>GATE_T_29_A, 
            I0=>DIP7PIN );
  GATE_T_30_I_1:   AND2 port map ( O=>T_30, 
            I1=>dd20Q, 
            I0=>GATE_T_30_A );
  GATE_T_30_I_2:   INV port map ( O=>GATE_T_30_A, 
            I0=>DIP7PIN );
  GATE_T_31_I_1:   AND3 port map ( O=>T_31, 
            I2=>T_404, 
            I1=>L16Q, 
            I0=>T_403 );
  GATE_LED17_I_1:   OR2 port map ( O=>LED17COM, 
            I1=>T_151, 
            I0=>T_150 );
  GATE_T_32_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_32, 
            I2=>Q2Q, 
            I3=>GATE_T_32_DN );
  GATE_T_32_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_32_DN );
  GATE_X0_T_I_1:   OR4 port map ( I0=>T_146, 
            I1=>T_147, 
            O=>X0_T, 
            I2=>T_148, 
            I3=>T_149 );
  GATE_Y0_D_I_1:   AND4 port map ( O=>Y0_D, 
            I3=>T_400, 
            I2=>T_401, 
            I1=>T_402, 
            I0=>GATE_Y0_D_A );
  GATE_Y0_D_I_2:   INV port map ( I0=>Y0Q, 
            O=>GATE_Y0_D_A );
  GATE_T_33_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_33, 
            I2=>Q2Q, 
            I3=>GATE_T_33_DN );
  GATE_T_33_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_33_DN );
  GATE_T_34_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_34, 
            I2=>Q2Q, 
            I3=>GATE_T_34_DN );
  GATE_T_34_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_34_DN );
  GATE_T_35_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_35, 
            I2=>Q2Q, 
            I3=>GATE_T_35_DN );
  GATE_T_35_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_35_DN );
  GATE_T_36_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_36, 
            I2=>Q2Q, 
            I3=>GATE_T_36_DN );
  GATE_T_36_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_36_DN );
  GATE_T_37_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_37, 
            I2=>Q2Q, 
            I3=>GATE_T_37_DN );
  GATE_T_37_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_37_DN );
  GATE_T_38_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_38, 
            I2=>Q2Q, 
            I3=>GATE_T_38_DN );
  GATE_T_38_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_38_DN );
  GATE_T_39_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_39, 
            I2=>Q2Q, 
            I3=>GATE_T_39_DN );
  GATE_T_39_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_39_DN );
  GATE_T_40_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_40, 
            I2=>Q2Q, 
            I3=>GATE_T_40_DN );
  GATE_T_40_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_40_DN );
  GATE_S1_AR_I_1:   INV port map ( I0=>S1_NCPIN, 
            O=>S1_AR );
  GATE_S1_AP_I_1:   INV port map ( I0=>S1_NOPIN, 
            O=>S1_AP );
  GATE_Q3_D_I_1:   OR4 port map ( I0=>T_365, 
            I1=>T_364, 
            O=>Q3_D, 
            I2=>T_363, 
            I3=>T_362 );
  GATE_Q2_D_X1_I_1:   OR3 port map ( O=>Q2_D_X1, 
            I2=>T_211, 
            I1=>T_212, 
            I0=>T_210 );
  GATE_Q1_D_X1_I_1:   OR3 port map ( O=>Q1_D_X1, 
            I2=>T_195, 
            I1=>T_196, 
            I0=>T_194 );
  GATE_Q1_D_X2_I_1:   INV port map ( I0=>Q3Q, 
            O=>GATE_Q1_D_X2_A );
  GATE_Q1_D_X2_I_2:   INV port map ( I0=>S2_NOPIN, 
            O=>GATE_Q1_D_X2_B );
  GATE_Q1_D_X2_I_3:   AND3 port map ( O=>Q1_D_X2, 
            I0=>Q1Q, 
            I2=>GATE_Q1_D_X2_A, 
            I1=>GATE_Q1_D_X2_B );
  GATE_Q0_D_X1_I_1:   OR3 port map ( O=>Q0_D_X1, 
            I2=>T_192, 
            I1=>T_193, 
            I0=>T_191 );
  GATE_Q0_D_X2_I_1:   INV port map ( I0=>Q3Q, 
            O=>GATE_Q0_D_X2_A );
  GATE_Q0_D_X2_I_2:   INV port map ( I0=>S2_NOPIN, 
            O=>GATE_Q0_D_X2_B );
  GATE_Q0_D_X2_I_3:   AND3 port map ( O=>Q0_D_X2, 
            I0=>Q0Q, 
            I2=>GATE_Q0_D_X2_A, 
            I1=>GATE_Q0_D_X2_B );
  GATE_P3_D_I_1:   OR3 port map ( O=>P3_D, 
            I2=>T_336, 
            I1=>T_337, 
            I0=>T_335 );
  GATE_P2_D_I_1:   OR4 port map ( I0=>T_303, 
            I1=>T_302, 
            O=>P2_D, 
            I2=>T_301, 
            I3=>T_300 );
  GATE_P1_D_I_1:   OR4 port map ( I0=>T_110, 
            I1=>T_262, 
            O=>P1_D, 
            I2=>T_261, 
            I3=>T_260 );
  GATE_T_41_I_1:   OR4 port map ( I0=>T_97, 
            I1=>T_247, 
            O=>T_41, 
            I2=>T_246, 
            I3=>T_245 );
  GATE_L16_D_I_1:   INV port map ( I0=>L16Q, 
            O=>L16_D );
  GATE_timediv_D_I_1:   INV port map ( I0=>timedivQ, 
            O=>timediv_D );
  GATE_timediv2_D_I_1:   INV port map ( I0=>timediv2Q, 
            O=>timediv2_D );
  GATE_dd7_D_I_1:   OR3 port map ( O=>dd7_D, 
            I2=>T_86, 
            I1=>T_85, 
            I0=>T_87 );
  GATE_dd8_D_I_1:   OR2 port map ( O=>dd8_D, 
            I1=>T_84, 
            I0=>T_83 );
  GATE_dd9_D_I_1:   OR4 port map ( I0=>T_79, 
            I1=>T_80, 
            O=>dd9_D, 
            I2=>T_81, 
            I3=>T_82 );
  GATE_dd10_D_I_1:   OR4 port map ( I0=>T_75, 
            I1=>T_76, 
            O=>dd10_D, 
            I2=>T_77, 
            I3=>T_78 );
  GATE_T_42_I_1:   OR2 port map ( O=>T_42, 
            I1=>T_74, 
            I0=>DIP7PIN );
  GATE_dd12_D_I_1:   OR4 port map ( I0=>T_70, 
            I1=>T_71, 
            O=>dd12_D, 
            I2=>T_72, 
            I3=>T_73 );
  GATE_T_43_I_1:   OR3 port map ( O=>T_43, 
            I2=>T_68, 
            I1=>DIP7PIN, 
            I0=>T_69 );
  GATE_dd14_D_I_1:   AND2 port map ( O=>dd14_D, 
            I1=>dd7Q, 
            I0=>GATE_dd14_D_A );
  GATE_dd14_D_I_2:   INV port map ( O=>GATE_dd14_D_A, 
            I0=>DIP7PIN );
  GATE_dd15_D_I_1:   AND2 port map ( O=>dd15_D, 
            I1=>dd8Q, 
            I0=>GATE_dd15_D_A );
  GATE_dd15_D_I_2:   INV port map ( O=>GATE_dd15_D_A, 
            I0=>DIP7PIN );
  GATE_dd16_D_I_1:   AND2 port map ( O=>dd16_D, 
            I1=>dd9Q, 
            I0=>GATE_dd16_D_A );
  GATE_dd16_D_I_2:   INV port map ( O=>GATE_dd16_D_A, 
            I0=>DIP7PIN );
  GATE_dd17_D_I_1:   AND2 port map ( O=>dd17_D, 
            I1=>dd10Q, 
            I0=>GATE_dd17_D_A );
  GATE_dd17_D_I_2:   INV port map ( O=>GATE_dd17_D_A, 
            I0=>DIP7PIN );
  GATE_dd18_D_I_1:   AND2 port map ( O=>dd18_D, 
            I1=>dd11Q, 
            I0=>GATE_dd18_D_A );
  GATE_dd18_D_I_2:   INV port map ( O=>GATE_dd18_D_A, 
            I0=>DIP7PIN );
  GATE_dd19_D_I_1:   AND2 port map ( O=>dd19_D, 
            I1=>dd12Q, 
            I0=>GATE_dd19_D_A );
  GATE_dd19_D_I_2:   INV port map ( O=>GATE_dd19_D_A, 
            I0=>DIP7PIN );
  GATE_dd20_D_I_1:   AND2 port map ( O=>dd20_D, 
            I1=>dd13Q, 
            I0=>GATE_dd20_D_A );
  GATE_dd20_D_I_2:   INV port map ( O=>GATE_dd20_D_A, 
            I0=>DIP7PIN );
  GATE_Q3_AR_I_1:   OR2 port map ( O=>Q3_AR, 
            I1=>T_129, 
            I0=>DIP7PIN );
  GATE_Q2_D_I_1:   XOR2 port map ( O=>GATE_Q2_D_Y, 
            I1=>Q2_D_X1, 
            I0=>Q3Q );
  GATE_Q2_D_I_2:   INV port map ( O=>Q2_D, 
            I0=>GATE_Q2_D_Y );
  GATE_Q1_D_I_1:   XOR2 port map ( O=>Q1_D, 
            I1=>Q1_D_X2, 
            I0=>Q1_D_X1 );
  GATE_Q0_D_I_1:   XOR2 port map ( O=>Q0_D, 
            I1=>Q0_D_X2, 
            I0=>Q0_D_X1 );
  GATE_LED0_I_1:   INV port map ( I0=>T_0, 
            O=>LED0COM );
  GATE_LED1_I_1:   INV port map ( I0=>T_1, 
            O=>LED1COM );
  GATE_LED2_I_1:   INV port map ( I0=>T_2, 
            O=>LED2COM );
  GATE_LED3_I_1:   INV port map ( I0=>T_3, 
            O=>LED3COM );
  GATE_LED4_I_1:   INV port map ( I0=>T_4, 
            O=>LED4COM );
  GATE_LED5_I_1:   INV port map ( I0=>T_5, 
            O=>LED5COM );
  GATE_LED6_I_1:   INV port map ( I0=>T_6, 
            O=>LED6COM );
  GATE_LED7_I_1:   INV port map ( I0=>T_7, 
            O=>LED7COM );
  GATE_DIS1a_I_1:   INV port map ( I0=>T_8, 
            O=>DIS1aCOM );
  GATE_DIS1b_I_1:   INV port map ( I0=>T_9, 
            O=>DIS1bCOM );
  GATE_DIS1c_I_1:   INV port map ( I0=>T_10, 
            O=>DIS1cCOM );
  GATE_DIS1d_I_1:   INV port map ( I0=>T_11, 
            O=>DIS1dCOM );
  GATE_DIS2a_D_I_1:   INV port map ( I0=>T_12, 
            O=>DIS2a_D );
  GATE_DIS2b_D_I_1:   INV port map ( I0=>T_13, 
            O=>DIS2b_D );
  GATE_DIS2c_D_I_1:   INV port map ( I0=>T_14, 
            O=>DIS2c_D );
  GATE_DIS2d_D_I_1:   INV port map ( I0=>T_15, 
            O=>DIS2d_D );
  GATE_DIS2f_D_I_1:   INV port map ( I0=>T_16, 
            O=>DIS2f_D );
  GATE_DIS3a_D_I_1:   INV port map ( I0=>T_17, 
            O=>DIS3a_D );
  GATE_DIS3b_D_I_1:   INV port map ( I0=>T_18, 
            O=>DIS3b_D );
  GATE_DIS3c_D_I_1:   INV port map ( I0=>T_19, 
            O=>DIS3c_D );
  GATE_DIS3d_D_I_1:   INV port map ( I0=>T_20, 
            O=>DIS3d_D );
  GATE_DIS3e_D_I_1:   INV port map ( I0=>T_21, 
            O=>DIS3e_D );
  GATE_DIS3f_D_I_1:   INV port map ( I0=>T_22, 
            O=>DIS3f_D );
  GATE_DIS3g_D_I_1:   INV port map ( I0=>T_23, 
            O=>DIS3g_D );
  GATE_DIS4a_D_I_1:   INV port map ( I0=>T_24, 
            O=>DIS4a_D );
  GATE_DIS4b_D_I_1:   INV port map ( I0=>T_25, 
            O=>DIS4b_D );
  GATE_DIS4c_D_I_1:   INV port map ( I0=>T_26, 
            O=>DIS4c_D );
  GATE_DIS4d_D_I_1:   INV port map ( I0=>T_27, 
            O=>DIS4d_D );
  GATE_DIS4e_D_I_1:   INV port map ( I0=>T_28, 
            O=>DIS4e_D );
  GATE_DIS4f_D_I_1:   INV port map ( I0=>T_29, 
            O=>DIS4f_D );
  GATE_DIS4g_D_I_1:   INV port map ( I0=>T_30, 
            O=>DIS4g_D );
  GATE_LED16_I_1:   INV port map ( I0=>T_31, 
            O=>LED16COM );
  GATE_LED18_I_1:   INV port map ( I0=>T_32, 
            O=>LED18COM );
  GATE_Y0_CE_I_1:   INV port map ( I0=>T_33, 
            O=>Y0_CE );
  GATE_Y1_CE_I_1:   INV port map ( I0=>T_34, 
            O=>Y1_CE );
  GATE_Y2_CE_I_1:   INV port map ( I0=>T_35, 
            O=>Y2_CE );
  GATE_Y3_CE_I_1:   INV port map ( I0=>T_36, 
            O=>Y3_CE );
  GATE_Y4_CE_I_1:   INV port map ( I0=>T_37, 
            O=>Y4_CE );
  GATE_Y5_CE_I_1:   INV port map ( I0=>T_38, 
            O=>Y5_CE );
  GATE_Y6_CE_I_1:   INV port map ( I0=>T_39, 
            O=>Y6_CE );
  GATE_Y7_CE_I_1:   INV port map ( I0=>T_40, 
            O=>Y7_CE );
  GATE_P0_T_I_1:   INV port map ( I0=>T_41, 
            O=>P0_T );
  GATE_dd11_D_I_1:   INV port map ( I0=>T_42, 
            O=>dd11_D );
  GATE_dd13_D_I_1:   INV port map ( I0=>T_43, 
            O=>dd13_D );
  GATE_T_44_I_1:   AND4 port map ( O=>T_44, 
            I3=>Q0Q, 
            I2=>Q1Q, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_45_I_1:   NOR4 port map ( I0=>Q2Q, 
            I1=>Q1Q, 
            O=>T_45, 
            I2=>Q3Q, 
            I3=>GATE_T_45_DN );
  GATE_T_45_I_2:   INV port map ( I0=>X1Q, 
            O=>GATE_T_45_DN );
  GATE_T_46_I_3:   AND4 port map ( O=>T_46, 
            I3=>Q2Q, 
            I2=>X5Q, 
            I1=>GATE_T_46_B, 
            I0=>GATE_T_46_A );
  GATE_T_46_I_2:   INV port map ( I0=>Q1Q, 
            O=>GATE_T_46_B );
  GATE_T_46_I_1:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_46_A );
  GATE_T_47_I_3:   AND4 port map ( O=>T_47, 
            I3=>Q1Q, 
            I2=>X3Q, 
            I1=>GATE_T_47_B, 
            I0=>GATE_T_47_A );
  GATE_T_47_I_2:   INV port map ( I0=>Q2Q, 
            O=>GATE_T_47_B );
  GATE_T_47_I_1:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_47_A );
  GATE_T_48_I_1:   AND4 port map ( O=>T_48, 
            I3=>Q1Q, 
            I2=>Q2Q, 
            I1=>X7Q, 
            I0=>GATE_T_48_A );
  GATE_T_48_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_48_A );
  GATE_T_49_I_1:   NOR2 port map ( O=>T_49, 
            I1=>Q0Q, 
            I0=>Q3Q );
  GATE_T_50_I_1:   AND3 port map ( O=>T_50, 
            I2=>T_208, 
            I1=>T_209, 
            I0=>T_207 );
  GATE_T_51_I_1:   AND3 port map ( O=>T_51, 
            I2=>T_205, 
            I1=>T_206, 
            I0=>T_204 );
  GATE_T_52_I_1:   AND3 port map ( O=>T_52, 
            I2=>T_202, 
            I1=>T_203, 
            I0=>T_201 );
  GATE_T_53_I_1:   AND3 port map ( O=>T_53, 
            I2=>T_200, 
            I1=>Q0Q, 
            I0=>T_199 );
  GATE_T_54_I_1:   INV port map ( I0=>Q1Q, 
            O=>GATE_T_54_A );
  GATE_T_54_I_2:   AND3 port map ( O=>T_54, 
            I2=>T_198, 
            I1=>T_197, 
            I0=>GATE_T_54_A );
  GATE_T_55_I_3:   AND4 port map ( O=>T_55, 
            I3=>Q1Q, 
            I2=>S2_NOPIN, 
            I1=>GATE_T_55_B, 
            I0=>GATE_T_55_A );
  GATE_T_55_I_2:   INV port map ( I0=>Q0Q, 
            O=>GATE_T_55_B );
  GATE_T_55_I_1:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_55_A );
  GATE_T_56_I_1:   AND4 port map ( O=>T_56, 
            I3=>Q0Q, 
            I2=>Q1Q, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_57_I_1:   AND4 port map ( O=>T_57, 
            I3=>Q0Q, 
            I2=>Q1Q, 
            I1=>Q2Q, 
            I0=>X7Q );
  GATE_T_58_I_1:   INV port map ( I0=>Q1Q, 
            O=>GATE_T_58_A );
  GATE_T_58_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_58_B );
  GATE_T_58_I_3:   AND3 port map ( O=>T_58, 
            I0=>Q0Q, 
            I2=>GATE_T_58_A, 
            I1=>GATE_T_58_B );
  GATE_T_59_I_1:   AND3 port map ( O=>T_59, 
            I2=>T_233, 
            I1=>T_234, 
            I0=>T_232 );
  GATE_T_60_I_1:   AND3 port map ( O=>T_60, 
            I2=>T_230, 
            I1=>T_231, 
            I0=>T_229 );
  GATE_T_61_I_1:   AND3 port map ( O=>T_61, 
            I2=>T_227, 
            I1=>T_228, 
            I0=>T_226 );
  GATE_T_62_I_1:   AND3 port map ( O=>T_62, 
            I2=>T_224, 
            I1=>T_225, 
            I0=>T_223 );
  GATE_T_63_I_1:   AND3 port map ( O=>T_63, 
            I2=>T_221, 
            I1=>T_222, 
            I0=>T_220 );
  GATE_T_64_I_1:   AND3 port map ( O=>T_64, 
            I2=>T_218, 
            I1=>T_219, 
            I0=>T_217 );
  GATE_T_65_I_1:   AND3 port map ( O=>T_65, 
            I2=>T_216, 
            I1=>Q0Q, 
            I0=>T_215 );
  GATE_T_66_I_1:   AND3 port map ( O=>T_66, 
            I2=>T_214, 
            I1=>Q0Q, 
            I0=>T_213 );
  GATE_T_67_I_1:   AND4 port map ( O=>T_67, 
            I3=>Q0Q, 
            I2=>Q1Q, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_68_I_3:   AND4 port map ( O=>T_68, 
            I3=>P0Q, 
            I2=>P1Q, 
            I1=>GATE_T_68_B, 
            I0=>GATE_T_68_A );
  GATE_T_68_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_68_B );
  GATE_T_68_I_1:   INV port map ( I0=>P3Q, 
            O=>GATE_T_68_A );
  GATE_T_69_I_1:   NOR3 port map ( O=>T_69, 
            I2=>P1Q, 
            I1=>P3Q, 
            I0=>P0Q );
  GATE_T_70_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_70, 
            I2=>P0Q, 
            I3=>GATE_T_70_DN );
  GATE_T_70_I_2:   INV port map ( I0=>P1Q, 
            O=>GATE_T_70_DN );
  GATE_T_71_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_71, 
            I2=>P0Q, 
            I3=>GATE_T_71_DN );
  GATE_T_71_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_71_DN );
  GATE_T_72_I_1:   NOR4 port map ( I0=>P2Q, 
            I1=>P1Q, 
            O=>T_72, 
            I2=>DIP7PIN, 
            I3=>GATE_T_72_DN );
  GATE_T_72_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_72_DN );
  GATE_T_73_I_1:   INV port map ( I0=>P2Q, 
            O=>GATE_T_73_A );
  GATE_T_73_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_73_B );
  GATE_T_73_I_3:   AND3 port map ( O=>T_73, 
            I0=>P0Q, 
            I2=>GATE_T_73_A, 
            I1=>GATE_T_73_B );
  GATE_T_74_I_1:   NOR3 port map ( O=>T_74, 
            I2=>P2Q, 
            I1=>P3Q, 
            I0=>P1Q );
  GATE_T_75_I_3:   AND4 port map ( O=>T_75, 
            I3=>P1Q, 
            I2=>P2Q, 
            I1=>GATE_T_75_B, 
            I0=>GATE_T_75_A );
  GATE_T_75_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_75_B );
  GATE_T_75_I_1:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_75_A );
  GATE_T_76_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_76, 
            I2=>P0Q, 
            I3=>GATE_T_76_DN );
  GATE_T_76_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_76_DN );
  GATE_T_77_I_1:   INV port map ( I0=>P2Q, 
            O=>GATE_T_77_A );
  GATE_T_77_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_77_B );
  GATE_T_77_I_3:   AND3 port map ( O=>T_77, 
            I0=>P0Q, 
            I2=>GATE_T_77_A, 
            I1=>GATE_T_77_B );
  GATE_T_78_I_1:   INV port map ( I0=>P3Q, 
            O=>GATE_T_78_A );
  GATE_T_78_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_78_B );
  GATE_T_78_I_3:   AND3 port map ( O=>T_78, 
            I0=>P1Q, 
            I2=>GATE_T_78_A, 
            I1=>GATE_T_78_B );
  GATE_T_79_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_79_A );
  GATE_T_79_I_2:   AND3 port map ( O=>T_79, 
            I2=>T_240, 
            I1=>T_239, 
            I0=>GATE_T_79_A );
  GATE_T_80_I_1:   AND3 port map ( O=>T_80, 
            I2=>T_238, 
            I1=>P0Q, 
            I0=>T_237 );
  GATE_T_81_I_1:   AND3 port map ( O=>T_81, 
            I2=>T_236, 
            I1=>P0Q, 
            I0=>T_235 );
  GATE_T_82_I_3:   AND4 port map ( O=>T_82, 
            I3=>P1Q, 
            I2=>P3Q, 
            I1=>GATE_T_82_B, 
            I0=>GATE_T_82_A );
  GATE_T_82_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_82_B );
  GATE_T_82_I_1:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_82_A );
  GATE_T_83_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_83_A );
  GATE_T_83_I_2:   AND3 port map ( O=>T_83, 
            I2=>T_244, 
            I1=>T_243, 
            I0=>GATE_T_83_A );
  GATE_T_84_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_84_A );
  GATE_T_84_I_2:   AND3 port map ( O=>T_84, 
            I2=>T_242, 
            I1=>T_241, 
            I0=>GATE_T_84_A );
  GATE_T_85_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_85, 
            I2=>P0Q, 
            I3=>GATE_T_85_DN );
  GATE_T_85_I_2:   INV port map ( I0=>P1Q, 
            O=>GATE_T_85_DN );
  GATE_T_86_I_1:   NOR4 port map ( I0=>P2Q, 
            I1=>P1Q, 
            O=>T_86, 
            I2=>DIP7PIN, 
            I3=>GATE_T_86_DN );
  GATE_T_86_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_86_DN );
  GATE_T_87_I_1:   INV port map ( I0=>P2Q, 
            O=>GATE_T_87_A );
  GATE_T_87_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_87_B );
  GATE_T_87_I_3:   AND3 port map ( O=>T_87, 
            I0=>P0Q, 
            I2=>GATE_T_87_A, 
            I1=>GATE_T_87_B );
  GATE_T_88_I_1:   AND4 port map ( O=>T_88, 
            I3=>T_257, 
            I2=>T_258, 
            I1=>T_259, 
            I0=>GATE_T_88_A );
  GATE_T_88_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_88_A );
  GATE_T_89_I_1:   AND4 port map ( O=>T_89, 
            I3=>T_254, 
            I2=>T_255, 
            I1=>T_256, 
            I0=>GATE_T_89_A );
  GATE_T_89_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_89_A );
  GATE_T_90_I_1:   AND3 port map ( O=>T_90, 
            I2=>T_252, 
            I1=>T_253, 
            I0=>T_251 );
  GATE_T_91_I_1:   AND3 port map ( O=>T_91, 
            I2=>T_249, 
            I1=>T_250, 
            I0=>T_248 );
  GATE_T_92_I_3:   AND4 port map ( O=>T_92, 
            I3=>P1Q, 
            I2=>P2Q, 
            I1=>GATE_T_92_B, 
            I0=>GATE_T_92_A );
  GATE_T_92_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_92_B );
  GATE_T_92_I_1:   INV port map ( I0=>P3Q, 
            O=>GATE_T_92_A );
  GATE_T_93_I_3:   AND4 port map ( O=>T_93, 
            I3=>P3Q, 
            I2=>Q2Q, 
            I1=>GATE_T_93_B, 
            I0=>GATE_T_93_A );
  GATE_T_93_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_93_B );
  GATE_T_93_I_1:   INV port map ( I0=>P2Q, 
            O=>GATE_T_93_A );
  GATE_T_94_I_3:   AND4 port map ( O=>T_94, 
            I3=>P2Q, 
            I2=>P3Q, 
            I1=>GATE_T_94_B, 
            I0=>GATE_T_94_A );
  GATE_T_94_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_94_B );
  GATE_T_94_I_1:   INV port map ( I0=>Q0Q, 
            O=>GATE_T_94_A );
  GATE_T_95_I_3:   AND4 port map ( O=>T_95, 
            I3=>P3Q, 
            I2=>Q0Q, 
            I1=>GATE_T_95_B, 
            I0=>GATE_T_95_A );
  GATE_T_95_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_95_B );
  GATE_T_95_I_1:   INV port map ( I0=>Q1Q, 
            O=>GATE_T_95_A );
  GATE_T_96_I_3:   AND4 port map ( O=>T_96, 
            I3=>P3Q, 
            I2=>Q1Q, 
            I1=>GATE_T_96_B, 
            I0=>GATE_T_96_A );
  GATE_T_96_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_96_B );
  GATE_T_96_I_1:   INV port map ( I0=>Q2Q, 
            O=>GATE_T_96_A );
  GATE_T_97_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_97_A );
  GATE_T_97_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_97_B );
  GATE_T_97_I_3:   AND3 port map ( O=>T_97, 
            I0=>P3Q, 
            I2=>GATE_T_97_A, 
            I1=>GATE_T_97_B );
  GATE_T_98_I_1:   AND4 port map ( O=>T_98, 
            I3=>T_296, 
            I2=>T_297, 
            I1=>T_298, 
            I0=>T_299 );
  GATE_T_99_I_1:   AND4 port map ( O=>T_99, 
            I3=>T_292, 
            I2=>T_293, 
            I1=>T_294, 
            I0=>T_295 );
  GATE_T_100_I_1:   AND4 port map ( O=>T_100, 
            I3=>T_288, 
            I2=>T_289, 
            I1=>T_290, 
            I0=>T_291 );
  GATE_T_101_I_1:   AND4 port map ( O=>T_101, 
            I3=>T_284, 
            I2=>T_285, 
            I1=>T_286, 
            I0=>T_287 );
  GATE_T_102_I_1:   AND4 port map ( O=>T_102, 
            I3=>T_280, 
            I2=>T_281, 
            I1=>T_282, 
            I0=>T_283 );
  GATE_T_103_I_1:   AND3 port map ( O=>T_103, 
            I2=>T_278, 
            I1=>T_279, 
            I0=>T_277 );
  GATE_T_104_I_1:   AND3 port map ( O=>T_104, 
            I2=>T_275, 
            I1=>T_276, 
            I0=>T_274 );
  GATE_T_105_I_1:   AND3 port map ( O=>T_105, 
            I2=>T_272, 
            I1=>T_273, 
            I0=>T_271 );
  GATE_T_106_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_106_A );
  GATE_T_106_I_2:   AND3 port map ( O=>T_106, 
            I2=>T_270, 
            I1=>T_269, 
            I0=>GATE_T_106_A );
  GATE_T_107_I_1:   AND3 port map ( O=>T_107, 
            I2=>T_268, 
            I1=>P0Q, 
            I0=>T_267 );
  GATE_T_108_I_1:   AND3 port map ( O=>T_108, 
            I2=>T_266, 
            I1=>P0Q, 
            I0=>T_265 );
  GATE_T_109_I_1:   AND3 port map ( O=>T_109, 
            I2=>T_264, 
            I1=>P0Q, 
            I0=>T_263 );
  GATE_T_110_I_1:   NOR4 port map ( I0=>Q3Q, 
            I1=>P3Q, 
            O=>T_110, 
            I2=>P1Q, 
            I3=>GATE_T_110_DN );
  GATE_T_110_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_110_DN );
  GATE_T_111_I_1:   AND4 port map ( O=>T_111, 
            I3=>T_331, 
            I2=>T_332, 
            I1=>T_333, 
            I0=>T_334 );
  GATE_T_112_I_1:   AND4 port map ( O=>T_112, 
            I3=>T_327, 
            I2=>T_328, 
            I1=>T_329, 
            I0=>T_330 );
  GATE_T_113_I_1:   AND4 port map ( O=>T_113, 
            I3=>T_324, 
            I2=>T_325, 
            I1=>T_326, 
            I0=>GATE_T_113_A );
  GATE_T_113_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_113_A );
  GATE_T_114_I_1:   AND4 port map ( O=>T_114, 
            I3=>T_321, 
            I2=>T_322, 
            I1=>T_323, 
            I0=>GATE_T_114_A );
  GATE_T_114_I_2:   INV port map ( I0=>P1Q, 
            O=>GATE_T_114_A );
  GATE_T_115_I_1:   AND3 port map ( O=>T_115, 
            I2=>T_319, 
            I1=>T_320, 
            I0=>T_318 );
  GATE_T_116_I_1:   AND3 port map ( O=>T_116, 
            I2=>T_316, 
            I1=>T_317, 
            I0=>T_315 );
  GATE_T_117_I_1:   AND3 port map ( O=>T_117, 
            I2=>T_313, 
            I1=>T_314, 
            I0=>T_312 );
  GATE_T_118_I_1:   AND3 port map ( O=>T_118, 
            I2=>T_311, 
            I1=>P0Q, 
            I0=>T_310 );
  GATE_T_119_I_1:   INV port map ( I0=>P1Q, 
            O=>GATE_T_119_A );
  GATE_T_119_I_2:   AND3 port map ( O=>T_119, 
            I2=>T_309, 
            I1=>T_308, 
            I0=>GATE_T_119_A );
  GATE_T_120_I_1:   INV port map ( I0=>P1Q, 
            O=>GATE_T_120_A );
  GATE_T_120_I_2:   AND3 port map ( O=>T_120, 
            I2=>T_307, 
            I1=>T_306, 
            I0=>GATE_T_120_A );
  GATE_T_121_I_1:   INV port map ( I0=>P1Q, 
            O=>GATE_T_121_A );
  GATE_T_121_I_2:   AND3 port map ( O=>T_121, 
            I2=>T_305, 
            I1=>T_304, 
            I0=>GATE_T_121_A );
  GATE_T_122_I_1:   NOR4 port map ( I0=>Q3Q, 
            I1=>P3Q, 
            O=>T_122, 
            I2=>P1Q, 
            I3=>GATE_T_122_DN );
  GATE_T_122_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_122_DN );
  GATE_T_123_I_1:   AND4 port map ( O=>T_123, 
            I3=>T_355, 
            I2=>T_356, 
            I1=>T_357, 
            I0=>T_358 );
  GATE_T_124_I_1:   AND4 port map ( O=>T_124, 
            I3=>T_351, 
            I2=>T_352, 
            I1=>T_353, 
            I0=>T_354 );
  GATE_T_125_I_1:   AND4 port map ( O=>T_125, 
            I3=>T_347, 
            I2=>T_348, 
            I1=>T_349, 
            I0=>T_350 );
  GATE_T_126_I_1:   AND4 port map ( O=>T_126, 
            I3=>T_344, 
            I2=>T_345, 
            I1=>T_346, 
            I0=>GATE_T_126_A );
  GATE_T_126_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_126_A );
  GATE_T_127_I_1:   AND4 port map ( O=>T_127, 
            I3=>T_341, 
            I2=>T_342, 
            I1=>T_343, 
            I0=>GATE_T_127_A );
  GATE_T_127_I_2:   INV port map ( I0=>P1Q, 
            O=>GATE_T_127_A );
  GATE_T_128_I_1:   AND4 port map ( O=>T_128, 
            I3=>T_338, 
            I2=>T_339, 
            I1=>T_340, 
            I0=>GATE_T_128_A );
  GATE_T_128_I_2:   INV port map ( I0=>P1Q, 
            O=>GATE_T_128_A );
  GATE_T_129_I_1:   AND3 port map ( O=>T_129, 
            I2=>T_360, 
            I1=>T_361, 
            I0=>T_359 );
  GATE_T_130_I_1:   AND3 port map ( O=>T_130, 
            I2=>T_398, 
            I1=>T_399, 
            I0=>T_397 );
  GATE_T_131_I_1:   AND3 port map ( O=>T_131, 
            I2=>T_395, 
            I1=>T_396, 
            I0=>T_394 );
  GATE_T_132_I_1:   AND3 port map ( O=>T_132, 
            I2=>T_392, 
            I1=>T_393, 
            I0=>T_391 );
  GATE_T_133_I_1:   AND3 port map ( O=>T_133, 
            I2=>T_389, 
            I1=>T_390, 
            I0=>T_388 );
  GATE_T_134_I_1:   AND3 port map ( O=>T_134, 
            I2=>T_386, 
            I1=>T_387, 
            I0=>T_385 );
  GATE_T_135_I_1:   AND3 port map ( O=>T_135, 
            I2=>T_383, 
            I1=>T_384, 
            I0=>T_382 );
  GATE_T_136_I_1:   INV port map ( I0=>Q0Q, 
            O=>GATE_T_136_A );
  GATE_T_136_I_2:   AND3 port map ( O=>T_136, 
            I2=>T_381, 
            I1=>T_380, 
            I0=>GATE_T_136_A );
  GATE_T_137_I_1:   INV port map ( I0=>Q0Q, 
            O=>GATE_T_137_A );
  GATE_T_137_I_2:   AND3 port map ( O=>T_137, 
            I2=>T_379, 
            I1=>T_378, 
            I0=>GATE_T_137_A );
  GATE_T_138_I_1:   AND3 port map ( O=>T_138, 
            I2=>T_377, 
            I1=>Q0Q, 
            I0=>T_376 );
  GATE_T_139_I_1:   AND3 port map ( O=>T_139, 
            I2=>T_375, 
            I1=>Q0Q, 
            I0=>T_374 );
  GATE_T_140_I_1:   AND3 port map ( O=>T_140, 
            I2=>T_373, 
            I1=>Q0Q, 
            I0=>T_372 );
  GATE_T_141_I_1:   AND3 port map ( O=>T_141, 
            I2=>T_371, 
            I1=>Q0Q, 
            I0=>T_370 );
  GATE_T_142_I_1:   AND3 port map ( O=>T_142, 
            I2=>T_369, 
            I1=>Q1Q, 
            I0=>T_368 );
  GATE_T_143_I_1:   AND3 port map ( O=>T_143, 
            I2=>T_367, 
            I1=>Q1Q, 
            I0=>T_366 );
  GATE_T_144_I_1:   NOR4 port map ( I0=>Q1Q, 
            I1=>Q0Q, 
            O=>T_144, 
            I2=>Q2Q, 
            I3=>GATE_T_144_DN );
  GATE_T_144_I_2:   INV port map ( I0=>Q3Q, 
            O=>GATE_T_144_DN );
  GATE_T_145_I_1:   AND3 port map ( O=>T_145, 
            I2=>Q1Q, 
            I1=>Q2Q, 
            I0=>Q0Q );
  GATE_T_146_I_1:   NOR3 port map ( O=>T_146, 
            I2=>X3Q, 
            I1=>X4Q, 
            I0=>X2Q );
  GATE_T_147_I_1:   INV port map ( I0=>X2Q, 
            O=>GATE_T_147_A );
  GATE_T_147_I_2:   AND3 port map ( O=>T_147, 
            I2=>X3Q, 
            I1=>X4Q, 
            I0=>GATE_T_147_A );
  GATE_T_148_I_1:   INV port map ( I0=>X3Q, 
            O=>GATE_T_148_A );
  GATE_T_148_I_2:   AND3 port map ( O=>T_148, 
            I2=>X4Q, 
            I1=>X2Q, 
            I0=>GATE_T_148_A );
  GATE_T_149_I_1:   INV port map ( I0=>X4Q, 
            O=>GATE_T_149_A );
  GATE_T_149_I_2:   AND3 port map ( O=>T_149, 
            I2=>X3Q, 
            I1=>X2Q, 
            I0=>GATE_T_149_A );
  GATE_T_150_I_1:   AND4 port map ( O=>T_150, 
            I3=>Q0Q, 
            I2=>Q1Q, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_151_I_1:   NOR3 port map ( O=>T_151, 
            I2=>Q1Q, 
            I1=>Q2Q, 
            I0=>Q0Q );
  GATE_T_152_I_3:   AND4 port map ( O=>T_152, 
            I3=>P0Q, 
            I2=>P1Q, 
            I1=>GATE_T_152_B, 
            I0=>GATE_T_152_A );
  GATE_T_152_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_152_B );
  GATE_T_152_I_1:   INV port map ( I0=>P3Q, 
            O=>GATE_T_152_A );
  GATE_T_153_I_1:   NOR3 port map ( O=>T_153, 
            I2=>P1Q, 
            I1=>P3Q, 
            I0=>P0Q );
  GATE_T_154_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_154, 
            I2=>P0Q, 
            I3=>GATE_T_154_DN );
  GATE_T_154_I_2:   INV port map ( I0=>P1Q, 
            O=>GATE_T_154_DN );
  GATE_T_155_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_155, 
            I2=>P0Q, 
            I3=>GATE_T_155_DN );
  GATE_T_155_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_155_DN );
  GATE_T_156_I_1:   NOR4 port map ( I0=>P2Q, 
            I1=>P1Q, 
            O=>T_156, 
            I2=>DIP7PIN, 
            I3=>GATE_T_156_DN );
  GATE_T_156_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_156_DN );
  GATE_T_157_I_1:   INV port map ( I0=>P2Q, 
            O=>GATE_T_157_A );
  GATE_T_157_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_157_B );
  GATE_T_157_I_3:   AND3 port map ( O=>T_157, 
            I0=>P0Q, 
            I2=>GATE_T_157_A, 
            I1=>GATE_T_157_B );
  GATE_T_158_I_1:   NOR3 port map ( O=>T_158, 
            I2=>P2Q, 
            I1=>P3Q, 
            I0=>P1Q );
  GATE_T_159_I_3:   AND4 port map ( O=>T_159, 
            I3=>P1Q, 
            I2=>P2Q, 
            I1=>GATE_T_159_B, 
            I0=>GATE_T_159_A );
  GATE_T_159_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_159_B );
  GATE_T_159_I_1:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_159_A );
  GATE_T_160_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_160, 
            I2=>P0Q, 
            I3=>GATE_T_160_DN );
  GATE_T_160_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_160_DN );
  GATE_T_161_I_1:   INV port map ( I0=>P2Q, 
            O=>GATE_T_161_A );
  GATE_T_161_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_161_B );
  GATE_T_161_I_3:   AND3 port map ( O=>T_161, 
            I0=>P0Q, 
            I2=>GATE_T_161_A, 
            I1=>GATE_T_161_B );
  GATE_T_162_I_1:   INV port map ( I0=>P3Q, 
            O=>GATE_T_162_A );
  GATE_T_162_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_162_B );
  GATE_T_162_I_3:   AND3 port map ( O=>T_162, 
            I0=>P1Q, 
            I2=>GATE_T_162_A, 
            I1=>GATE_T_162_B );
  GATE_T_163_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_163_A );
  GATE_T_163_I_2:   AND3 port map ( O=>T_163, 
            I2=>T_410, 
            I1=>T_409, 
            I0=>GATE_T_163_A );
  GATE_T_164_I_1:   AND3 port map ( O=>T_164, 
            I2=>T_408, 
            I1=>P0Q, 
            I0=>T_407 );
  GATE_T_165_I_1:   AND3 port map ( O=>T_165, 
            I2=>T_406, 
            I1=>P0Q, 
            I0=>T_405 );
  GATE_T_166_I_3:   AND4 port map ( O=>T_166, 
            I3=>P1Q, 
            I2=>P3Q, 
            I1=>GATE_T_166_B, 
            I0=>GATE_T_166_A );
  GATE_T_166_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_166_B );
  GATE_T_166_I_1:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_166_A );
  GATE_T_167_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_167_A );
  GATE_T_167_I_2:   AND3 port map ( O=>T_167, 
            I2=>T_414, 
            I1=>T_413, 
            I0=>GATE_T_167_A );
  GATE_T_168_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_168_A );
  GATE_T_168_I_2:   AND3 port map ( O=>T_168, 
            I2=>T_412, 
            I1=>T_411, 
            I0=>GATE_T_168_A );
  GATE_T_169_I_1:   NOR4 port map ( I0=>DIP7PIN, 
            I1=>P3Q, 
            O=>T_169, 
            I2=>P0Q, 
            I3=>GATE_T_169_DN );
  GATE_T_169_I_2:   INV port map ( I0=>P1Q, 
            O=>GATE_T_169_DN );
  GATE_T_170_I_1:   NOR4 port map ( I0=>P2Q, 
            I1=>P1Q, 
            O=>T_170, 
            I2=>DIP7PIN, 
            I3=>GATE_T_170_DN );
  GATE_T_170_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_170_DN );
  GATE_T_171_I_1:   INV port map ( I0=>P2Q, 
            O=>GATE_T_171_A );
  GATE_T_171_I_2:   INV port map ( I0=>DIP7PIN, 
            O=>GATE_T_171_B );
  GATE_T_171_I_3:   AND3 port map ( O=>T_171, 
            I0=>P0Q, 
            I2=>GATE_T_171_A, 
            I1=>GATE_T_171_B );
  GATE_T_172_I_3:   AND4 port map ( O=>T_172, 
            I3=>P0Q, 
            I2=>P1Q, 
            I1=>GATE_T_172_B, 
            I0=>GATE_T_172_A );
  GATE_T_172_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_172_B );
  GATE_T_172_I_1:   INV port map ( I0=>P3Q, 
            O=>GATE_T_172_A );
  GATE_T_173_I_1:   NOR3 port map ( O=>T_173, 
            I2=>P1Q, 
            I1=>P3Q, 
            I0=>P0Q );
  GATE_T_174_I_14:   NOR4 port map ( O=>T_174, 
            I3=>P0Q, 
            I2=>P1Q, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_175_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_175_A );
  GATE_T_175_I_2:   AND3 port map ( O=>T_175, 
            I2=>P1Q, 
            I1=>P3Q, 
            I0=>GATE_T_175_A );
  GATE_T_176_I_1:   AND2 port map ( O=>T_176, 
            I1=>P0Q, 
            I0=>P2Q );
  GATE_T_177_I_1:   AND2 port map ( O=>T_177, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_178_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_178_A );
  GATE_T_178_I_2:   AND3 port map ( O=>T_178, 
            I2=>P1Q, 
            I1=>P2Q, 
            I0=>GATE_T_178_A );
  GATE_T_179_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_179_A );
  GATE_T_179_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_179_B );
  GATE_T_179_I_3:   AND3 port map ( O=>T_179, 
            I0=>P2Q, 
            I2=>GATE_T_179_A, 
            I1=>GATE_T_179_B );
  GATE_T_180_I_1:   AND2 port map ( O=>T_180, 
            I1=>P0Q, 
            I0=>GATE_T_180_A );
  GATE_T_180_I_2:   INV port map ( O=>GATE_T_180_A, 
            I0=>P2Q );
  GATE_T_181_I_1:   AND2 port map ( O=>T_181, 
            I1=>P1Q, 
            I0=>GATE_T_181_A );
  GATE_T_181_I_2:   INV port map ( O=>GATE_T_181_A, 
            I0=>P3Q );
  GATE_T_182_I_1:   NOR4 port map ( I0=>P1Q, 
            I1=>P0Q, 
            O=>T_182, 
            I2=>P3Q, 
            I3=>GATE_T_182_DN );
  GATE_T_182_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_182_DN );
  GATE_T_183_I_1:   NOR4 port map ( I0=>P3Q, 
            I1=>P2Q, 
            O=>T_183, 
            I2=>P1Q, 
            I3=>GATE_T_183_DN );
  GATE_T_183_I_2:   INV port map ( I0=>P0Q, 
            O=>GATE_T_183_DN );
  GATE_T_184_I_1:   AND4 port map ( O=>T_184, 
            I3=>P0Q, 
            I2=>P1Q, 
            I1=>P2Q, 
            I0=>GATE_T_184_A );
  GATE_T_184_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_184_A );
  GATE_T_185_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_185_A );
  GATE_T_185_I_2:   AND3 port map ( O=>T_185, 
            I2=>P1Q, 
            I1=>P3Q, 
            I0=>GATE_T_185_A );
  GATE_T_186_I_1:   NOR4 port map ( I0=>P1Q, 
            I1=>P0Q, 
            O=>T_186, 
            I2=>P2Q, 
            I3=>GATE_T_186_DN );
  GATE_T_186_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_186_DN );
  GATE_T_187_I_1:   NOR4 port map ( I0=>P1Q, 
            I1=>P0Q, 
            O=>T_187, 
            I2=>P3Q, 
            I3=>GATE_T_187_DN );
  GATE_T_187_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_187_DN );
  GATE_T_188_I_1:   INV port map ( I0=>P0Q, 
            O=>GATE_T_188_A );
  GATE_T_188_I_2:   INV port map ( I0=>P3Q, 
            O=>GATE_T_188_B );
  GATE_T_188_I_3:   AND3 port map ( O=>T_188, 
            I0=>P1Q, 
            I2=>GATE_T_188_A, 
            I1=>GATE_T_188_B );
  GATE_T_189_I_1:   INV port map ( I0=>P1Q, 
            O=>GATE_T_189_A );
  GATE_T_189_I_2:   INV port map ( I0=>P2Q, 
            O=>GATE_T_189_B );
  GATE_T_189_I_3:   AND3 port map ( O=>T_189, 
            I0=>P3Q, 
            I2=>GATE_T_189_A, 
            I1=>GATE_T_189_B );
  GATE_T_190_I_1:   AND2 port map ( O=>T_190, 
            I1=>P0Q, 
            I0=>GATE_T_190_A );
  GATE_T_190_I_2:   INV port map ( O=>GATE_T_190_A, 
            I0=>P2Q );
  GATE_T_191_I_1:   OR2 port map ( O=>T_191, 
            I1=>T_49, 
            I0=>T_48 );
  GATE_T_192_I_1:   OR2 port map ( O=>T_192, 
            I1=>T_47, 
            I0=>T_46 );
  GATE_T_193_I_1:   OR2 port map ( O=>T_193, 
            I1=>T_45, 
            I0=>T_44 );
  GATE_T_194_I_1:   OR3 port map ( O=>T_194, 
            I2=>T_57, 
            I1=>T_56, 
            I0=>T_58 );
  GATE_T_195_I_1:   OR3 port map ( O=>T_195, 
            I2=>T_54, 
            I1=>T_53, 
            I0=>T_55 );
  GATE_T_196_I_1:   OR3 port map ( O=>T_196, 
            I2=>T_51, 
            I1=>T_50, 
            I0=>T_52 );
  GATE_T_197_I_1:   NOR2 port map ( O=>T_197, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_198_I_1:   AND2 port map ( O=>T_198, 
            I1=>S2_NOPIN, 
            I0=>X0Q );
  GATE_T_199_I_1:   AND2 port map ( O=>T_199, 
            I1=>Q1Q, 
            I0=>GATE_T_199_A );
  GATE_T_199_I_2:   INV port map ( O=>GATE_T_199_A, 
            I0=>Q2Q );
  GATE_T_200_I_1:   AND2 port map ( O=>T_200, 
            I1=>X3Q, 
            I0=>GATE_T_200_A );
  GATE_T_200_I_2:   INV port map ( O=>GATE_T_200_A, 
            I0=>Q3Q );
  GATE_T_201_I_1:   NOR2 port map ( O=>T_201, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_202_I_1:   AND2 port map ( O=>T_202, 
            I1=>Q2Q, 
            I0=>GATE_T_202_A );
  GATE_T_202_I_2:   INV port map ( O=>GATE_T_202_A, 
            I0=>Q3Q );
  GATE_T_203_I_1:   AND2 port map ( O=>T_203, 
            I1=>S2_NOPIN, 
            I0=>X4Q );
  GATE_T_204_I_1:   NOR2 port map ( O=>T_204, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_205_I_1:   AND2 port map ( O=>T_205, 
            I1=>Q2Q, 
            I0=>GATE_T_205_A );
  GATE_T_205_I_2:   INV port map ( O=>GATE_T_205_A, 
            I0=>Q3Q );
  GATE_T_206_I_1:   NOR2 port map ( O=>T_206, 
            I1=>S2_NOPIN, 
            I0=>X4Q );
  GATE_T_207_I_1:   NOR2 port map ( O=>T_207, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_208_I_1:   NOR2 port map ( O=>T_208, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_209_I_1:   NOR2 port map ( O=>T_209, 
            I1=>S2_NOPIN, 
            I0=>X0Q );
  GATE_T_210_I_1:   OR3 port map ( O=>T_210, 
            I2=>T_66, 
            I1=>T_65, 
            I0=>T_67 );
  GATE_T_211_I_1:   OR3 port map ( O=>T_211, 
            I2=>T_63, 
            I1=>T_62, 
            I0=>T_64 );
  GATE_T_212_I_1:   OR3 port map ( O=>T_212, 
            I2=>T_60, 
            I1=>T_59, 
            I0=>T_61 );
  GATE_T_213_I_1:   AND2 port map ( O=>T_213, 
            I1=>Q1Q, 
            I0=>Q2Q );
  GATE_T_214_I_1:   AND2 port map ( O=>T_214, 
            I1=>S2_NOPIN, 
            I0=>GATE_T_214_A );
  GATE_T_214_I_2:   INV port map ( O=>GATE_T_214_A, 
            I0=>X7Q );
  GATE_T_215_I_1:   AND2 port map ( O=>T_215, 
            I1=>Q1Q, 
            I0=>Q2Q );
  GATE_T_216_I_1:   AND2 port map ( O=>T_216, 
            I1=>X7Q, 
            I0=>GATE_T_216_A );
  GATE_T_216_I_2:   INV port map ( O=>GATE_T_216_A, 
            I0=>S2_NOPIN );
  GATE_T_217_I_1:   AND2 port map ( O=>T_217, 
            I1=>Q0Q, 
            I0=>GATE_T_217_A );
  GATE_T_217_I_2:   INV port map ( O=>GATE_T_217_A, 
            I0=>Q1Q );
  GATE_T_218_I_1:   NOR2 port map ( O=>T_218, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_219_I_1:   AND2 port map ( O=>T_219, 
            I1=>S2_NOPIN, 
            I0=>GATE_T_219_A );
  GATE_T_219_I_2:   INV port map ( O=>GATE_T_219_A, 
            I0=>X1Q );
  GATE_T_220_I_1:   AND2 port map ( O=>T_220, 
            I1=>Q0Q, 
            I0=>GATE_T_220_A );
  GATE_T_220_I_2:   INV port map ( O=>GATE_T_220_A, 
            I0=>Q1Q );
  GATE_T_221_I_1:   NOR2 port map ( O=>T_221, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_222_I_1:   AND2 port map ( O=>T_222, 
            I1=>X1Q, 
            I0=>GATE_T_222_A );
  GATE_T_222_I_2:   INV port map ( O=>GATE_T_222_A, 
            I0=>S2_NOPIN );
  GATE_T_223_I_1:   AND2 port map ( O=>T_223, 
            I1=>Q1Q, 
            I0=>GATE_T_223_A );
  GATE_T_223_I_2:   INV port map ( O=>GATE_T_223_A, 
            I0=>Q0Q );
  GATE_T_224_I_1:   NOR2 port map ( O=>T_224, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_225_I_1:   AND2 port map ( O=>T_225, 
            I1=>S2_NOPIN, 
            I0=>GATE_T_225_A );
  GATE_T_225_I_2:   INV port map ( O=>GATE_T_225_A, 
            I0=>X2Q );
  GATE_T_226_I_1:   AND2 port map ( O=>T_226, 
            I1=>Q1Q, 
            I0=>GATE_T_226_A );
  GATE_T_226_I_2:   INV port map ( O=>GATE_T_226_A, 
            I0=>Q0Q );
  GATE_T_227_I_1:   NOR2 port map ( O=>T_227, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_228_I_1:   AND2 port map ( O=>T_228, 
            I1=>X2Q, 
            I0=>GATE_T_228_A );
  GATE_T_228_I_2:   INV port map ( O=>GATE_T_228_A, 
            I0=>S2_NOPIN );
  GATE_T_229_I_1:   NOR2 port map ( O=>T_229, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_230_I_1:   NOR2 port map ( O=>T_230, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_231_I_1:   AND2 port map ( O=>T_231, 
            I1=>S2_NOPIN, 
            I0=>GATE_T_231_A );
  GATE_T_231_I_2:   INV port map ( O=>GATE_T_231_A, 
            I0=>X0Q );
  GATE_T_232_I_1:   NOR2 port map ( O=>T_232, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_233_I_1:   NOR2 port map ( O=>T_233, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_234_I_1:   AND2 port map ( O=>T_234, 
            I1=>X0Q, 
            I0=>GATE_T_234_A );
  GATE_T_234_I_2:   INV port map ( O=>GATE_T_234_A, 
            I0=>S2_NOPIN );
  GATE_T_235_I_1:   AND2 port map ( O=>T_235, 
            I1=>P1Q, 
            I0=>P2Q );
  GATE_T_236_I_1:   NOR2 port map ( O=>T_236, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_237_I_1:   NOR2 port map ( O=>T_237, 
            I1=>P1Q, 
            I0=>P2Q );
  GATE_T_238_I_1:   NOR2 port map ( O=>T_238, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_239_I_1:   AND2 port map ( O=>T_239, 
            I1=>P2Q, 
            I0=>GATE_T_239_A );
  GATE_T_239_I_2:   INV port map ( O=>GATE_T_239_A, 
            I0=>P1Q );
  GATE_T_240_I_1:   NOR2 port map ( O=>T_240, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_241_I_1:   AND2 port map ( O=>T_241, 
            I1=>P2Q, 
            I0=>GATE_T_241_A );
  GATE_T_241_I_2:   INV port map ( O=>GATE_T_241_A, 
            I0=>P1Q );
  GATE_T_242_I_1:   NOR2 port map ( O=>T_242, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_243_I_1:   NOR2 port map ( O=>T_243, 
            I1=>P1Q, 
            I0=>P2Q );
  GATE_T_244_I_1:   AND2 port map ( O=>T_244, 
            I1=>P3Q, 
            I0=>GATE_T_244_A );
  GATE_T_244_I_2:   INV port map ( O=>GATE_T_244_A, 
            I0=>DIP7PIN );
  GATE_T_245_I_1:   OR3 port map ( O=>T_245, 
            I2=>T_95, 
            I1=>T_94, 
            I0=>T_96 );
  GATE_T_246_I_1:   OR3 port map ( O=>T_246, 
            I2=>T_92, 
            I1=>T_91, 
            I0=>T_93 );
  GATE_T_247_I_1:   OR3 port map ( O=>T_247, 
            I2=>T_89, 
            I1=>T_88, 
            I0=>T_90 );
  GATE_T_248_I_1:   AND2 port map ( O=>T_248, 
            I1=>P2Q, 
            I0=>GATE_T_248_A );
  GATE_T_248_I_2:   INV port map ( O=>GATE_T_248_A, 
            I0=>P0Q );
  GATE_T_249_I_1:   NOR2 port map ( O=>T_249, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_250_I_1:   AND2 port map ( O=>T_250, 
            I1=>Q3Q, 
            I0=>GATE_T_250_A );
  GATE_T_250_I_2:   INV port map ( O=>GATE_T_250_A, 
            I0=>Q2Q );
  GATE_T_251_I_1:   AND2 port map ( O=>T_251, 
            I1=>P1Q, 
            I0=>GATE_T_251_A );
  GATE_T_251_I_2:   INV port map ( O=>GATE_T_251_A, 
            I0=>P0Q );
  GATE_T_252_I_1:   NOR2 port map ( O=>T_252, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_253_I_1:   AND2 port map ( O=>T_253, 
            I1=>Q3Q, 
            I0=>GATE_T_253_A );
  GATE_T_253_I_2:   INV port map ( O=>GATE_T_253_A, 
            I0=>Q2Q );
  GATE_T_254_I_1:   AND2 port map ( O=>T_254, 
            I1=>P2Q, 
            I0=>GATE_T_254_A );
  GATE_T_254_I_2:   INV port map ( O=>GATE_T_254_A, 
            I0=>P3Q );
  GATE_T_255_I_1:   AND2 port map ( O=>T_255, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_256_I_1:   AND2 port map ( O=>T_256, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_257_I_1:   AND2 port map ( O=>T_257, 
            I1=>P1Q, 
            I0=>GATE_T_257_A );
  GATE_T_257_I_2:   INV port map ( O=>GATE_T_257_A, 
            I0=>P3Q );
  GATE_T_258_I_1:   AND2 port map ( O=>T_258, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_259_I_1:   AND2 port map ( O=>T_259, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_260_I_1:   OR4 port map ( I0=>T_106, 
            I1=>T_107, 
            O=>T_260, 
            I2=>T_108, 
            I3=>T_109 );
  GATE_T_261_I_1:   OR4 port map ( I0=>T_102, 
            I1=>T_103, 
            O=>T_261, 
            I2=>T_104, 
            I3=>T_105 );
  GATE_T_262_I_1:   OR4 port map ( I0=>T_98, 
            I1=>T_99, 
            O=>T_262, 
            I2=>T_100, 
            I3=>T_101 );
  GATE_T_263_I_1:   NOR2 port map ( O=>T_263, 
            I1=>P1Q, 
            I0=>P3Q );
  GATE_T_264_I_1:   AND2 port map ( O=>T_264, 
            I1=>Q1Q, 
            I0=>GATE_T_264_A );
  GATE_T_264_I_2:   INV port map ( O=>GATE_T_264_A, 
            I0=>Q2Q );
  GATE_T_265_I_1:   NOR2 port map ( O=>T_265, 
            I1=>P1Q, 
            I0=>P3Q );
  GATE_T_266_I_1:   AND2 port map ( O=>T_266, 
            I1=>Q0Q, 
            I0=>GATE_T_266_A );
  GATE_T_266_I_2:   INV port map ( O=>GATE_T_266_A, 
            I0=>Q1Q );
  GATE_T_267_I_1:   NOR2 port map ( O=>T_267, 
            I1=>P1Q, 
            I0=>P3Q );
  GATE_T_268_I_1:   AND2 port map ( O=>T_268, 
            I1=>Q2Q, 
            I0=>GATE_T_268_A );
  GATE_T_268_I_2:   INV port map ( O=>GATE_T_268_A, 
            I0=>Q0Q );
  GATE_T_269_I_1:   AND2 port map ( O=>T_269, 
            I1=>P1Q, 
            I0=>GATE_T_269_A );
  GATE_T_269_I_2:   INV port map ( O=>GATE_T_269_A, 
            I0=>P2Q );
  GATE_T_270_I_1:   NOR2 port map ( O=>T_270, 
            I1=>P3Q, 
            I0=>Q3Q );
  GATE_T_271_I_1:   AND2 port map ( O=>T_271, 
            I1=>P1Q, 
            I0=>GATE_T_271_A );
  GATE_T_271_I_2:   INV port map ( O=>GATE_T_271_A, 
            I0=>P0Q );
  GATE_T_272_I_1:   NOR2 port map ( O=>T_272, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_273_I_1:   AND2 port map ( O=>T_273, 
            I1=>Q1Q, 
            I0=>GATE_T_273_A );
  GATE_T_273_I_2:   INV port map ( O=>GATE_T_273_A, 
            I0=>Q2Q );
  GATE_T_274_I_1:   AND2 port map ( O=>T_274, 
            I1=>P1Q, 
            I0=>GATE_T_274_A );
  GATE_T_274_I_2:   INV port map ( O=>GATE_T_274_A, 
            I0=>P0Q );
  GATE_T_275_I_1:   NOR2 port map ( O=>T_275, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_276_I_1:   AND2 port map ( O=>T_276, 
            I1=>Q0Q, 
            I0=>GATE_T_276_A );
  GATE_T_276_I_2:   INV port map ( O=>GATE_T_276_A, 
            I0=>Q1Q );
  GATE_T_277_I_1:   AND2 port map ( O=>T_277, 
            I1=>P1Q, 
            I0=>GATE_T_277_A );
  GATE_T_277_I_2:   INV port map ( O=>GATE_T_277_A, 
            I0=>P0Q );
  GATE_T_278_I_1:   NOR2 port map ( O=>T_278, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_279_I_1:   AND2 port map ( O=>T_279, 
            I1=>Q2Q, 
            I0=>GATE_T_279_A );
  GATE_T_279_I_2:   INV port map ( O=>GATE_T_279_A, 
            I0=>Q0Q );
  GATE_T_280_I_1:   AND2 port map ( O=>T_280, 
            I1=>P0Q, 
            I0=>GATE_T_280_A );
  GATE_T_280_I_2:   INV port map ( O=>GATE_T_280_A, 
            I0=>P1Q );
  GATE_T_281_I_1:   AND2 port map ( O=>T_281, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_282_I_1:   AND2 port map ( O=>T_282, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_283_I_1:   AND2 port map ( O=>T_283, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_284_I_1:   AND2 port map ( O=>T_284, 
            I1=>P0Q, 
            I0=>GATE_T_284_A );
  GATE_T_284_I_2:   INV port map ( O=>GATE_T_284_A, 
            I0=>P1Q );
  GATE_T_285_I_1:   AND2 port map ( O=>T_285, 
            I1=>P3Q, 
            I0=>GATE_T_285_A );
  GATE_T_285_I_2:   INV port map ( O=>GATE_T_285_A, 
            I0=>P2Q );
  GATE_T_286_I_1:   NOR2 port map ( O=>T_286, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_287_I_1:   AND2 port map ( O=>T_287, 
            I1=>Q3Q, 
            I0=>GATE_T_287_A );
  GATE_T_287_I_2:   INV port map ( O=>GATE_T_287_A, 
            I0=>Q2Q );
  GATE_T_288_I_1:   AND2 port map ( O=>T_288, 
            I1=>P1Q, 
            I0=>GATE_T_288_A );
  GATE_T_288_I_2:   INV port map ( O=>GATE_T_288_A, 
            I0=>P0Q );
  GATE_T_289_I_1:   AND2 port map ( O=>T_289, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_290_I_1:   AND2 port map ( O=>T_290, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_291_I_1:   AND2 port map ( O=>T_291, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_292_I_1:   NOR2 port map ( O=>T_292, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_293_I_1:   NOR2 port map ( O=>T_293, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_294_I_1:   AND2 port map ( O=>T_294, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_295_I_1:   AND2 port map ( O=>T_295, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_296_I_1:   NOR2 port map ( O=>T_296, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_297_I_1:   NOR2 port map ( O=>T_297, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_298_I_1:   NOR2 port map ( O=>T_298, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_299_I_1:   AND2 port map ( O=>T_299, 
            I1=>Q3Q, 
            I0=>GATE_T_299_A );
  GATE_T_299_I_2:   INV port map ( O=>GATE_T_299_A, 
            I0=>Q2Q );
  GATE_T_300_I_1:   OR3 port map ( O=>T_300, 
            I2=>T_121, 
            I1=>T_120, 
            I0=>T_122 );
  GATE_T_301_I_1:   OR3 port map ( O=>T_301, 
            I2=>T_118, 
            I1=>T_117, 
            I0=>T_119 );
  GATE_T_302_I_1:   OR3 port map ( O=>T_302, 
            I2=>T_115, 
            I1=>T_114, 
            I0=>T_116 );
  GATE_T_303_I_1:   OR3 port map ( O=>T_303, 
            I2=>T_112, 
            I1=>T_111, 
            I0=>T_113 );
  GATE_T_304_I_1:   AND2 port map ( O=>T_304, 
            I1=>P2Q, 
            I0=>GATE_T_304_A );
  GATE_T_304_I_2:   INV port map ( O=>GATE_T_304_A, 
            I0=>P3Q );
  GATE_T_305_I_1:   AND2 port map ( O=>T_305, 
            I1=>Q1Q, 
            I0=>GATE_T_305_A );
  GATE_T_305_I_2:   INV port map ( O=>GATE_T_305_A, 
            I0=>Q2Q );
  GATE_T_306_I_1:   AND2 port map ( O=>T_306, 
            I1=>P2Q, 
            I0=>GATE_T_306_A );
  GATE_T_306_I_2:   INV port map ( O=>GATE_T_306_A, 
            I0=>P3Q );
  GATE_T_307_I_1:   AND2 port map ( O=>T_307, 
            I1=>Q0Q, 
            I0=>GATE_T_307_A );
  GATE_T_307_I_2:   INV port map ( O=>GATE_T_307_A, 
            I0=>Q1Q );
  GATE_T_308_I_1:   AND2 port map ( O=>T_308, 
            I1=>P2Q, 
            I0=>GATE_T_308_A );
  GATE_T_308_I_2:   INV port map ( O=>GATE_T_308_A, 
            I0=>P3Q );
  GATE_T_309_I_1:   AND2 port map ( O=>T_309, 
            I1=>Q2Q, 
            I0=>GATE_T_309_A );
  GATE_T_309_I_2:   INV port map ( O=>GATE_T_309_A, 
            I0=>Q0Q );
  GATE_T_310_I_1:   AND2 port map ( O=>T_310, 
            I1=>P1Q, 
            I0=>GATE_T_310_A );
  GATE_T_310_I_2:   INV port map ( O=>GATE_T_310_A, 
            I0=>P2Q );
  GATE_T_311_I_1:   NOR2 port map ( O=>T_311, 
            I1=>P3Q, 
            I0=>Q3Q );
  GATE_T_312_I_1:   AND2 port map ( O=>T_312, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_313_I_1:   NOR2 port map ( O=>T_313, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_314_I_1:   AND2 port map ( O=>T_314, 
            I1=>Q1Q, 
            I0=>GATE_T_314_A );
  GATE_T_314_I_2:   INV port map ( O=>GATE_T_314_A, 
            I0=>Q2Q );
  GATE_T_315_I_1:   AND2 port map ( O=>T_315, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_316_I_1:   NOR2 port map ( O=>T_316, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_317_I_1:   AND2 port map ( O=>T_317, 
            I1=>Q0Q, 
            I0=>GATE_T_317_A );
  GATE_T_317_I_2:   INV port map ( O=>GATE_T_317_A, 
            I0=>Q1Q );
  GATE_T_318_I_1:   AND2 port map ( O=>T_318, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_319_I_1:   NOR2 port map ( O=>T_319, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_320_I_1:   AND2 port map ( O=>T_320, 
            I1=>Q2Q, 
            I0=>GATE_T_320_A );
  GATE_T_320_I_2:   INV port map ( O=>GATE_T_320_A, 
            I0=>Q0Q );
  GATE_T_321_I_1:   AND2 port map ( O=>T_321, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_322_I_1:   AND2 port map ( O=>T_322, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_323_I_1:   AND2 port map ( O=>T_323, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_324_I_1:   AND2 port map ( O=>T_324, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_325_I_1:   AND2 port map ( O=>T_325, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_326_I_1:   AND2 port map ( O=>T_326, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_327_I_1:   AND2 port map ( O=>T_327, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_328_I_1:   AND2 port map ( O=>T_328, 
            I1=>P3Q, 
            I0=>GATE_T_328_A );
  GATE_T_328_I_2:   INV port map ( O=>GATE_T_328_A, 
            I0=>P2Q );
  GATE_T_329_I_1:   AND2 port map ( O=>T_329, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_330_I_1:   AND2 port map ( O=>T_330, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_331_I_1:   NOR2 port map ( O=>T_331, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_332_I_1:   NOR2 port map ( O=>T_332, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_333_I_1:   NOR2 port map ( O=>T_333, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_334_I_1:   AND2 port map ( O=>T_334, 
            I1=>Q3Q, 
            I0=>GATE_T_334_A );
  GATE_T_334_I_2:   INV port map ( O=>GATE_T_334_A, 
            I0=>Q2Q );
  GATE_T_335_I_1:   OR2 port map ( O=>T_335, 
            I1=>T_128, 
            I0=>T_127 );
  GATE_T_336_I_1:   OR2 port map ( O=>T_336, 
            I1=>T_126, 
            I0=>T_125 );
  GATE_T_337_I_1:   OR2 port map ( O=>T_337, 
            I1=>T_124, 
            I0=>T_123 );
  GATE_T_338_I_1:   AND2 port map ( O=>T_338, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_339_I_1:   AND2 port map ( O=>T_339, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_340_I_1:   AND2 port map ( O=>T_340, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_341_I_1:   AND2 port map ( O=>T_341, 
            I1=>P3Q, 
            I0=>GATE_T_341_A );
  GATE_T_341_I_2:   INV port map ( O=>GATE_T_341_A, 
            I0=>P2Q );
  GATE_T_342_I_1:   NOR2 port map ( O=>T_342, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_343_I_1:   AND2 port map ( O=>T_343, 
            I1=>Q3Q, 
            I0=>GATE_T_343_A );
  GATE_T_343_I_2:   INV port map ( O=>GATE_T_343_A, 
            I0=>Q2Q );
  GATE_T_344_I_1:   AND2 port map ( O=>T_344, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_345_I_1:   AND2 port map ( O=>T_345, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_346_I_1:   AND2 port map ( O=>T_346, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_347_I_1:   AND2 port map ( O=>T_347, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_348_I_1:   AND2 port map ( O=>T_348, 
            I1=>P2Q, 
            I0=>GATE_T_348_A );
  GATE_T_348_I_2:   INV port map ( O=>GATE_T_348_A, 
            I0=>P3Q );
  GATE_T_349_I_1:   NOR2 port map ( O=>T_349, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_350_I_1:   AND2 port map ( O=>T_350, 
            I1=>Q3Q, 
            I0=>GATE_T_350_A );
  GATE_T_350_I_2:   INV port map ( O=>GATE_T_350_A, 
            I0=>Q2Q );
  GATE_T_351_I_1:   AND2 port map ( O=>T_351, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_352_I_1:   AND2 port map ( O=>T_352, 
            I1=>P3Q, 
            I0=>GATE_T_352_A );
  GATE_T_352_I_2:   INV port map ( O=>GATE_T_352_A, 
            I0=>P2Q );
  GATE_T_353_I_1:   AND2 port map ( O=>T_353, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_354_I_1:   AND2 port map ( O=>T_354, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_355_I_1:   NOR2 port map ( O=>T_355, 
            I1=>P0Q, 
            I0=>P1Q );
  GATE_T_356_I_1:   NOR2 port map ( O=>T_356, 
            I1=>P2Q, 
            I0=>P3Q );
  GATE_T_357_I_1:   AND2 port map ( O=>T_357, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_358_I_1:   AND2 port map ( O=>T_358, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_359_I_1:   NOR2 port map ( O=>T_359, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_360_I_1:   AND2 port map ( O=>T_360, 
            I1=>Q3Q, 
            I0=>GATE_T_360_A );
  GATE_T_360_I_2:   INV port map ( O=>GATE_T_360_A, 
            I0=>Q2Q );
  GATE_T_361_I_1:   AND2 port map ( O=>T_361, 
            I1=>DIP2PIN, 
            I0=>S1Q );
  GATE_T_362_I_1:   OR4 port map ( I0=>T_142, 
            I1=>T_143, 
            O=>T_362, 
            I2=>T_144, 
            I3=>T_145 );
  GATE_T_363_I_1:   OR4 port map ( I0=>T_138, 
            I1=>T_139, 
            O=>T_363, 
            I2=>T_140, 
            I3=>T_141 );
  GATE_T_364_I_1:   OR4 port map ( I0=>T_134, 
            I1=>T_135, 
            O=>T_364, 
            I2=>T_136, 
            I3=>T_137 );
  GATE_T_365_I_1:   OR4 port map ( I0=>T_130, 
            I1=>T_131, 
            O=>T_365, 
            I2=>T_132, 
            I3=>T_133 );
  GATE_T_366_I_1:   AND2 port map ( O=>T_366, 
            I1=>Q2Q, 
            I0=>GATE_T_366_A );
  GATE_T_366_I_2:   INV port map ( O=>GATE_T_366_A, 
            I0=>Q3Q );
  GATE_T_367_I_1:   AND2 port map ( O=>T_367, 
            I1=>S2_NOPIN, 
            I0=>X6Q );
  GATE_T_368_I_1:   AND2 port map ( O=>T_368, 
            I1=>Q2Q, 
            I0=>GATE_T_368_A );
  GATE_T_368_I_2:   INV port map ( O=>GATE_T_368_A, 
            I0=>Q3Q );
  GATE_T_369_I_1:   NOR2 port map ( O=>T_369, 
            I1=>S2_NOPIN, 
            I0=>X6Q );
  GATE_T_370_I_1:   AND2 port map ( O=>T_370, 
            I1=>Q2Q, 
            I0=>GATE_T_370_A );
  GATE_T_370_I_2:   INV port map ( O=>GATE_T_370_A, 
            I0=>Q3Q );
  GATE_T_371_I_1:   AND2 port map ( O=>T_371, 
            I1=>S2_NOPIN, 
            I0=>X5Q );
  GATE_T_372_I_1:   AND2 port map ( O=>T_372, 
            I1=>Q2Q, 
            I0=>GATE_T_372_A );
  GATE_T_372_I_2:   INV port map ( O=>GATE_T_372_A, 
            I0=>Q3Q );
  GATE_T_373_I_1:   NOR2 port map ( O=>T_373, 
            I1=>S2_NOPIN, 
            I0=>X5Q );
  GATE_T_374_I_1:   AND2 port map ( O=>T_374, 
            I1=>Q1Q, 
            I0=>GATE_T_374_A );
  GATE_T_374_I_2:   INV port map ( O=>GATE_T_374_A, 
            I0=>Q3Q );
  GATE_T_375_I_1:   AND2 port map ( O=>T_375, 
            I1=>S2_NOPIN, 
            I0=>X3Q );
  GATE_T_376_I_1:   AND2 port map ( O=>T_376, 
            I1=>Q1Q, 
            I0=>GATE_T_376_A );
  GATE_T_376_I_2:   INV port map ( O=>GATE_T_376_A, 
            I0=>Q3Q );
  GATE_T_377_I_1:   NOR2 port map ( O=>T_377, 
            I1=>S2_NOPIN, 
            I0=>X3Q );
  GATE_T_378_I_1:   NOR2 port map ( O=>T_378, 
            I1=>Q1Q, 
            I0=>Q2Q );
  GATE_T_379_I_1:   AND2 port map ( O=>T_379, 
            I1=>S2_NOPIN, 
            I0=>X0Q );
  GATE_T_380_I_1:   NOR2 port map ( O=>T_380, 
            I1=>Q1Q, 
            I0=>Q2Q );
  GATE_T_381_I_1:   NOR2 port map ( O=>T_381, 
            I1=>S2_NOPIN, 
            I0=>X0Q );
  GATE_T_382_I_1:   AND2 port map ( O=>T_382, 
            I1=>Q0Q, 
            I0=>GATE_T_382_A );
  GATE_T_382_I_2:   INV port map ( O=>GATE_T_382_A, 
            I0=>Q1Q );
  GATE_T_383_I_1:   NOR2 port map ( O=>T_383, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_384_I_1:   AND2 port map ( O=>T_384, 
            I1=>S2_NOPIN, 
            I0=>X1Q );
  GATE_T_385_I_1:   AND2 port map ( O=>T_385, 
            I1=>Q0Q, 
            I0=>GATE_T_385_A );
  GATE_T_385_I_2:   INV port map ( O=>GATE_T_385_A, 
            I0=>Q1Q );
  GATE_T_386_I_1:   NOR2 port map ( O=>T_386, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_387_I_1:   NOR2 port map ( O=>T_387, 
            I1=>S2_NOPIN, 
            I0=>X1Q );
  GATE_T_388_I_1:   AND2 port map ( O=>T_388, 
            I1=>Q1Q, 
            I0=>GATE_T_388_A );
  GATE_T_388_I_2:   INV port map ( O=>GATE_T_388_A, 
            I0=>Q0Q );
  GATE_T_389_I_1:   NOR2 port map ( O=>T_389, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_390_I_1:   AND2 port map ( O=>T_390, 
            I1=>S2_NOPIN, 
            I0=>X2Q );
  GATE_T_391_I_1:   AND2 port map ( O=>T_391, 
            I1=>Q1Q, 
            I0=>GATE_T_391_A );
  GATE_T_391_I_2:   INV port map ( O=>GATE_T_391_A, 
            I0=>Q0Q );
  GATE_T_392_I_1:   NOR2 port map ( O=>T_392, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_393_I_1:   NOR2 port map ( O=>T_393, 
            I1=>S2_NOPIN, 
            I0=>X2Q );
  GATE_T_394_I_1:   NOR2 port map ( O=>T_394, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_395_I_1:   AND2 port map ( O=>T_395, 
            I1=>Q2Q, 
            I0=>GATE_T_395_A );
  GATE_T_395_I_2:   INV port map ( O=>GATE_T_395_A, 
            I0=>Q3Q );
  GATE_T_396_I_1:   AND2 port map ( O=>T_396, 
            I1=>S2_NOPIN, 
            I0=>X4Q );
  GATE_T_397_I_1:   NOR2 port map ( O=>T_397, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_398_I_1:   AND2 port map ( O=>T_398, 
            I1=>Q2Q, 
            I0=>GATE_T_398_A );
  GATE_T_398_I_2:   INV port map ( O=>GATE_T_398_A, 
            I0=>Q3Q );
  GATE_T_399_I_1:   NOR2 port map ( O=>T_399, 
            I1=>S2_NOPIN, 
            I0=>X4Q );
  GATE_T_400_I_1:   NOR2 port map ( O=>T_400, 
            I1=>Y1Q, 
            I0=>Y2Q );
  GATE_T_401_I_1:   NOR2 port map ( O=>T_401, 
            I1=>Y3Q, 
            I0=>Y4Q );
  GATE_T_402_I_1:   NOR2 port map ( O=>T_402, 
            I1=>Y5Q, 
            I0=>Y6Q );
  GATE_T_403_I_1:   AND2 port map ( O=>T_403, 
            I1=>Q0Q, 
            I0=>Q1Q );
  GATE_T_404_I_1:   AND2 port map ( O=>T_404, 
            I1=>Q2Q, 
            I0=>Q3Q );
  GATE_T_405_I_1:   AND2 port map ( O=>T_405, 
            I1=>P1Q, 
            I0=>P2Q );
  GATE_T_406_I_1:   NOR2 port map ( O=>T_406, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_407_I_1:   NOR2 port map ( O=>T_407, 
            I1=>P1Q, 
            I0=>P2Q );
  GATE_T_408_I_1:   NOR2 port map ( O=>T_408, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_409_I_1:   AND2 port map ( O=>T_409, 
            I1=>P2Q, 
            I0=>GATE_T_409_A );
  GATE_T_409_I_2:   INV port map ( O=>GATE_T_409_A, 
            I0=>P1Q );
  GATE_T_410_I_1:   NOR2 port map ( O=>T_410, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_411_I_1:   AND2 port map ( O=>T_411, 
            I1=>P2Q, 
            I0=>GATE_T_411_A );
  GATE_T_411_I_2:   INV port map ( O=>GATE_T_411_A, 
            I0=>P1Q );
  GATE_T_412_I_1:   NOR2 port map ( O=>T_412, 
            I1=>P3Q, 
            I0=>DIP7PIN );
  GATE_T_413_I_1:   NOR2 port map ( O=>T_413, 
            I1=>P1Q, 
            I0=>P2Q );
  GATE_T_414_I_1:   AND2 port map ( O=>T_414, 
            I1=>P3Q, 
            I0=>GATE_T_414_A );
  GATE_T_414_I_2:   INV port map ( O=>GATE_T_414_A, 
            I0=>DIP7PIN );

end NetList;
