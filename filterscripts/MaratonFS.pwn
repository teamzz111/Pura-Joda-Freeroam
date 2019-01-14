/*	-----------------------------------------
	|          Maraton (Minijuego)           |
	|   Map By: [EkZ]HolacheJr (Pura Joda)   |
	|   Script: 43z (ForTrezZ) (Pura Joda)   |
	|   Para: Pura Joda FreeroaM             |
	|   Conservar Creditos...                |
	-----------------------------------------   */

#include <a_samp>
#include <streamer>

new PlayersJugando[10] = { INVALID_PLAYER_ID, INVALID_PLAYER_ID, INVALID_PLAYER_ID, INVALID_PLAYER_ID, INVALID_PLAYER_ID, INVALID_PLAYER_ID, INVALID_PLAYER_ID, INVALID_PLAYER_ID, INVALID_PLAYER_ID ,INVALID_PLAYER_ID },
	Jugando[MAX_PLAYERS],
	bool:EnJuego = false,
	bool:ConteoYa = false,
	bool:FinMaraton = false,
	bool:YaMaraton = true,
	TimerMaraton,
	Count = 0,
	MaratonV[10],
	MCPProgress[MAX_PLAYERS],
	MPosision = 0,
	Conteo = 1,
	Conteo2 = 5;

enum Timers
{
	tMaratonON,
	tFinMaraton,
	tCount
};
new FTzTimer[Timers];
new Float:MaratonPlayersSpawn[10][3] = {
	{-735.0628, -877.9500, 116.9225},
	{-733.5282, -879.8613, 116.9225},
	{-735.8125, -878.5482, 116.9225},
	{-734.1529, -880.3923, 116.9225},
	{-736.4683, -879.1367, 116.9225},
	{-734.8072, -880.9820, 116.9225},
	{-737.1111, -879.7698, 116.9225},
	{-735.4650, -881.5979, 116.9225},
	{-737.7776, -880.4368, 116.9225},
	{-736.1821, -882.2308, 116.9225}
};

new Float:MaratonCP[10][3] = {
	{-690.4501, -834.8427, 101.8755},
	{-645.7204, -765.9174, 70.9295},
	{-607.4532, -717.4679, 55.8301},
	{-554.5042, -716.1923, 27.5240},
	{-320.0933, -712.6195, 53.3668},
	{-296.5722, -708.7374, -0.3947},
	{-252.0401, -682.5684, -0.3947},
	{-115.9776, -886.7798, -0.3947},
	{4.6160, -912.5621, -0.3947},
	{99.5679, -911.5334, 0.1937}
};

//Macros
#define fTimer%0(%1) forward%0(%1); public%0(%1)
//Colores
#define rojo 0xFF0000FF
#define azul 0x0000FFFF
#define verde 0x00FF00FF
#define negro 0x000000FF
#define blanco 0xFFFFFFFF
#define TIME_MARATON 300000
//DCMD
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
//Otros
#define CHECKCP_SIZE 10.0
#define MaratonWorldId 4

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" -- > Maraton (Minijuego) Loading...");
	print("--------------------------------------\n");
	CreateDynamicObject(5154, -734.13, -878.33, 112.82,   0.00, 0.00, 41.07, MaratonWorldId);
	CreateDynamicObject(987, -655.37, -807.24, 89.33,   1.00, 31.00, 63.00, MaratonWorldId);
	CreateDynamicObject(987, -718.28, -875.04, 110.41,   0.00, 0.00, 45.98, MaratonWorldId);
	CreateDynamicObject(987, -668.50, -798.21, 90.65,   2.00, 23.00, 52.83, MaratonWorldId);
	CreateDynamicObject(987, -702.99, -860.25, 108.03,   0.00, 12.00, 44.22, MaratonWorldId);
	CreateDynamicObject(987, -694.89, -852.64, 105.24,   0.00, 12.00, 44.22, MaratonWorldId);
	CreateDynamicObject(987, -686.86, -844.96, 103.05,   0.00, 12.00, 44.65, MaratonWorldId);
	CreateDynamicObject(987, -679.19, -837.49, 100.74,   0.00, 12.00, 44.65, MaratonWorldId);
	CreateDynamicObject(987, -735.83, -866.62, 111.64,   0.00, 0.00, 41.69, MaratonWorldId);
	CreateDynamicObject(987, -725.91, -883.02, 110.38,   0.00, 0.00, 47.03, MaratonWorldId);
	CreateDynamicObject(987, -710.66, -867.41, 110.33,   0.00, 12.00, 44.22, MaratonWorldId);
	CreateDynamicObject(987, -728.16, -859.90, 112.31,   0.00, 12.00, 46.64, MaratonWorldId);
	CreateDynamicObject(987, -720.20, -851.52, 110.03,   0.00, 12.00, 45.92, MaratonWorldId);
	CreateDynamicObject(987, -712.17, -843.05, 107.50,   0.00, 12.00, 45.92, MaratonWorldId);
	CreateDynamicObject(987, -704.15, -834.94, 105.12,   0.00, 12.00, 45.72, MaratonWorldId);
	CreateDynamicObject(987, -696.21, -826.75, 102.72,   0.00, 12.00, 45.72, MaratonWorldId);
	CreateDynamicObject(987, -671.71, -830.48, 98.46,   0.00, 12.00, 44.65, MaratonWorldId);
	CreateDynamicObject(987, -663.22, -822.80, 96.01,   0.00, 12.00, 62.52, MaratonWorldId);
	CreateDynamicObject(987, -659.16, -815.01, 94.87,   1.00, 31.00, 63.00, MaratonWorldId);
	CreateDynamicObject(987, -688.26, -818.37, 100.15,   0.00, 12.00, 45.72, MaratonWorldId);
	CreateDynamicObject(13644, -723.25, -862.53, 112.63,   7.00, 0.00, 134.00, MaratonWorldId);
	CreateDynamicObject(13644, -722.55, -871.40, 112.43,   0.00, 0.00, 133.71, MaratonWorldId);
	CreateDynamicObject(13644, -712.88, -852.95, 110.32,   17.00, 0.00, 133.59, MaratonWorldId);
	CreateDynamicObject(3270, -687.74, -835.84, 101.74,   -8.00, 1.00, 325.00, MaratonWorldId);
	CreateDynamicObject(13644, -702.42, -852.24, 107.65,   17.00, 0.00, 134.00, MaratonWorldId);
	CreateDynamicObject(13644, -712.43, -861.82, 110.78,   17.00, 0.00, 134.00, MaratonWorldId);
	CreateDynamicObject(18609, -665.93, -811.56, 95.05,   0.00, 0.00, 55.78, MaratonWorldId);
	CreateDynamicObject(987, -675.05, -805.46, 93.73,   0.00, 12.00, 46.50, MaratonWorldId);
	CreateDynamicObject(18609, -663.08, -803.51, 91.34,   0.00, 0.00, 58.00, MaratonWorldId);
	CreateDynamicObject(987, -680.23, -809.78, 97.59,   0.00, 12.00, 40.86, MaratonWorldId);
	CreateDynamicObject(18609, -668.75, -806.59, 93.71,   0.00, 0.00, 59.31, MaratonWorldId);
	CreateDynamicObject(18609, -662.63, -806.91, 92.63,   0.00, 0.00, 58.51, MaratonWorldId);
	CreateDynamicObject(18609, -656.86, -807.71, 91.82,   0.00, 0.00, 58.51, MaratonWorldId);
	CreateDynamicObject(18609, -657.00, -811.02, 92.93,   0.00, 0.00, 58.61, MaratonWorldId);
	CreateDynamicObject(18609, -666.08, -802.74, 92.19,   0.00, 0.00, 58.51, MaratonWorldId);
	CreateDynamicObject(18609, -667.01, -805.65, 93.10,   0.00, 0.00, 58.51, MaratonWorldId);
	CreateDynamicObject(18609, -664.78, -809.02, 93.54,   0.00, 0.00, 56.36, MaratonWorldId);
	CreateDynamicObject(18609, -660.18, -811.07, 93.44,   0.00, 0.00, 58.61, MaratonWorldId);
	CreateDynamicObject(18609, -658.49, -814.33, 95.07,   0.00, 0.00, 55.78, MaratonWorldId);
	CreateDynamicObject(3569, -656.69, -792.75, 86.46,   0.00, 2.00, 52.14, MaratonWorldId);
	CreateDynamicObject(3569, -659.89, -797.51, 86.83,   1.00, 33.00, 53.00, MaratonWorldId);
	CreateDynamicObject(3569, -658.09, -795.34, 87.03,   1.00, 33.00, 53.00, MaratonWorldId);
	CreateDynamicObject(4354, -299.89, -595.70, -34.48,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(19543, 123.03, -905.84, 0.52,   0.00, 0.00, 2.15, MaratonWorldId);
	CreateDynamicObject(19543, 96.33, -916.62, 0.52,   0.00, 0.00, 2.15, MaratonWorldId);
	CreateDynamicObject(7586, 129.66, -923.85, 4.11,   1.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(7586, 128.50, -892.05, 4.11,   1.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(8397, 125.40, -907.15, -11.17,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(8397, 132.52, -907.49, -11.17,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(8397, 129.09, -907.16, -11.17,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(19543, 108.52, -915.87, 0.52,   0.00, 0.00, 2.15, MaratonWorldId);
	CreateDynamicObject(7231, 92.77, -927.55, 21.32,   0.00, 0.00, 272.33, MaratonWorldId);
	CreateDynamicObject(7231, 91.41, -897.76, 21.32,   0.00, 0.00, 272.33, MaratonWorldId);
	CreateDynamicObject(7230, 92.89, -927.38, 21.74,   0.00, 0.00, 272.02, MaratonWorldId);
	CreateDynamicObject(7230, 91.48, -897.71, 21.24,   0.00, 0.00, 272.02, MaratonWorldId);
	CreateDynamicObject(18656, 111.18, -909.62, -6.69,   113.00, 0.00, 2.00, MaratonWorldId);
	CreateDynamicObject(18656, 111.87, -905.49, -6.69,   76.00, 0.00, 1.70, MaratonWorldId);
	CreateDynamicObject(18786, -96.33, -915.80, 2.12,   0.00, 0.00, 144.62, MaratonWorldId);
	CreateDynamicObject(18786, -85.07, -899.48, 2.12,   0.00, 0.00, 144.62, MaratonWorldId);
	CreateDynamicObject(3437, 99.86, -903.29, 33.34,   -98.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3437, 99.59, -917.54, 31.57,   -30.00, 2.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3437, 99.86, -903.29, 37.33,   -98.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3437, 99.84, -901.52, 31.16,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3437, 100.00, -911.40, 31.16,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3437, 100.15, -920.58, 31.57,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3437, 100.05, -914.64, 31.16,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3437, -732.94, -869.73, 115.57,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -726.15, -877.25, 118.77,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -735.44, -866.90, 111.55,   0.00, 0.00, 45.04, MaratonWorldId);
	CreateDynamicObject(3437, -733.35, -868.85, 114.69,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -726.51, -876.72, 119.28,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -731.64, -871.01, 117.78,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -732.30, -870.25, 116.67,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -733.92, -868.44, 113.74,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -734.41, -867.91, 113.21,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -723.70, -879.77, 113.74,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -722.79, -880.97, 111.87,   0.00, 0.00, 45.04, MaratonWorldId);
	CreateDynamicObject(3437, -723.33, -880.17, 113.21,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -724.05, -879.39, 114.69,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -724.47, -878.80, 115.57,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -724.87, -878.19, 116.67,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -725.60, -877.74, 117.78,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -730.42, -872.44, 119.28,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -731.07, -871.74, 118.77,   0.00, 0.00, 44.84, MaratonWorldId);
	CreateDynamicObject(3437, -734.97, -867.49, 112.38,   0.00, 0.00, 45.04, MaratonWorldId);
	CreateDynamicObject(3437, -723.13, -880.56, 112.38,   0.00, 0.00, 45.04, MaratonWorldId);
	CreateDynamicObject(3524, -727.60, -876.93, 118.19,   0.00, 0.00, 318.95, MaratonWorldId);
	CreateDynamicObject(3524, -730.87, -873.50, 118.19,   0.00, 0.00, 318.95, MaratonWorldId);
	CreateDynamicObject(19604, -728.03, -883.00, 116.00,   0.00, 0.00, 310.45, MaratonWorldId);
	CreateDynamicObject(19604, -737.74, -871.64, 116.00,   0.00, 0.00, 310.45, MaratonWorldId);
	CreateDynamicObject(19604, -734.49, -875.38, 116.00,   0.00, 0.00, 310.45, MaratonWorldId);
	CreateDynamicObject(19604, -731.25, -879.19, 116.00,   0.00, 0.00, 310.45, MaratonWorldId);
	CreateDynamicObject(9833, -730.11, -881.61, 118.58,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(9833, -736.70, -874.50, 118.58,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(8397, -740.21, -884.53, 75.92,   0.00, 0.00, 309.07, MaratonWorldId);
	CreateDynamicObject(8397, -740.21, -884.53, 74.19,   56.00, 0.00, 309.00, MaratonWorldId);
	CreateDynamicObject(8397, -740.51, -884.24, 74.48,   0.00, -3.00, 309.00, MaratonWorldId);
	CreateDynamicObject(8397, -740.21, -884.53, 73.95,   0.00, 4.00, 309.00, MaratonWorldId);
	CreateDynamicObject(8397, -740.29, -884.59, 71.90,   0.00, -7.00, 309.00, MaratonWorldId);
	CreateDynamicObject(8397, -739.93, -884.68, 71.88,   0.00, 7.00, 309.00, MaratonWorldId);
	CreateDynamicObject(8621, -741.11, -887.36, 124.42,   0.00, 0.00, 310.34, MaratonWorldId);
	CreateDynamicObject(19128, -734.89, -884.65, 115.93,   0.00, 0.00, 311.00, MaratonWorldId);
	CreateDynamicObject(19128, -732.39, -887.57, 115.93,   0.00, 0.00, 311.00, MaratonWorldId);
	CreateDynamicObject(19128, -737.48, -881.65, 115.93,   0.00, 0.00, 311.00, MaratonWorldId);
	CreateDynamicObject(19128, -742.66, -875.70, 115.93,   0.00, 0.00, 311.00, MaratonWorldId);
	CreateDynamicObject(19128, -740.06, -878.70, 115.93,   0.00, 0.00, 311.00, MaratonWorldId);
	CreateDynamicObject(3461, -739.85, -880.59, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -736.41, -884.46, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -734.42, -882.73, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -735.72, -883.86, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -737.74, -878.73, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -739.09, -879.93, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -739.47, -880.26, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -736.10, -884.19, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -738.78, -879.65, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -735.34, -883.53, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -735.04, -883.26, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -738.40, -879.32, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -738.03, -878.97, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(3461, -734.74, -882.99, 117.33,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(6865, -738.69, -882.67, 120.16,   0.00, 0.00, 175.01, MaratonWorldId);
	CreateDynamicObject(19649, -338.13, -712.48, 50.72,   -1.00, 9.00, 181.00, MaratonWorldId);
	CreateDynamicObject(19661, -619.56, -720.03, 57.35,   0.00, 0.00, 252.85, MaratonWorldId);
	CreateDynamicObject(19649, -636.88, -749.00, 66.99,   -1.00, 22.00, 66.19, MaratonWorldId);
	CreateDynamicObject(19649, -573.90, -716.24, 36.35,   -1.00, -17.00, 181.16, MaratonWorldId);
	CreateDynamicObject(18609, -663.11, -811.92, 94.54,   0.00, 0.00, 55.78, MaratonWorldId);
	CreateDynamicObject(18609, -669.50, -808.22, 95.05,   0.00, 0.00, 55.78, MaratonWorldId);
	CreateDynamicObject(19649, -529.18, -715.20, 26.90,   -1.00, -7.00, 181.00, MaratonWorldId);
	CreateDynamicObject(19649, -481.88, -714.48, 27.78,   -1.00, 9.00, 181.00, MaratonWorldId);
	CreateDynamicObject(19649, -434.69, -713.83, 35.32,   -1.00, 9.00, 181.00, MaratonWorldId);
	CreateDynamicObject(3578, -539.21, -715.31, 26.30,   0.00, -9.00, 259.26, MaratonWorldId);
	CreateDynamicObject(3578, -609.22, -717.63, 55.85,   0.00, 0.00, 265.66, MaratonWorldId);
	CreateDynamicObject(3578, -590.40, -715.86, 40.27,   0.00, -9.00, 263.71, MaratonWorldId);
	CreateDynamicObject(3578, -581.18, -716.50, 37.48,   0.00, -9.00, 263.71, MaratonWorldId);
	CreateDynamicObject(3578, -570.20, -717.12, 34.44,   0.00, -9.00, 263.71, MaratonWorldId);
	CreateDynamicObject(3437, -708.04, -858.73, 124.27,   14.00, 1.00, 46.00, MaratonWorldId);
	CreateDynamicObject(3437, -705.69, -861.28, 124.18,   -19.00, 3.00, 45.90, MaratonWorldId);
	CreateDynamicObject(3437, -712.14, -853.20, 124.27,   14.00, 1.00, 46.00, MaratonWorldId);
	CreateDynamicObject(3437, -709.99, -855.99, 124.18,   -19.00, 3.00, 46.00, MaratonWorldId);
	CreateDynamicObject(3578, -560.19, -716.56, 31.14,   0.00, -9.00, 263.71, MaratonWorldId);
	CreateDynamicObject(3578, -548.25, -716.29, 28.61,   0.00, -9.00, 259.26, MaratonWorldId);
	CreateDynamicObject(19841, -723.35, -869.17, 102.79,   0.00, 0.00, 131.60, MaratonWorldId);
	CreateDynamicObject(19841, -597.13, -718.12, 46.71,   -23.00, 0.00, 94.23, MaratonWorldId);
	CreateDynamicObject(19842, -500.13, -714.83, 23.97,   -2.00, -7.00, 269.00, MaratonWorldId);
	CreateDynamicObject(19842, -582.98, -716.47, 38.32,   -18.00, -6.00, 270.00, MaratonWorldId);
	CreateDynamicObject(19842, -559.55, -715.78, 30.74,   -18.00, -6.00, 271.02, MaratonWorldId);
	CreateDynamicObject(19842, -546.77, -715.29, 28.36,   -10.00, -5.00, 271.00, MaratonWorldId);
	CreateDynamicObject(19842, -522.11, -715.41, 24.66,   -7.00, -5.00, 269.00, MaratonWorldId);
	CreateDynamicObject(19842, -516.08, -715.12, 24.63,   -2.00, -7.00, 269.00, MaratonWorldId);
	CreateDynamicObject(19649, -385.68, -713.11, 43.16,   -1.00, 9.00, 181.00, MaratonWorldId);
	CreateDynamicObject(13645, -311.18, -714.35, 55.09,   -132.00, 4.00, 96.42, MaratonWorldId);
	CreateDynamicObject(13645, -311.24, -710.19, 55.19,   -132.00, 4.00, 96.52, MaratonWorldId);
	CreateDynamicObject(13645, -295.76, -707.61, 1.30,   4.00, -91.00, 290.28, MaratonWorldId);
	CreateDynamicObject(13645, -298.05, -703.36, 1.22,   -178.00, -91.00, 146.02, MaratonWorldId);
	CreateDynamicObject(987, -274.80, -691.97, -0.97,   0.00, 0.00, 38.71, MaratonWorldId);
	CreateDynamicObject(987, -277.57, -686.64, -0.97,   0.00, 0.00, 38.29, MaratonWorldId);
	CreateDynamicObject(987, -293.87, -707.13, -0.97,   0.00, 0.00, 38.71, MaratonWorldId);
	CreateDynamicObject(987, -296.64, -701.80, -0.97,   0.00, 0.00, 38.29, MaratonWorldId);
	CreateDynamicObject(987, -287.08, -694.24, -0.97,   0.00, 0.00, 38.29, MaratonWorldId);
	CreateDynamicObject(987, -284.40, -699.64, -0.97,   0.00, 0.00, 38.71, MaratonWorldId);
	CreateDynamicObject(18761, 23.91, -911.45, 4.48,   0.00, 0.00, 89.09, MaratonWorldId);
	CreateDynamicObject(18761, -206.51, -750.91, 4.38,   0.00, 0.00, 36.70, MaratonWorldId);
	CreateDynamicObject(18761, -225.18, -722.53, 4.38,   0.00, 0.00, 36.70, MaratonWorldId);
	CreateDynamicObject(18761, -244.45, -694.45, 4.38,   0.00, 0.00, 36.70, MaratonWorldId);
	CreateDynamicObject(18761, -146.36, -841.52, 4.38,   0.00, 0.00, 36.70, MaratonWorldId);
	CreateDynamicObject(18761, -163.37, -815.57, 4.48,   0.00, 0.00, 36.70, MaratonWorldId);
	CreateDynamicObject(18761, -187.61, -778.40, 4.38,   0.00, 0.00, 36.70, MaratonWorldId);
	CreateDynamicObject(18761, -122.88, -877.80, 4.48,   0.00, 0.00, 36.70, MaratonWorldId);
	CreateDynamicObject(18761, -41.06, -911.54, 4.48,   0.00, 0.00, 89.09, MaratonWorldId);
	CreateDynamicObject(18761, -6.62, -910.09, 4.48,   0.00, 0.00, 89.09, MaratonWorldId);
	CreateDynamicObject(7666, -713.20, -853.77, 116.15,   0.00, 0.00, 65.53, MaratonWorldId);
	CreateDynamicObject(7666, -706.20, -862.44, 116.15,   0.00, 0.00, 65.53, MaratonWorldId);
	CreateDynamicObject(7666, -709.78, -858.33, 116.15,   0.00, 0.00, 65.53, MaratonWorldId);
	CreateDynamicObject(354, -713.29, -853.79, 116.23,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(354, -706.52, -862.40, 116.23,   0.00, 0.00, 0.00, MaratonWorldId);
	CreateDynamicObject(354, -709.83, -858.26, 116.23,   0.00, 0.00, 0.00, MaratonWorldId);
	MaratonV[0] = AddStaticVehicleEx(446, -263.2480, -677.6967, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[1] = AddStaticVehicleEx(446, -259.5772, -675.2679, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[2] = AddStaticVehicleEx(446, -255.8939, -672.7842, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[3] = AddStaticVehicleEx(446, -252.1322, -670.1641, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[4] = AddStaticVehicleEx(446, -272.1093, -664.9984, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[5] = AddStaticVehicleEx(446, -268.5017, -662.4290, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[6] = AddStaticVehicleEx(446, -264.6252, -659.9515, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[7] = AddStaticVehicleEx(446, -260.7265, -657.8135, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[8] = AddStaticVehicleEx(446, -277.5083, -650.1294, 1.6798, -144.7799, -1, -1, 100);
	MaratonV[9] = AddStaticVehicleEx(446, -273.3979, -647.1909, 1.6798, -144.7799, -1, -1, 100);
	SetVehicleVirtualWorld(MaratonV[0], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[1], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[2], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[3], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[4], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[5], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[6], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[7], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[8], MaratonWorldId);
	SetVehicleVirtualWorld(MaratonV[9], MaratonWorldId);
	SendClientMessageToAll(rojo, "[Pura Joda] en {FFFFFF}5 {00FF00}minutos iniciará {FFFFFF}Maratón de nuevo.");
	SetTimer("Start",TIME_MARATON,false);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 785, -426.6172, -689.6797, 14.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 17035, -630.5391, -783.3125, 58.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 791, -426.6172, -689.6797, 14.0547, 0.25);
	MCPProgress[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(Jugando[playerid] == 1)
	{
    	MCPProgress[playerid] = 0;
    	SetPlayerVirtualWorld(playerid, 0);
    	DisablePlayerRaceCheckpoint(playerid);
    	Jugando[playerid] = 0;
    	new pJugando = 0;
    	for(new i = 0; i < 10; i++) if(PlayersJugando[i] == playerid) PlayersJugando[i] = INVALID_PLAYER_ID; else if(PlayersJugando[i] != INVALID_PLAYER_ID) pJugando++;
    	if(pJugando == 0) FinMaraton2();
    	Jugando[playerid] = 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(Jugando[playerid] == 1)
	{
    	MCPProgress[playerid] = 0;
    	DeletePVar(playerid, "MINION");
    	SetPlayerVirtualWorld(playerid, 0);
    	DisablePlayerRaceCheckpoint(playerid);
    	Jugando[playerid] = 0;
    	new pJugando = 0;
    	for(new i = 0; i < 10; i++) if(PlayersJugando[i] == playerid) PlayersJugando[i] = INVALID_PLAYER_ID; else if(PlayersJugando[i] != INVALID_PLAYER_ID) pJugando++;
    	if(pJugando == 0) FinMaraton2();
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(maraton,7,cmdtext);
	dcmd(pmaraton,8,cmdtext);
	dcmd(salirmaraton,12,cmdtext);
	return 0;
}

//-- Comandos --
dcmd_salirmaraton(playerid,params[]) //12
{
    #pragma unused params
    new pJugando = 0;
	if(!GetPVarInt(playerid, "MINION")) return SendClientMessage(playerid, rojo, "[Pura Joda] >> Usted no esta jugando");
	for(new i = 0; i < 10; i++) if(PlayersJugando[i] == playerid) PlayersJugando[i] = INVALID_PLAYER_ID; else if(PlayersJugando[i] != INVALID_PLAYER_ID) pJugando++;
	new string[144];
	format(string, sizeof(string), "[Pura Joda]{00FF00}>>{FFFFFF}%s salio de \"/maraton\"", PlayerName2(playerid));
	SendClientMessageToAll(rojo, string);
	MCPProgress[playerid] = 0;
	Jugando[playerid] = 0;
	DisablePlayerRaceCheckpoint(playerid);
	DeletePVar(playerid, "MINION");
	if(pJugando == 0) FinMaraton2();
	SpawnPlayer(playerid);
	return 1;
}
dcmd_maraton(playerid,params[])
{
	#pragma unused params
/*	if(!YaMaraton)
	{
	    new string[144];
	    format(string, sizeof(string), "[Pura Joda] >> Debes esperar %d segundos para iniciar otra maraton", CheckFTzTimer(3600, FTzTimer[tMaratonON]));
	    return SendClientMessage(playerid, rojo, string);
	}
*/	if(GetPVarInt(playerid, "MINION") == 1) return SendClientMessage(playerid, rojo, "[Pura Joda] >> Usted esta jugando");
	if(EnJuego) return SendClientMessage(playerid, rojo, "[Pura Joda] >> El juego ya comenzo, espera a que termine");
	for(new i = 0; i < 10; i++)
	{
	    if(PlayersJugando[i] == INVALID_PLAYER_ID)
	    {
	        YaMaraton = true;
	        PlayersJugando[i] = playerid;
	        Jugando[playerid] = 1;
	        MPosision = 0;
	        SetPVarInt(playerid, "MINION", 1);

	        if(i >= 1)
			{
				return SendClientMessage(playerid, rojo, "[Pura Joda] {00FF00}>> {FFFFFF}Ya se anoto para participar, en instantes se lo llevara al minijuego");
			} else {
	        //	SendClientMessageToAll(rojo, "[Pura Joda] {00FF00}>> {FFFFFF}Nuevo Minijuego /Maraton !! Pruebalo !!");
				return SendClientMessage(playerid, rojo, "[Pura Joda] {00FF00}>> {FFFFFF}Ya se anoto para participar, espere que se una un usuario mas");
			}
	    }
	}
	return SendClientMessage(playerid, rojo, "[Pura Joda] {00FF00}>> {FFFFFF}No hay mas cupos en maraton !");
}

dcmd_pmaraton(playerid,params[])
{
    #pragma unused params
	new string2[500], str2[100];
	for(new i = 0; i < 10; i++)
	{
	    if(PlayersJugando[i] != INVALID_PLAYER_ID)
	    {
	    	format(str2, sizeof(str2), "%s \t- \t%d\n", PlayerName2(PlayersJugando[i]), PlayersJugando[i]);
	    	strcat(string2, str2);
		}
	}
	return ShowPlayerDialog(playerid, 1009, DIALOG_STYLE_MSGBOX, "Players Jugando Maraton", string2, "Ok","");
}
//-- Fin Comandos --
forward Start();
public Start(){
SendClientMessageToAll(rojo, "[Pura Joda] {FFFFFF}En {0000FF}10 {FFFFFF}segundos comienza  {FF0000}Maraton. {0000FF}/Maraton {FFFFFF}para participar.");
TimerMaraton = SetTimer("ComenzarMaraton", 2000, true);
//print("Maratón comenzó su ronda.");

return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(EnJuego)
	{
		new string[144];
		if(MCPProgress[playerid] < 9)
		{
			MCPProgress[playerid]++;
			DisablePlayerRaceCheckpoint(playerid);
			if(MCPProgress[playerid] == 9)
			{
				SetPlayerRaceCheckpoint(playerid, 1, MaratonCP[MCPProgress[playerid]][0], MaratonCP[MCPProgress[playerid]][1], MaratonCP[MCPProgress[playerid]][2], 0, 0, 0, CHECKCP_SIZE);
			} else {
				SetPlayerRaceCheckpoint(playerid, 0, MaratonCP[MCPProgress[playerid]][0], MaratonCP[MCPProgress[playerid]][1], MaratonCP[MCPProgress[playerid]][2], MaratonCP[MCPProgress[playerid]+1][0], MaratonCP[MCPProgress[playerid]+1][1], MaratonCP[MCPProgress[playerid]+1][2], CHECKCP_SIZE);
			}
		} else {
		    new Premio, Premio2;
			MPosision++;
			DisablePlayerRaceCheckpoint(playerid);
			if(Count > 5){
			switch(MPosision)
			{
			    case 1: Premio = (random(1000)*random(10)+5000), Premio2 = 10,SetPVarInt(playerid, "COIN",GetPVarInt(playerid, "COIN")+1);
			    case 2: Premio = (random(1000)*random(10)+3000), Premio2 = 9;
			    case 3: Premio = (random(1000)*random(10)+2500), Premio2 = 8;
			    case 4: Premio = (random(1000)*random(10)+1500), Premio2 = 7;
			    case 5: Premio = (random(1000)*random(10)+1000), Premio2 = 6;
			    case 6: Premio = (random(1000)*random(10)+500), Premio2 = 5;
			    case 7: Premio = (random(1000)*random(5)), Premio2 = 4;
			    case 8: Premio = (random(1000)*random(4)), Premio2 = 3;
			    case 9: Premio = random(1000)*2, Premio2 = 2;
			    case 10: Premio = random(100), Premio2 = 1;
			}}
			else if(Count < 4){
   			switch(MPosision)
			{
			    case 1: Premio = (random(5000)), Premio2 = 0;
			    case 2: Premio = (random(4000)), Premio2 = 0;
			    case 3: Premio = (random(3000)), Premio2 = 0;
			    case 4: Premio = (random(2000)), Premio2 = 0;
			    case 5: Premio = (random(1000)), Premio2 = 0;
			    case 6: Premio = (random(900)), Premio2 = 0;
			    case 7: Premio = (random(800)), Premio2 = 0;
			    case 8: Premio = 0, Premio2 = 0;
			    case 9: Premio =0, Premio2 = 0;
			    case 10: Premio = 0, Premio2 = 0;
			}
			
			}
			if(MPosision == 1){
			format(string, sizeof(string), "[Pura Joda] {FFFFFF}%s {00FF00}ganó {FFFFFF}Maratón.", PlayerName2(playerid));
			SendClientMessageToAll(rojo, string);
			format(string, sizeof(string), "    {00FF00} %d Dinero, %d Score + 1 PJCoin", Premio, Premio2);
			SendClientMessageToAll(rojo, string);
			}else{
			format(string, sizeof(string), "[Pura Joda] {00FF00}>> {FFFFFF}El usuario {00FF00}%s {FFFFFF}salio en {00FF00}%d Lugar {FFFFFF}en /Maraton", PlayerName2(playerid), MPosision);
			SendClientMessage(playerid,rojo, string);
			format(string, sizeof(string), "[PREMIO]:    {00FF00}>> %d Dinero, %d Score <<", Premio, Premio2);
			SendClientMessage(playerid, rojo, string);

			}
			SetPVarInt(playerid, "CASH", GetPVarInt(playerid, "CASH")+Premio);
			GivePlayerMoney(playerid, Premio);
			SetPVarInt(playerid, "Score", GetPVarInt(playerid, "Score")+Premio2);
			SetPlayerVirtualWorld(playerid, 0);
			Jugando[playerid] = 0;
			MCPProgress[playerid] = 0;
			DeletePVar(playerid, "MINION");
			SpawnPlayer(playerid);
			for(new i = 0; i < 10; i++) if(PlayersJugando[i] == playerid) PlayersJugando[i] = INVALID_PLAYER_ID;
			if(FinMaraton)
			{
			    FTzTimer[tFinMaraton] = gettime();
			    FinMaraton = false;
			    for(new i = 0; i < 10; i++) if(PlayersJugando[i] != INVALID_PLAYER_ID) SendClientMessage(i, rojo, "[Pura Joda] {00FF00}>> {FFFFFF}¡APURATE!, tienes {FF0000}20 segundos {FFFFFF}para finalizar la maraton.");
			}
		}
	}
	return 1;
}

public OnPlayerUpdate()
{
//	if(!CheckFTzTimer(3600, FTzTimer[tMaratonON])) YaMaraton = true, FTzTimer[tMaratonON] = 0;
	if(!CheckFTzTimer(20, FTzTimer[tFinMaraton])) FinMaraton2(), FTzTimer[tFinMaraton] = 0;
	if(!CheckFTzTimer(1, FTzTimer[tCount])) CountDownMaraton();
	return 1;
}

fTimer FinMaraton2()
{
	EnJuego = false;
	MPosision = 0;
	Count = 0;
	//SendClientMessageToAll(rojo, "[Pura Joda] {00FF00}>> {FFFFFF}Finalizo la \"Maraton\" si quieres iniciar otro tipea {FF0000}/maraton");
	YaMaraton = false;
	FTzTimer[tMaratonON] = gettime();
	for(new playerid = 0; playerid <= GetPlayerPoolSize(); playerid++)
	{
		if(Jugando[playerid] != 0)
		{
		    Jugando[playerid] = 0;
		    DisablePlayerRaceCheckpoint(playerid);
		    MCPProgress[playerid] = 0;
		    SetPlayerVirtualWorld(playerid, 0);
		    DeletePVar(playerid, "MINION");
		    for(new i = 0; i < 10; i++) if(PlayersJugando[i] == playerid) PlayersJugando[i] = INVALID_PLAYER_ID;
		    SendClientMessage(playerid, rojo, "[Pura Joda] {00FF00}Has perdido la maratón.");
		    SpawnPlayer(playerid);
		}
	}
	SendClientMessageToAll(rojo, "[Pura Joda] en {FFFFFF}5 {00FF00}minutos iniciará {FFFFFF}Maratón de nuevo.");
	SetTimer("Start",TIME_MARATON,false);
}

fTimer ComenzarMaraton()
{
	switch(Conteo)
	{
	    case 1:SendClientMessageToAll(rojo, "[Pura Joda]{FFFFFF}En {0000FF}8 {FFFFFF}segundos comienza {FF0000}Maraton {0000FF}/Maraton {FFFFFF}para participar."), Conteo++;
	    case 5:
	    {
	        KillTimer(TimerMaraton);
	        Conteo = 1;
	        ConteoYa = false;
	        EnJuego = true;
			FinMaraton = true;
	        new PosicionLargada = 0;
	        for(new i = 0; i < 10; i++)
	        {
	            if(PlayersJugando[i] != INVALID_PLAYER_ID)
	            {
	                Count++;
	                ResetPlayerWeapons(i);
	                SetPlayerPos(PlayersJugando[i], MaratonPlayersSpawn[PosicionLargada][0], MaratonPlayersSpawn[PosicionLargada][1], MaratonPlayersSpawn[PosicionLargada][2]);
	                SetPlayerFacingAngle(PlayersJugando[i], 313.0313);
	                SetCameraBehindPlayer(i);
	                SetPlayerVirtualWorld(PlayersJugando[i], MaratonWorldId);
	                PosicionLargada++;
	                TogglePlayerControllable(PlayersJugando[i], false);
	            }
	        }
	        if(Count < 2) FinMaraton2();
	        else CountDownMaraton();
	    }
	    default: Conteo++;
	}
}

fTimer CountDownMaraton()
{
	new ConteoText[5][5] = {
		"~r~1",
		"~r~2",
		"~r~3",
		"~b~4",
		"~b~5"
	};
	if(Conteo2 > 0)
	{
	    GameTextForMaratonPlayer(ConteoText[Conteo2-1], 2500, 3);
	    Conteo2--;
	    FTzTimer[tCount] = gettime();
	} else {
	    GameTextForMaratonPlayer("~g~YA", 2500, 3);
	    FTzTimer[tCount] = 0;
	    Conteo2 = 5;
	    for(new i = 0; i < 10; i++) if(PlayersJugando[i] != INVALID_PLAYER_ID) ComenzarMaraton2(PlayersJugando[i]);
	}
}

stock ComenzarMaraton2(playerid)
{
	SetPlayerRaceCheckpoint(playerid, 0, MaratonCP[MCPProgress[playerid]][0], MaratonCP[MCPProgress[playerid]][1], MaratonCP[MCPProgress[playerid]][2], MaratonCP[MCPProgress[playerid]+1][0], MaratonCP[MCPProgress[playerid]+1][1], MaratonCP[MCPProgress[playerid]+1][2], CHECKCP_SIZE);
	TogglePlayerControllable(playerid, true);
	return 1;
}

stock GameTextForMaratonPlayer(const string[], time, type)
{
	for(new i = 0; i < 10; i++)
	{
	    if(PlayersJugando[i] != INVALID_PLAYER_ID)
	    {
	        GameTextForPlayer(PlayersJugando[i], string, time, type);
	    }
	}
	return 1;
}

stock PlayerName2(playerid)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}

stock CheckFTzTimer(time, ref)
{
	new seconds = (time - (gettime() - ref));
	if(ref == 0) return -1;
	else if(seconds <= 0) return 0;
	else return seconds;
}

/*strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}*/
