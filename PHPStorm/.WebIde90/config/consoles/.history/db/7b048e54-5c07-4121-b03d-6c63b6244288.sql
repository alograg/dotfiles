SELECT md5(65958)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `tuition_structure_id`,
  `schoolyear_id`,
  `site_id`,
  `level_id`,
  `tuition_id`,
  `payment_index`,
  COUNT(student_id)                                                          AS schoolyear_students,
  SUM(IF(type = 'normal', amount, 0))                                        AS schoolyear_expected,
  SUM(IF(type = 'normal', IFNULL(student_tuition_payed.payed, 0), 0))        AS accumulated_amount,
  SUM(IF(type = 'discount', amount,
         0))                                                                 AS accumulated_discount,
  COUNT(IF(expected_at < '2015-09' AND
           IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount, student_id,
           NULL))                                                            AS accumulated_defeated_students,
  SUM(IF(expected_at < '2015-09' AND
         IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount,
         amount - IFNULL(student_tuition_payed.payed, 0),
         0))                                                                 AS accumulated_defeated_amount,
  SUM(IF(type = 'normal' AND expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09', INTERVAL 1 MONTH), '%Y-%m-01'), amount, 0)) AS current_expected,
  SUM(IF(type = 'normal' AND expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09', INTERVAL 1 MONTH), '%Y-%m-01'),
         IFNULL(student_tuition_payed.payed, 0), 0))                         AS current_amount,
  SUM(IF(type = 'discount' AND expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09', INTERVAL 1 MONTH), '%Y-%m-01'),
         IFNULL(student_tuition_payed.payed, 0), 0))                         AS current_discount,
  COUNT(IF(expected_at != '0000-00-00' AND
           expected_at BETWEEN DATE_FORMAT('2015-09', '%Y-%m-01') AND DATE_FORMAT(
               DATE_ADD('2015-09', INTERVAL 1 MONTH), '%Y-%m-01') AND
           IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount, student_id,
           NULL))                                                            AS defeated_students,
  SUM(IF(expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09', INTERVAL 1 MONTH), '%Y-%m-01') AND
         IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount,
         amount - IFNULL(student_tuition_payed.payed, 0), 0))                AS defeated_amount
FROM `student_tuition_detail`
  LEFT JOIN `student_tuition_payed`
    ON `student_tuition_detail`.`id` = `student_tuition_payed`.`student_tuition_id`
GROUP BY `tuition_structure_id`, `schoolyear_id`, `site_id`, `level_id`, `tuition_id`,
  `payment_index`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `tuition_structure_id`,
  `schoolyear_id`,
  `site_id`,
  `level_id`,
  `tuition_id`,
  `payment_index`,
  COUNT(student_id)                                                          AS schoolyear_students,
  SUM(IF(type = 'normal', amount, 0))                                        AS schoolyear_expected,
  SUM(IF(type = 'normal', IFNULL(student_tuition_payed.payed, 0), 0))        AS accumulated_amount,
  SUM(IF(type = 'discount', amount,
         0))                                                                 AS accumulated_discount,
  COUNT(IF(expected_at < '2015-09-01' AND
           IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount, student_id,
           NULL))                                                            AS accumulated_defeated_students,
  SUM(IF(expected_at < '2015-09-01' AND
         IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount,
         amount - IFNULL(student_tuition_payed.payed, 0),
         0))                                                                 AS accumulated_defeated_amount,
  SUM(IF(type = 'normal' AND expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09-01', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09-01', INTERVAL 1 MONTH), '%Y-%m-01'), amount, 0)) AS current_expected,
  SUM(IF(type = 'normal' AND expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09-01', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09-01', INTERVAL 1 MONTH), '%Y-%m-01'),
         IFNULL(student_tuition_payed.payed, 0), 0))                         AS current_amount,
  SUM(IF(type = 'discount' AND expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09-01', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09-01', INTERVAL 1 MONTH), '%Y-%m-01'),
         IFNULL(student_tuition_payed.payed, 0), 0))                         AS current_discount,
  COUNT(IF(expected_at != '0000-00-00' AND
           expected_at BETWEEN DATE_FORMAT('2015-09-01', '%Y-%m-01') AND DATE_FORMAT(
               DATE_ADD('2015-09-01', INTERVAL 1 MONTH), '%Y-%m-01') AND
           IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount, student_id,
           NULL))                                                            AS defeated_students,
  SUM(IF(expected_at != '0000-00-00' AND
         expected_at BETWEEN DATE_FORMAT('2015-09-01', '%Y-%m-01') AND DATE_FORMAT(
             DATE_ADD('2015-09-01', INTERVAL 1 MONTH), '%Y-%m-01') AND
         IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount,
         amount - IFNULL(student_tuition_payed.payed, 0), 0))                AS defeated_amount
FROM `student_tuition_detail`
  LEFT JOIN `student_tuition_payed`
    ON `student_tuition_detail`.`id` = `student_tuition_payed`.`student_tuition_id`
GROUP BY `tuition_structure_id`, `schoolyear_id`, `site_id`, `level_id`, `tuition_id`,
  `payment_index`
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
WHERE `level_id` IS NOT NULL AND `student_id` IN
                                 (2573,
                                  2574,
                                  2575,
                                  2576,
                                  2577,
                                  2578,
                                  2579,
                                  2580,
                                  2581,
                                  2582,
                                  2583,
                                  2584,
                                  2586,
                                  2587,
                                  2588,
                                  2592,
                                  2593,
                                  2594,
                                  2595,
                                  2596,
                                  2597,
                                  2598,
                                  2599,
                                  2601,
                                  2602,
                                  2603,
                                  2604,
                                  2605,
                                  2606,
                                  2607,
                                  2608,
                                  2609,
                                  2610,
                                  2612,
                                  2613,
                                  2614,
                                  2615,
                                  2616,
                                  2617,
                                  2618,
                                  2619,
                                  2620,
                                  2621,
                                  2622,
                                  2623,
                                  2624,
                                  2625,
                                  2626,
                                  2627,
                                  2628,
                                  2629,
                                  2630,
                                  2631,
                                  2632,
                                  2633,
                                  2634,
                                  2635,
                                  2636,
                                  2637,
                                  2638,
                                  2639,
                                  2640,
                                  2641,
                                  2642,
                                  2643,
                                  2644,
                                  2645,
                                  2646,
                                  2647,
                                  2648,
                                  2649,
                                  2650,
                                  2651,
                                  2652,
                                  2653,
                                  2654,
                                  2655,
                                  2656,
                                  2657,
                                  2658,
                                  2659,
                                  2660,
                                  2661,
                                  2662,
                                  2663,
                                  2664,
                                  2665,
                                  2666,
                                  2667,
                                  2669,
                                  2670,
                                  2671,
                                  2672,
                                  2673,
                                  2674,
                                  2675,
                                  2676,
                                  2677,
                                  2678,
                                  2680,
                                  2681,
                                  2682,
                                  2683,
                                  2684,
                                  2685,
                                  2686,
                                  2687,
                                  2688,
                                  2689,
                                  2690,
                                  2691,
                                  2692,
                                  2693,
                                  2694,
                                  2696,
                                  2697,
                                  2698,
                                  2699,
                                  2700,
                                  2701,
                                  2702,
                                  2703,
                                  2704,
                                  2705,
                                  2706,
                                  2707,
                                  2708,
                                  2709,
                                  2710,
                                  2711,
                                  2714,
                                  2715,
                                  2716,
                                  2717,
                                  2719,
                                  2720,
                                  2721,
                                  2722,
                                  2723,
                                  2724,
                                  2725,
                                  2726,
                                  2728,
                                  2729,
                                  2730,
                                  2731,
                                  2732,
                                  2733,
                                  2734,
                                  2735,
                                  2737,
                                  2738,
                                  2739,
                                  2741,
                                  2743,
                                  2744,
                                  2745,
                                  2746,
                                  2747,
                                  2748,
                                  2749,
                                  2750,
                                  2751,
                                  2752,
                                  2753,
                                  2754,
                                  2755,
                                  2756,
                                  2757,
                                  2758,
                                  2759,
                                  2760,
                                  2761,
                                  2762,
                                  2763,
                                  2764,
                                  2765,
                                  2766,
                                  2767,
                                  2768,
                                  2769,
                                  2770,
                                  2771,
                                  2772,
                                  2774,
                                  2775,
                                  2776,
                                  2777,
                                  2778,
                                  2779,
                                  2780,
                                  2781,
                                  2782,
                                  2783,
                                  2784,
                                  2785,
                                  2786,
                                  2787,
                                  2788,
                                  2789,
                                  2790,
                                  2791,
                                  2792,
                                  2793,
                                  2794,
                                  2795,
                                  2796,
                                  2797,
                                  2798,
                                  2799,
                                  2800,
                                  2801,
                                  2802,
                                  2803,
                                  2804,
                                  2805,
                                  2806,
                                  2807,
                                  2808,
                                  2809,
                                  2810,
                                  2811,
                                  2812,
                                  2813,
                                  2814,
                                  2815,
                                  2816,
                                  2817,
                                  2818,
                                  2820,
                                  2821,
                                  2822,
                                  2823,
                                  2824,
                                  2825,
                                  2826,
                                  2827,
                                  2828,
                                  2829,
                                  2830,
                                  2831,
                                  2832,
                                  2833,
                                  2834,
                                  2835,
                                  2836,
                                  2837,
                                  2838,
                                  2839,
                                  2840,
                                  2841,
                                  2842,
                                  2843,
                                  2844,
                                  2845,
                                  2846,
                                  2847,
                                  2848,
                                  2849,
                                  2850,
                                  2851,
                                  2852,
                                  2853,
                                  2854,
                                  2855,
                                  2856,
                                  2857,
                                  2858,
                                  2859,
                                  2860,
                                  2862,
                                  2863,
                                  2864,
                                  2865,
                                  2866,
                                  2867,
                                  2868,
                                  2869,
                                  2870,
                                  2871,
                                  2872,
                                  2873,
                                  2874,
                                  2875,
                                  2876,
                                  2877,
                                  2879,
                                  2880,
                                  2881,
                                  2882,
                                  2883,
                                  2884,
                                  2885,
                                  2886,
                                  2887,
                                  2888,
                                  2889,
                                  2890,
                                  2891,
                                  2892,
                                  2893,
                                  2894,
                                  2895,
                                  2896,
                                  2897,
                                  2898,
                                  2899,
                                  2900,
                                  2901,
                                  2902,
                                  2903,
                                  2904,
                                  2905,
                                  2906,
                                  2907,
                                  2908,
                                  2909,
                                  2910,
                                  2911,
                                  2912,
                                  2913,
                                  2914,
                                  2915,
                                  2916,
                                  2917,
                                  2918,
                                  2920,
                                  2921,
                                  2922,
                                  2923,
                                  2924,
                                  2925,
                                  2926,
                                  2927,
                                  2928,
                                  2929,
                                  2930,
                                  2931,
                                  2932,
                                  2933,
                                  2934,
                                  2935,
                                  2936,
                                  2937,
                                  2939,
                                  2940,
                                  2941,
                                  2942,
                                  2943,
                                  2944,
                                  2945,
                                  2946,
                                  2947,
                                  2950,
                                  2951,
                                  2952,
                                  2953,
                                  2954,
                                  2955,
                                  2956,
                                  2957,
                                  2958,
                                  2959,
                                  2960,
                                  2961,
                                  2962,
                                  2963,
                                  2964,
                                  2965,
                                  2966,
                                  2967,
                                  2968,
                                  2969,
                                  2970,
                                  2973,
                                  2980,
                                  2981,
                                  2985,
                                  2987,
                                  2988,
                                  2990,
                                  2991,
                                  2992,
                                  2993,
                                  2994,
                                  2995,
                                  2996,
                                  2997,
                                  2998,
                                  2999,
                                  3000,
                                  3001,
                                  3002,
                                  3003,
                                  3004,
                                  3005,
                                  3007,
                                  3008,
                                  3009,
                                  3011,
                                  3012,
                                  3013,
                                  3014,
                                  3015,
                                  3016,
                                  3017,
                                  3018,
                                  3019,
                                  3020,
                                  3021,
                                  3022,
                                  3023,
                                  3024,
                                  3025,
                                  3026,
                                  3027,
                                  3028,
                                  3029,
                                  3030,
                                  3031,
                                  3033,
                                  3034,
                                  3035,
                                  3036,
                                  3037,
                                  3038,
                                  3039,
                                  3040,
                                  3041,
                                  3043,
                                  3044,
                                  3045,
                                  3046,
                                  3047,
                                  3048,
                                  3049,
                                  3050,
                                  3051,
                                  3052,
                                  3053,
                                  3055,
                                  3056,
                                  3057,
                                  3058,
                                  3059,
                                  3060,
                                  3061,
                                  3062,
                                  3063,
                                  3064,
                                  3065,
                                  3066,
                                  3067,
                                  3068,
                                  3069,
                                  3070,
                                  3071,
                                  3073,
                                  3075,
                                  3076,
                                  3077,
                                  3078,
                                  3079,
                                  3080,
                                  3081,
                                  3082,
                                  3083,
                                  3086,
                                  3087,
                                  3089,
                                  3090,
                                  3091,
                                  3092,
                                  3096,
                                  3097,
                                  3098,
                                  3099,
                                  3100,
                                  3101,
                                  3102,
                                  3104,
                                  3105,
                                  3106,
                                  3107,
                                  3109,
                                  3110,
                                  3111,
                                  3112,
                                  3113,
                                  3114,
                                  3115,
                                  3116,
                                  3118,
                                  3119,
                                  3120,
                                  3121,
                                  3122,
                                  3123,
                                  3124,
                                  3125,
                                  3126,
                                  3127,
                                  3129,
                                  3130,
                                  3131,
                                  3132,
                                  3133,
                                  3134,
                                  3135,
                                  3136,
                                  3137,
                                  3139,
                                  3140,
                                  3141,
                                  3142,
                                  3143,
                                  3144,
                                  3146,
                                  3147,
                                  3148,
                                  3149,
                                  3150,
                                  3151,
                                  3154,
                                  3155,
                                  3156,
                                  3157,
                                  3158,
                                  3159,
                                  3160,
                                  3161,
                                  3162,
                                  3163,
                                  3164,
                                  3165,
                                  3166,
                                  3167,
                                  3168,
                                  3169,
                                  3170,
                                  3171,
                                  3172,
                                  3173,
                                  3174,
                                  3176,
                                  3177,
                                  3178,
                                  3179,
                                  3180,
                                  3181,
                                  3182,
                                  3183,
                                  3184,
                                  3186,
                                  3187,
                                  3189,
                                  3190,
                                  3191,
                                  3192,
                                  3193,
                                  3194,
                                  3195,
                                  3196,
                                  3197,
                                  3198,
                                  3199,
                                  3200,
                                  3201,
                                  3202,
                                  3203,
                                  3204,
                                  3205,
                                  3206,
                                  3207,
                                  3208,
                                  3209,
                                  3210,
                                  3211,
                                  3212,
                                  3213,
                                  3214,
                                  3215,
                                  3216,
                                  3217,
                                  3218,
                                  3219,
                                  3220,
                                  3221,
                                  3222,
                                  3223,
                                  3224,
                                  3225,
                                  3226,
                                  3227,
                                  3228,
                                  3229,
                                  3230,
                                  3231,
                                  3232,
                                  3233,
                                  3234,
                                  3235,
                                  3236,
                                  3237,
                                  3238,
                                  3239,
                                  3240,
                                  3241,
                                  3242,
                                  3243,
                                  3244,
                                  3245,
                                  3246,
                                  3247,
                                  3248,
                                  3249,
                                  3250,
                                  3251,
                                  3252,
                                  3253,
                                  3254,
                                  3255,
                                  3256,
                                  3257,
                                  3258,
                                  3259,
                                  3260,
                                  3262,
                                  3264,
                                  3265,
                                  3267,
                                  3269,
                                  3270,
                                  3271,
                                  3272,
                                  3273,
                                  3274,
                                  3275,
                                  3276,
                                  3278,
                                  3279,
                                  3280,
                                  3281,
                                  3285,
                                  3286,
                                  3287,
                                  3289,
                                  3290,
                                  3291,
                                  3292,
                                  3293,
                                  3294,
                                  3295,
                                  3296,
                                  3297,
                                  3298,
                                  3299,
                                  3300,
                                  3301,
                                  3302,
                                  3303,
                                  3304,
                                  3305,
                                  3306,
                                  3307,
                                  3308,
                                  3309,
                                  3310,
                                  3311,
                                  3312,
                                  3314,
                                  3315,
                                  3316,
                                  3317,
                                  3318,
                                  3319,
                                  3321,
                                  3322,
                                  3324,
                                  3325,
                                  3326,
                                  3327,
                                  3328,
                                  3329,
                                  3330,
                                  3331,
                                  3332,
                                  3333,
                                  3334,
                                  3335,
                                  3336,
                                  3337,
                                  3338,
                                  3339,
                                  3341,
                                  3342,
                                  3343,
                                  3344,
                                  3345,
                                  3346,
                                  3347,
                                  3348,
                                  3349,
                                  3350,
                                  3351,
                                  3352,
                                  3353,
                                  3354,
                                  3355,
                                  3356,
                                  3357,
                                  3358,
                                  3359,
                                  3360,
                                  3361,
                                  3362,
                                  3363,
                                  3364,
                                  3365,
                                  3366,
                                  3367,
                                  3368,
                                  3369,
                                  3370,
                                  3371,
                                  3372,
                                  3373,
                                  3374,
                                  3375,
                                  3376,
                                  3377,
                                  3378,
                                  3379,
                                  3380,
                                  3381,
                                  3382,
                                  3383,
                                  3384,
                                  3385,
                                  3386,
                                  3387,
                                  3388,
                                  3389,
                                  3390,
                                  3391,
                                  3392,
                                  3393,
                                  3394,
                                  3395,
                                  3396,
                                  3397,
                                  3398,
                                  3399,
                                  3400,
                                  3401,
                                  3402,
                                  3403,
                                  3404,
                                  3405,
                                  3406,
                                  3407,
                                  3408,
                                  3409,
                                  3410,
                                  3411,
                                  3412,
                                  3413,
                                  3414,
                                  3415,
                                  3416,
                                  3417,
                                  3418,
                                  3419,
                                  3420,
                                  3421,
                                  3422,
                                  3423,
                                  3424,
                                  3425,
                                  3426,
                                  3427,
                                  3428,
                                  3429,
                                  3430,
                                  3431,
                                  3432,
                                  3433,
                                  3434,
                                  3435,
                                  3436,
                                  3437,
                                  3438,
                                  3439,
                                  3440,
                                  3441,
                                  3442,
                                  3443,
                                  3444,
                                  3445,
                                  3446,
                                  3447,
                                  3448,
                                  3449,
                                  3450,
                                  3451,
                                  3452,
                                  3453,
                                  3454,
                                  3455,
                                  3456,
                                  3457,
                                  3458,
                                  3459,
                                  3460,
                                  3461,
                                  3462,
                                  3463,
                                  3464,
                                  3465,
                                  3466,
                                  3467,
                                  3468,
                                  3469,
                                  3470,
                                  3471,
                                  3472,
                                  3473,
                                  3474,
                                  3475,
                                  3476,
                                  3477,
                                  3478,
                                  3479,
                                  3480,
                                  3481,
                                  3482,
                                  3483,
                                  3484,
                                  3485,
                                  3486,
                                  3487,
                                  3488,
                                  3489,
                                  3490,
                                  3491,
                                  3492,
                                  3493,
                                  3494,
                                  3495,
                                  3496,
                                  3497,
                                  3498,
                                  3499,
                                  3500,
                                  3501,
                                  3502,
                                  3503,
                                  3504,
                                  4008,
                                  4283,
                                  4284,
                                  4286,
                                  4342,
                                  4343,
                                  4344,
                                  4345,
                                  4346,
                                  4347,
                                  4348,
                                  4349,
                                  4350,
                                  4351,
                                  4352,
                                  4353,
                                  4354,
                                  4355,
                                  4356,
                                  4357,
                                  4358,
                                  4359,
                                  4360,
                                  4361,
                                  4362,
                                  4364,
                                  4365,
                                  4366,
                                  4367,
                                  4368,
                                  4369,
                                  4370,
                                  4371,
                                  4372,
                                  4373,
                                  4374,
                                  4375,
                                  4376,
                                  4378,
                                  4385,
                                  4387,
                                  4388,
                                  4390,
                                  4392,
                                  4394,
                                  4396,
                                  4398,
                                  4417,
                                  4419,
                                  4421,
                                  4423,
                                  4425,
                                  4427,
                                  4429,
                                  4430,
                                  4431,
                                  4433,
                                  4434,
                                  4437,
                                  4440,
                                  4442,
                                  4444,
                                  4446,
                                  4449,
                                  4451,
                                  4455,
                                  4457,
                                  4458,
                                  4460,
                                  4462,
                                  4464,
                                  4467,
                                  4468,
                                  4470,
                                  4472,
                                  4474,
                                  4475,
                                  4477)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
WHERE
  expected_at < '2015-08-31'
  AND `level_id` IS NOT NULL AND `student_id` IN
                                 (2573,
                                  2574,
                                  2575,
                                  2576,
                                  2577,
                                  2578,
                                  2579,
                                  2580,
                                  2581,
                                  2582,
                                  2583,
                                  2584,
                                  2586,
                                  2587,
                                  2588,
                                  2592,
                                  2593,
                                  2594,
                                  2595,
                                  2596,
                                  2597,
                                  2598,
                                  2599,
                                  2601,
                                  2602,
                                  2603,
                                  2604,
                                  2605,
                                  2606,
                                  2607,
                                  2608,
                                  2609,
                                  2610,
                                  2612,
                                  2613,
                                  2614,
                                  2615,
                                  2616,
                                  2617,
                                  2618,
                                  2619,
                                  2620,
                                  2621,
                                  2622,
                                  2623,
                                  2624,
                                  2625,
                                  2626,
                                  2627,
                                  2628,
                                  2629,
                                  2630,
                                  2631,
                                  2632,
                                  2633,
                                  2634,
                                  2635,
                                  2636,
                                  2637,
                                  2638,
                                  2639,
                                  2640,
                                  2641,
                                  2642,
                                  2643,
                                  2644,
                                  2645,
                                  2646,
                                  2647,
                                  2648,
                                  2649,
                                  2650,
                                  2651,
                                  2652,
                                  2653,
                                  2654,
                                  2655,
                                  2656,
                                  2657,
                                  2658,
                                  2659,
                                  2660,
                                  2661,
                                  2662,
                                  2663,
                                  2664,
                                  2665,
                                  2666,
                                  2667,
                                  2669,
                                  2670,
                                  2671,
                                  2672,
                                  2673,
                                  2674,
                                  2675,
                                  2676,
                                  2677,
                                  2678,
                                  2680,
                                  2681,
                                  2682,
                                  2683,
                                  2684,
                                  2685,
                                  2686,
                                  2687,
                                  2688,
                                  2689,
                                  2690,
                                  2691,
                                  2692,
                                  2693,
                                  2694,
                                  2696,
                                  2697,
                                  2698,
                                  2699,
                                  2700,
                                  2701,
                                  2702,
                                  2703,
                                  2704,
                                  2705,
                                  2706,
                                  2707,
                                  2708,
                                  2709,
                                  2710,
                                  2711,
                                  2714,
                                  2715,
                                  2716,
                                  2717,
                                  2719,
                                  2720,
                                  2721,
                                  2722,
                                  2723,
                                  2724,
                                  2725,
                                  2726,
                                  2728,
                                  2729,
                                  2730,
                                  2731,
                                  2732,
                                  2733,
                                  2734,
                                  2735,
                                  2737,
                                  2738,
                                  2739,
                                  2741,
                                  2743,
                                  2744,
                                  2745,
                                  2746,
                                  2747,
                                  2748,
                                  2749,
                                  2750,
                                  2751,
                                  2752,
                                  2753,
                                  2754,
                                  2755,
                                  2756,
                                  2757,
                                  2758,
                                  2759,
                                  2760,
                                  2761,
                                  2762,
                                  2763,
                                  2764,
                                  2765,
                                  2766,
                                  2767,
                                  2768,
                                  2769,
                                  2770,
                                  2771,
                                  2772,
                                  2774,
                                  2775,
                                  2776,
                                  2777,
                                  2778,
                                  2779,
                                  2780,
                                  2781,
                                  2782,
                                  2783,
                                  2784,
                                  2785,
                                  2786,
                                  2787,
                                  2788,
                                  2789,
                                  2790,
                                  2791,
                                  2792,
                                  2793,
                                  2794,
                                  2795,
                                  2796,
                                  2797,
                                  2798,
                                  2799,
                                  2800,
                                  2801,
                                  2802,
                                  2803,
                                  2804,
                                  2805,
                                  2806,
                                  2807,
                                  2808,
                                  2809,
                                  2810,
                                  2811,
                                  2812,
                                  2813,
                                  2814,
                                  2815,
                                  2816,
                                  2817,
                                  2818,
                                  2820,
                                  2821,
                                  2822,
                                  2823,
                                  2824,
                                  2825,
                                  2826,
                                  2827,
                                  2828,
                                  2829,
                                  2830,
                                  2831,
                                  2832,
                                  2833,
                                  2834,
                                  2835,
                                  2836,
                                  2837,
                                  2838,
                                  2839,
                                  2840,
                                  2841,
                                  2842,
                                  2843,
                                  2844,
                                  2845,
                                  2846,
                                  2847,
                                  2848,
                                  2849,
                                  2850,
                                  2851,
                                  2852,
                                  2853,
                                  2854,
                                  2855,
                                  2856,
                                  2857,
                                  2858,
                                  2859,
                                  2860,
                                  2862,
                                  2863,
                                  2864,
                                  2865,
                                  2866,
                                  2867,
                                  2868,
                                  2869,
                                  2870,
                                  2871,
                                  2872,
                                  2873,
                                  2874,
                                  2875,
                                  2876,
                                  2877,
                                  2879,
                                  2880,
                                  2881,
                                  2882,
                                  2883,
                                  2884,
                                  2885,
                                  2886,
                                  2887,
                                  2888,
                                  2889,
                                  2890,
                                  2891,
                                  2892,
                                  2893,
                                  2894,
                                  2895,
                                  2896,
                                  2897,
                                  2898,
                                  2899,
                                  2900,
                                  2901,
                                  2902,
                                  2903,
                                  2904,
                                  2905,
                                  2906,
                                  2907,
                                  2908,
                                  2909,
                                  2910,
                                  2911,
                                  2912,
                                  2913,
                                  2914,
                                  2915,
                                  2916,
                                  2917,
                                  2918,
                                  2920,
                                  2921,
                                  2922,
                                  2923,
                                  2924,
                                  2925,
                                  2926,
                                  2927,
                                  2928,
                                  2929,
                                  2930,
                                  2931,
                                  2932,
                                  2933,
                                  2934,
                                  2935,
                                  2936,
                                  2937,
                                  2939,
                                  2940,
                                  2941,
                                  2942,
                                  2943,
                                  2944,
                                  2945,
                                  2946,
                                  2947,
                                  2950,
                                  2951,
                                  2952,
                                  2953,
                                  2954,
                                  2955,
                                  2956,
                                  2957,
                                  2958,
                                  2959,
                                  2960,
                                  2961,
                                  2962,
                                  2963,
                                  2964,
                                  2965,
                                  2966,
                                  2967,
                                  2968,
                                  2969,
                                  2970,
                                  2973,
                                  2980,
                                  2981,
                                  2985,
                                  2987,
                                  2988,
                                  2990,
                                  2991,
                                  2992,
                                  2993,
                                  2994,
                                  2995,
                                  2996,
                                  2997,
                                  2998,
                                  2999,
                                  3000,
                                  3001,
                                  3002,
                                  3003,
                                  3004,
                                  3005,
                                  3007,
                                  3008,
                                  3009,
                                  3011,
                                  3012,
                                  3013,
                                  3014,
                                  3015,
                                  3016,
                                  3017,
                                  3018,
                                  3019,
                                  3020,
                                  3021,
                                  3022,
                                  3023,
                                  3024,
                                  3025,
                                  3026,
                                  3027,
                                  3028,
                                  3029,
                                  3030,
                                  3031,
                                  3033,
                                  3034,
                                  3035,
                                  3036,
                                  3037,
                                  3038,
                                  3039,
                                  3040,
                                  3041,
                                  3043,
                                  3044,
                                  3045,
                                  3046,
                                  3047,
                                  3048,
                                  3049,
                                  3050,
                                  3051,
                                  3052,
                                  3053,
                                  3055,
                                  3056,
                                  3057,
                                  3058,
                                  3059,
                                  3060,
                                  3061,
                                  3062,
                                  3063,
                                  3064,
                                  3065,
                                  3066,
                                  3067,
                                  3068,
                                  3069,
                                  3070,
                                  3071,
                                  3073,
                                  3075,
                                  3076,
                                  3077,
                                  3078,
                                  3079,
                                  3080,
                                  3081,
                                  3082,
                                  3083,
                                  3086,
                                  3087,
                                  3089,
                                  3090,
                                  3091,
                                  3092,
                                  3096,
                                  3097,
                                  3098,
                                  3099,
                                  3100,
                                  3101,
                                  3102,
                                  3104,
                                  3105,
                                  3106,
                                  3107,
                                  3109,
                                  3110,
                                  3111,
                                  3112,
                                  3113,
                                  3114,
                                  3115,
                                  3116,
                                  3118,
                                  3119,
                                  3120,
                                  3121,
                                  3122,
                                  3123,
                                  3124,
                                  3125,
                                  3126,
                                  3127,
                                  3129,
                                  3130,
                                  3131,
                                  3132,
                                  3133,
                                  3134,
                                  3135,
                                  3136,
                                  3137,
                                  3139,
                                  3140,
                                  3141,
                                  3142,
                                  3143,
                                  3144,
                                  3146,
                                  3147,
                                  3148,
                                  3149,
                                  3150,
                                  3151,
                                  3154,
                                  3155,
                                  3156,
                                  3157,
                                  3158,
                                  3159,
                                  3160,
                                  3161,
                                  3162,
                                  3163,
                                  3164,
                                  3165,
                                  3166,
                                  3167,
                                  3168,
                                  3169,
                                  3170,
                                  3171,
                                  3172,
                                  3173,
                                  3174,
                                  3176,
                                  3177,
                                  3178,
                                  3179,
                                  3180,
                                  3181,
                                  3182,
                                  3183,
                                  3184,
                                  3186,
                                  3187,
                                  3189,
                                  3190,
                                  3191,
                                  3192,
                                  3193,
                                  3194,
                                  3195,
                                  3196,
                                  3197,
                                  3198,
                                  3199,
                                  3200,
                                  3201,
                                  3202,
                                  3203,
                                  3204,
                                  3205,
                                  3206,
                                  3207,
                                  3208,
                                  3209,
                                  3210,
                                  3211,
                                  3212,
                                  3213,
                                  3214,
                                  3215,
                                  3216,
                                  3217,
                                  3218,
                                  3219,
                                  3220,
                                  3221,
                                  3222,
                                  3223,
                                  3224,
                                  3225,
                                  3226,
                                  3227,
                                  3228,
                                  3229,
                                  3230,
                                  3231,
                                  3232,
                                  3233,
                                  3234,
                                  3235,
                                  3236,
                                  3237,
                                  3238,
                                  3239,
                                  3240,
                                  3241,
                                  3242,
                                  3243,
                                  3244,
                                  3245,
                                  3246,
                                  3247,
                                  3248,
                                  3249,
                                  3250,
                                  3251,
                                  3252,
                                  3253,
                                  3254,
                                  3255,
                                  3256,
                                  3257,
                                  3258,
                                  3259,
                                  3260,
                                  3262,
                                  3264,
                                  3265,
                                  3267,
                                  3269,
                                  3270,
                                  3271,
                                  3272,
                                  3273,
                                  3274,
                                  3275,
                                  3276,
                                  3278,
                                  3279,
                                  3280,
                                  3281,
                                  3285,
                                  3286,
                                  3287,
                                  3289,
                                  3290,
                                  3291,
                                  3292,
                                  3293,
                                  3294,
                                  3295,
                                  3296,
                                  3297,
                                  3298,
                                  3299,
                                  3300,
                                  3301,
                                  3302,
                                  3303,
                                  3304,
                                  3305,
                                  3306,
                                  3307,
                                  3308,
                                  3309,
                                  3310,
                                  3311,
                                  3312,
                                  3314,
                                  3315,
                                  3316,
                                  3317,
                                  3318,
                                  3319,
                                  3321,
                                  3322,
                                  3324,
                                  3325,
                                  3326,
                                  3327,
                                  3328,
                                  3329,
                                  3330,
                                  3331,
                                  3332,
                                  3333,
                                  3334,
                                  3335,
                                  3336,
                                  3337,
                                  3338,
                                  3339,
                                  3341,
                                  3342,
                                  3343,
                                  3344,
                                  3345,
                                  3346,
                                  3347,
                                  3348,
                                  3349,
                                  3350,
                                  3351,
                                  3352,
                                  3353,
                                  3354,
                                  3355,
                                  3356,
                                  3357,
                                  3358,
                                  3359,
                                  3360,
                                  3361,
                                  3362,
                                  3363,
                                  3364,
                                  3365,
                                  3366,
                                  3367,
                                  3368,
                                  3369,
                                  3370,
                                  3371,
                                  3372,
                                  3373,
                                  3374,
                                  3375,
                                  3376,
                                  3377,
                                  3378,
                                  3379,
                                  3380,
                                  3381,
                                  3382,
                                  3383,
                                  3384,
                                  3385,
                                  3386,
                                  3387,
                                  3388,
                                  3389,
                                  3390,
                                  3391,
                                  3392,
                                  3393,
                                  3394,
                                  3395,
                                  3396,
                                  3397,
                                  3398,
                                  3399,
                                  3400,
                                  3401,
                                  3402,
                                  3403,
                                  3404,
                                  3405,
                                  3406,
                                  3407,
                                  3408,
                                  3409,
                                  3410,
                                  3411,
                                  3412,
                                  3413,
                                  3414,
                                  3415,
                                  3416,
                                  3417,
                                  3418,
                                  3419,
                                  3420,
                                  3421,
                                  3422,
                                  3423,
                                  3424,
                                  3425,
                                  3426,
                                  3427,
                                  3428,
                                  3429,
                                  3430,
                                  3431,
                                  3432,
                                  3433,
                                  3434,
                                  3435,
                                  3436,
                                  3437,
                                  3438,
                                  3439,
                                  3440,
                                  3441,
                                  3442,
                                  3443,
                                  3444,
                                  3445,
                                  3446,
                                  3447,
                                  3448,
                                  3449,
                                  3450,
                                  3451,
                                  3452,
                                  3453,
                                  3454,
                                  3455,
                                  3456,
                                  3457,
                                  3458,
                                  3459,
                                  3460,
                                  3461,
                                  3462,
                                  3463,
                                  3464,
                                  3465,
                                  3466,
                                  3467,
                                  3468,
                                  3469,
                                  3470,
                                  3471,
                                  3472,
                                  3473,
                                  3474,
                                  3475,
                                  3476,
                                  3477,
                                  3478,
                                  3479,
                                  3480,
                                  3481,
                                  3482,
                                  3483,
                                  3484,
                                  3485,
                                  3486,
                                  3487,
                                  3488,
                                  3489,
                                  3490,
                                  3491,
                                  3492,
                                  3493,
                                  3494,
                                  3495,
                                  3496,
                                  3497,
                                  3498,
                                  3499,
                                  3500,
                                  3501,
                                  3502,
                                  3503,
                                  3504,
                                  4008,
                                  4283,
                                  4284,
                                  4286,
                                  4342,
                                  4343,
                                  4344,
                                  4345,
                                  4346,
                                  4347,
                                  4348,
                                  4349,
                                  4350,
                                  4351,
                                  4352,
                                  4353,
                                  4354,
                                  4355,
                                  4356,
                                  4357,
                                  4358,
                                  4359,
                                  4360,
                                  4361,
                                  4362,
                                  4364,
                                  4365,
                                  4366,
                                  4367,
                                  4368,
                                  4369,
                                  4370,
                                  4371,
                                  4372,
                                  4373,
                                  4374,
                                  4375,
                                  4376,
                                  4378,
                                  4385,
                                  4387,
                                  4388,
                                  4390,
                                  4392,
                                  4394,
                                  4396,
                                  4398,
                                  4417,
                                  4419,
                                  4421,
                                  4423,
                                  4425,
                                  4427,
                                  4429,
                                  4430,
                                  4431,
                                  4433,
                                  4434,
                                  4437,
                                  4440,
                                  4442,
                                  4444,
                                  4446,
                                  4449,
                                  4451,
                                  4455,
                                  4457,
                                  4458,
                                  4460,
                                  4462,
                                  4464,
                                  4467,
                                  4468,
                                  4470,
                                  4472,
                                  4474,
                                  4475,
                                  4477)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
WHERE
  expected_at < '2015-08-31'
  AND IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount
  AND `level_id` IS NOT NULL AND `student_id` IN
                                 (2573,
                                  2574,
                                  2575,
                                  2576,
                                  2577,
                                  2578,
                                  2579,
                                  2580,
                                  2581,
                                  2582,
                                  2583,
                                  2584,
                                  2586,
                                  2587,
                                  2588,
                                  2592,
                                  2593,
                                  2594,
                                  2595,
                                  2596,
                                  2597,
                                  2598,
                                  2599,
                                  2601,
                                  2602,
                                  2603,
                                  2604,
                                  2605,
                                  2606,
                                  2607,
                                  2608,
                                  2609,
                                  2610,
                                  2612,
                                  2613,
                                  2614,
                                  2615,
                                  2616,
                                  2617,
                                  2618,
                                  2619,
                                  2620,
                                  2621,
                                  2622,
                                  2623,
                                  2624,
                                  2625,
                                  2626,
                                  2627,
                                  2628,
                                  2629,
                                  2630,
                                  2631,
                                  2632,
                                  2633,
                                  2634,
                                  2635,
                                  2636,
                                  2637,
                                  2638,
                                  2639,
                                  2640,
                                  2641,
                                  2642,
                                  2643,
                                  2644,
                                  2645,
                                  2646,
                                  2647,
                                  2648,
                                  2649,
                                  2650,
                                  2651,
                                  2652,
                                  2653,
                                  2654,
                                  2655,
                                  2656,
                                  2657,
                                  2658,
                                  2659,
                                  2660,
                                  2661,
                                  2662,
                                  2663,
                                  2664,
                                  2665,
                                  2666,
                                  2667,
                                  2669,
                                  2670,
                                  2671,
                                  2672,
                                  2673,
                                  2674,
                                  2675,
                                  2676,
                                  2677,
                                  2678,
                                  2680,
                                  2681,
                                  2682,
                                  2683,
                                  2684,
                                  2685,
                                  2686,
                                  2687,
                                  2688,
                                  2689,
                                  2690,
                                  2691,
                                  2692,
                                  2693,
                                  2694,
                                  2696,
                                  2697,
                                  2698,
                                  2699,
                                  2700,
                                  2701,
                                  2702,
                                  2703,
                                  2704,
                                  2705,
                                  2706,
                                  2707,
                                  2708,
                                  2709,
                                  2710,
                                  2711,
                                  2714,
                                  2715,
                                  2716,
                                  2717,
                                  2719,
                                  2720,
                                  2721,
                                  2722,
                                  2723,
                                  2724,
                                  2725,
                                  2726,
                                  2728,
                                  2729,
                                  2730,
                                  2731,
                                  2732,
                                  2733,
                                  2734,
                                  2735,
                                  2737,
                                  2738,
                                  2739,
                                  2741,
                                  2743,
                                  2744,
                                  2745,
                                  2746,
                                  2747,
                                  2748,
                                  2749,
                                  2750,
                                  2751,
                                  2752,
                                  2753,
                                  2754,
                                  2755,
                                  2756,
                                  2757,
                                  2758,
                                  2759,
                                  2760,
                                  2761,
                                  2762,
                                  2763,
                                  2764,
                                  2765,
                                  2766,
                                  2767,
                                  2768,
                                  2769,
                                  2770,
                                  2771,
                                  2772,
                                  2774,
                                  2775,
                                  2776,
                                  2777,
                                  2778,
                                  2779,
                                  2780,
                                  2781,
                                  2782,
                                  2783,
                                  2784,
                                  2785,
                                  2786,
                                  2787,
                                  2788,
                                  2789,
                                  2790,
                                  2791,
                                  2792,
                                  2793,
                                  2794,
                                  2795,
                                  2796,
                                  2797,
                                  2798,
                                  2799,
                                  2800,
                                  2801,
                                  2802,
                                  2803,
                                  2804,
                                  2805,
                                  2806,
                                  2807,
                                  2808,
                                  2809,
                                  2810,
                                  2811,
                                  2812,
                                  2813,
                                  2814,
                                  2815,
                                  2816,
                                  2817,
                                  2818,
                                  2820,
                                  2821,
                                  2822,
                                  2823,
                                  2824,
                                  2825,
                                  2826,
                                  2827,
                                  2828,
                                  2829,
                                  2830,
                                  2831,
                                  2832,
                                  2833,
                                  2834,
                                  2835,
                                  2836,
                                  2837,
                                  2838,
                                  2839,
                                  2840,
                                  2841,
                                  2842,
                                  2843,
                                  2844,
                                  2845,
                                  2846,
                                  2847,
                                  2848,
                                  2849,
                                  2850,
                                  2851,
                                  2852,
                                  2853,
                                  2854,
                                  2855,
                                  2856,
                                  2857,
                                  2858,
                                  2859,
                                  2860,
                                  2862,
                                  2863,
                                  2864,
                                  2865,
                                  2866,
                                  2867,
                                  2868,
                                  2869,
                                  2870,
                                  2871,
                                  2872,
                                  2873,
                                  2874,
                                  2875,
                                  2876,
                                  2877,
                                  2879,
                                  2880,
                                  2881,
                                  2882,
                                  2883,
                                  2884,
                                  2885,
                                  2886,
                                  2887,
                                  2888,
                                  2889,
                                  2890,
                                  2891,
                                  2892,
                                  2893,
                                  2894,
                                  2895,
                                  2896,
                                  2897,
                                  2898,
                                  2899,
                                  2900,
                                  2901,
                                  2902,
                                  2903,
                                  2904,
                                  2905,
                                  2906,
                                  2907,
                                  2908,
                                  2909,
                                  2910,
                                  2911,
                                  2912,
                                  2913,
                                  2914,
                                  2915,
                                  2916,
                                  2917,
                                  2918,
                                  2920,
                                  2921,
                                  2922,
                                  2923,
                                  2924,
                                  2925,
                                  2926,
                                  2927,
                                  2928,
                                  2929,
                                  2930,
                                  2931,
                                  2932,
                                  2933,
                                  2934,
                                  2935,
                                  2936,
                                  2937,
                                  2939,
                                  2940,
                                  2941,
                                  2942,
                                  2943,
                                  2944,
                                  2945,
                                  2946,
                                  2947,
                                  2950,
                                  2951,
                                  2952,
                                  2953,
                                  2954,
                                  2955,
                                  2956,
                                  2957,
                                  2958,
                                  2959,
                                  2960,
                                  2961,
                                  2962,
                                  2963,
                                  2964,
                                  2965,
                                  2966,
                                  2967,
                                  2968,
                                  2969,
                                  2970,
                                  2973,
                                  2980,
                                  2981,
                                  2985,
                                  2987,
                                  2988,
                                  2990,
                                  2991,
                                  2992,
                                  2993,
                                  2994,
                                  2995,
                                  2996,
                                  2997,
                                  2998,
                                  2999,
                                  3000,
                                  3001,
                                  3002,
                                  3003,
                                  3004,
                                  3005,
                                  3007,
                                  3008,
                                  3009,
                                  3011,
                                  3012,
                                  3013,
                                  3014,
                                  3015,
                                  3016,
                                  3017,
                                  3018,
                                  3019,
                                  3020,
                                  3021,
                                  3022,
                                  3023,
                                  3024,
                                  3025,
                                  3026,
                                  3027,
                                  3028,
                                  3029,
                                  3030,
                                  3031,
                                  3033,
                                  3034,
                                  3035,
                                  3036,
                                  3037,
                                  3038,
                                  3039,
                                  3040,
                                  3041,
                                  3043,
                                  3044,
                                  3045,
                                  3046,
                                  3047,
                                  3048,
                                  3049,
                                  3050,
                                  3051,
                                  3052,
                                  3053,
                                  3055,
                                  3056,
                                  3057,
                                  3058,
                                  3059,
                                  3060,
                                  3061,
                                  3062,
                                  3063,
                                  3064,
                                  3065,
                                  3066,
                                  3067,
                                  3068,
                                  3069,
                                  3070,
                                  3071,
                                  3073,
                                  3075,
                                  3076,
                                  3077,
                                  3078,
                                  3079,
                                  3080,
                                  3081,
                                  3082,
                                  3083,
                                  3086,
                                  3087,
                                  3089,
                                  3090,
                                  3091,
                                  3092,
                                  3096,
                                  3097,
                                  3098,
                                  3099,
                                  3100,
                                  3101,
                                  3102,
                                  3104,
                                  3105,
                                  3106,
                                  3107,
                                  3109,
                                  3110,
                                  3111,
                                  3112,
                                  3113,
                                  3114,
                                  3115,
                                  3116,
                                  3118,
                                  3119,
                                  3120,
                                  3121,
                                  3122,
                                  3123,
                                  3124,
                                  3125,
                                  3126,
                                  3127,
                                  3129,
                                  3130,
                                  3131,
                                  3132,
                                  3133,
                                  3134,
                                  3135,
                                  3136,
                                  3137,
                                  3139,
                                  3140,
                                  3141,
                                  3142,
                                  3143,
                                  3144,
                                  3146,
                                  3147,
                                  3148,
                                  3149,
                                  3150,
                                  3151,
                                  3154,
                                  3155,
                                  3156,
                                  3157,
                                  3158,
                                  3159,
                                  3160,
                                  3161,
                                  3162,
                                  3163,
                                  3164,
                                  3165,
                                  3166,
                                  3167,
                                  3168,
                                  3169,
                                  3170,
                                  3171,
                                  3172,
                                  3173,
                                  3174,
                                  3176,
                                  3177,
                                  3178,
                                  3179,
                                  3180,
                                  3181,
                                  3182,
                                  3183,
                                  3184,
                                  3186,
                                  3187,
                                  3189,
                                  3190,
                                  3191,
                                  3192,
                                  3193,
                                  3194,
                                  3195,
                                  3196,
                                  3197,
                                  3198,
                                  3199,
                                  3200,
                                  3201,
                                  3202,
                                  3203,
                                  3204,
                                  3205,
                                  3206,
                                  3207,
                                  3208,
                                  3209,
                                  3210,
                                  3211,
                                  3212,
                                  3213,
                                  3214,
                                  3215,
                                  3216,
                                  3217,
                                  3218,
                                  3219,
                                  3220,
                                  3221,
                                  3222,
                                  3223,
                                  3224,
                                  3225,
                                  3226,
                                  3227,
                                  3228,
                                  3229,
                                  3230,
                                  3231,
                                  3232,
                                  3233,
                                  3234,
                                  3235,
                                  3236,
                                  3237,
                                  3238,
                                  3239,
                                  3240,
                                  3241,
                                  3242,
                                  3243,
                                  3244,
                                  3245,
                                  3246,
                                  3247,
                                  3248,
                                  3249,
                                  3250,
                                  3251,
                                  3252,
                                  3253,
                                  3254,
                                  3255,
                                  3256,
                                  3257,
                                  3258,
                                  3259,
                                  3260,
                                  3262,
                                  3264,
                                  3265,
                                  3267,
                                  3269,
                                  3270,
                                  3271,
                                  3272,
                                  3273,
                                  3274,
                                  3275,
                                  3276,
                                  3278,
                                  3279,
                                  3280,
                                  3281,
                                  3285,
                                  3286,
                                  3287,
                                  3289,
                                  3290,
                                  3291,
                                  3292,
                                  3293,
                                  3294,
                                  3295,
                                  3296,
                                  3297,
                                  3298,
                                  3299,
                                  3300,
                                  3301,
                                  3302,
                                  3303,
                                  3304,
                                  3305,
                                  3306,
                                  3307,
                                  3308,
                                  3309,
                                  3310,
                                  3311,
                                  3312,
                                  3314,
                                  3315,
                                  3316,
                                  3317,
                                  3318,
                                  3319,
                                  3321,
                                  3322,
                                  3324,
                                  3325,
                                  3326,
                                  3327,
                                  3328,
                                  3329,
                                  3330,
                                  3331,
                                  3332,
                                  3333,
                                  3334,
                                  3335,
                                  3336,
                                  3337,
                                  3338,
                                  3339,
                                  3341,
                                  3342,
                                  3343,
                                  3344,
                                  3345,
                                  3346,
                                  3347,
                                  3348,
                                  3349,
                                  3350,
                                  3351,
                                  3352,
                                  3353,
                                  3354,
                                  3355,
                                  3356,
                                  3357,
                                  3358,
                                  3359,
                                  3360,
                                  3361,
                                  3362,
                                  3363,
                                  3364,
                                  3365,
                                  3366,
                                  3367,
                                  3368,
                                  3369,
                                  3370,
                                  3371,
                                  3372,
                                  3373,
                                  3374,
                                  3375,
                                  3376,
                                  3377,
                                  3378,
                                  3379,
                                  3380,
                                  3381,
                                  3382,
                                  3383,
                                  3384,
                                  3385,
                                  3386,
                                  3387,
                                  3388,
                                  3389,
                                  3390,
                                  3391,
                                  3392,
                                  3393,
                                  3394,
                                  3395,
                                  3396,
                                  3397,
                                  3398,
                                  3399,
                                  3400,
                                  3401,
                                  3402,
                                  3403,
                                  3404,
                                  3405,
                                  3406,
                                  3407,
                                  3408,
                                  3409,
                                  3410,
                                  3411,
                                  3412,
                                  3413,
                                  3414,
                                  3415,
                                  3416,
                                  3417,
                                  3418,
                                  3419,
                                  3420,
                                  3421,
                                  3422,
                                  3423,
                                  3424,
                                  3425,
                                  3426,
                                  3427,
                                  3428,
                                  3429,
                                  3430,
                                  3431,
                                  3432,
                                  3433,
                                  3434,
                                  3435,
                                  3436,
                                  3437,
                                  3438,
                                  3439,
                                  3440,
                                  3441,
                                  3442,
                                  3443,
                                  3444,
                                  3445,
                                  3446,
                                  3447,
                                  3448,
                                  3449,
                                  3450,
                                  3451,
                                  3452,
                                  3453,
                                  3454,
                                  3455,
                                  3456,
                                  3457,
                                  3458,
                                  3459,
                                  3460,
                                  3461,
                                  3462,
                                  3463,
                                  3464,
                                  3465,
                                  3466,
                                  3467,
                                  3468,
                                  3469,
                                  3470,
                                  3471,
                                  3472,
                                  3473,
                                  3474,
                                  3475,
                                  3476,
                                  3477,
                                  3478,
                                  3479,
                                  3480,
                                  3481,
                                  3482,
                                  3483,
                                  3484,
                                  3485,
                                  3486,
                                  3487,
                                  3488,
                                  3489,
                                  3490,
                                  3491,
                                  3492,
                                  3493,
                                  3494,
                                  3495,
                                  3496,
                                  3497,
                                  3498,
                                  3499,
                                  3500,
                                  3501,
                                  3502,
                                  3503,
                                  3504,
                                  4008,
                                  4283,
                                  4284,
                                  4286,
                                  4342,
                                  4343,
                                  4344,
                                  4345,
                                  4346,
                                  4347,
                                  4348,
                                  4349,
                                  4350,
                                  4351,
                                  4352,
                                  4353,
                                  4354,
                                  4355,
                                  4356,
                                  4357,
                                  4358,
                                  4359,
                                  4360,
                                  4361,
                                  4362,
                                  4364,
                                  4365,
                                  4366,
                                  4367,
                                  4368,
                                  4369,
                                  4370,
                                  4371,
                                  4372,
                                  4373,
                                  4374,
                                  4375,
                                  4376,
                                  4378,
                                  4385,
                                  4387,
                                  4388,
                                  4390,
                                  4392,
                                  4394,
                                  4396,
                                  4398,
                                  4417,
                                  4419,
                                  4421,
                                  4423,
                                  4425,
                                  4427,
                                  4429,
                                  4430,
                                  4431,
                                  4433,
                                  4434,
                                  4437,
                                  4440,
                                  4442,
                                  4444,
                                  4446,
                                  4449,
                                  4451,
                                  4455,
                                  4457,
                                  4458,
                                  4460,
                                  4462,
                                  4464,
                                  4467,
                                  4468,
                                  4470,
                                  4472,
                                  4474,
                                  4475,
                                  4477)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
  LEFT JOIN `student_tuition_payed`
    ON `student_tuition_detail`.`id` = `student_tuition_payed`.`student_tuition_id`
WHERE
  expected_at < '2015-08-31'
  AND IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount
  AND `level_id` IS NOT NULL AND `student_id` IN
                                 (2573,
                                  2574,
                                  2575,
                                  2576,
                                  2577,
                                  2578,
                                  2579,
                                  2580,
                                  2581,
                                  2582,
                                  2583,
                                  2584,
                                  2586,
                                  2587,
                                  2588,
                                  2592,
                                  2593,
                                  2594,
                                  2595,
                                  2596,
                                  2597,
                                  2598,
                                  2599,
                                  2601,
                                  2602,
                                  2603,
                                  2604,
                                  2605,
                                  2606,
                                  2607,
                                  2608,
                                  2609,
                                  2610,
                                  2612,
                                  2613,
                                  2614,
                                  2615,
                                  2616,
                                  2617,
                                  2618,
                                  2619,
                                  2620,
                                  2621,
                                  2622,
                                  2623,
                                  2624,
                                  2625,
                                  2626,
                                  2627,
                                  2628,
                                  2629,
                                  2630,
                                  2631,
                                  2632,
                                  2633,
                                  2634,
                                  2635,
                                  2636,
                                  2637,
                                  2638,
                                  2639,
                                  2640,
                                  2641,
                                  2642,
                                  2643,
                                  2644,
                                  2645,
                                  2646,
                                  2647,
                                  2648,
                                  2649,
                                  2650,
                                  2651,
                                  2652,
                                  2653,
                                  2654,
                                  2655,
                                  2656,
                                  2657,
                                  2658,
                                  2659,
                                  2660,
                                  2661,
                                  2662,
                                  2663,
                                  2664,
                                  2665,
                                  2666,
                                  2667,
                                  2669,
                                  2670,
                                  2671,
                                  2672,
                                  2673,
                                  2674,
                                  2675,
                                  2676,
                                  2677,
                                  2678,
                                  2680,
                                  2681,
                                  2682,
                                  2683,
                                  2684,
                                  2685,
                                  2686,
                                  2687,
                                  2688,
                                  2689,
                                  2690,
                                  2691,
                                  2692,
                                  2693,
                                  2694,
                                  2696,
                                  2697,
                                  2698,
                                  2699,
                                  2700,
                                  2701,
                                  2702,
                                  2703,
                                  2704,
                                  2705,
                                  2706,
                                  2707,
                                  2708,
                                  2709,
                                  2710,
                                  2711,
                                  2714,
                                  2715,
                                  2716,
                                  2717,
                                  2719,
                                  2720,
                                  2721,
                                  2722,
                                  2723,
                                  2724,
                                  2725,
                                  2726,
                                  2728,
                                  2729,
                                  2730,
                                  2731,
                                  2732,
                                  2733,
                                  2734,
                                  2735,
                                  2737,
                                  2738,
                                  2739,
                                  2741,
                                  2743,
                                  2744,
                                  2745,
                                  2746,
                                  2747,
                                  2748,
                                  2749,
                                  2750,
                                  2751,
                                  2752,
                                  2753,
                                  2754,
                                  2755,
                                  2756,
                                  2757,
                                  2758,
                                  2759,
                                  2760,
                                  2761,
                                  2762,
                                  2763,
                                  2764,
                                  2765,
                                  2766,
                                  2767,
                                  2768,
                                  2769,
                                  2770,
                                  2771,
                                  2772,
                                  2774,
                                  2775,
                                  2776,
                                  2777,
                                  2778,
                                  2779,
                                  2780,
                                  2781,
                                  2782,
                                  2783,
                                  2784,
                                  2785,
                                  2786,
                                  2787,
                                  2788,
                                  2789,
                                  2790,
                                  2791,
                                  2792,
                                  2793,
                                  2794,
                                  2795,
                                  2796,
                                  2797,
                                  2798,
                                  2799,
                                  2800,
                                  2801,
                                  2802,
                                  2803,
                                  2804,
                                  2805,
                                  2806,
                                  2807,
                                  2808,
                                  2809,
                                  2810,
                                  2811,
                                  2812,
                                  2813,
                                  2814,
                                  2815,
                                  2816,
                                  2817,
                                  2818,
                                  2820,
                                  2821,
                                  2822,
                                  2823,
                                  2824,
                                  2825,
                                  2826,
                                  2827,
                                  2828,
                                  2829,
                                  2830,
                                  2831,
                                  2832,
                                  2833,
                                  2834,
                                  2835,
                                  2836,
                                  2837,
                                  2838,
                                  2839,
                                  2840,
                                  2841,
                                  2842,
                                  2843,
                                  2844,
                                  2845,
                                  2846,
                                  2847,
                                  2848,
                                  2849,
                                  2850,
                                  2851,
                                  2852,
                                  2853,
                                  2854,
                                  2855,
                                  2856,
                                  2857,
                                  2858,
                                  2859,
                                  2860,
                                  2862,
                                  2863,
                                  2864,
                                  2865,
                                  2866,
                                  2867,
                                  2868,
                                  2869,
                                  2870,
                                  2871,
                                  2872,
                                  2873,
                                  2874,
                                  2875,
                                  2876,
                                  2877,
                                  2879,
                                  2880,
                                  2881,
                                  2882,
                                  2883,
                                  2884,
                                  2885,
                                  2886,
                                  2887,
                                  2888,
                                  2889,
                                  2890,
                                  2891,
                                  2892,
                                  2893,
                                  2894,
                                  2895,
                                  2896,
                                  2897,
                                  2898,
                                  2899,
                                  2900,
                                  2901,
                                  2902,
                                  2903,
                                  2904,
                                  2905,
                                  2906,
                                  2907,
                                  2908,
                                  2909,
                                  2910,
                                  2911,
                                  2912,
                                  2913,
                                  2914,
                                  2915,
                                  2916,
                                  2917,
                                  2918,
                                  2920,
                                  2921,
                                  2922,
                                  2923,
                                  2924,
                                  2925,
                                  2926,
                                  2927,
                                  2928,
                                  2929,
                                  2930,
                                  2931,
                                  2932,
                                  2933,
                                  2934,
                                  2935,
                                  2936,
                                  2937,
                                  2939,
                                  2940,
                                  2941,
                                  2942,
                                  2943,
                                  2944,
                                  2945,
                                  2946,
                                  2947,
                                  2950,
                                  2951,
                                  2952,
                                  2953,
                                  2954,
                                  2955,
                                  2956,
                                  2957,
                                  2958,
                                  2959,
                                  2960,
                                  2961,
                                  2962,
                                  2963,
                                  2964,
                                  2965,
                                  2966,
                                  2967,
                                  2968,
                                  2969,
                                  2970,
                                  2973,
                                  2980,
                                  2981,
                                  2985,
                                  2987,
                                  2988,
                                  2990,
                                  2991,
                                  2992,
                                  2993,
                                  2994,
                                  2995,
                                  2996,
                                  2997,
                                  2998,
                                  2999,
                                  3000,
                                  3001,
                                  3002,
                                  3003,
                                  3004,
                                  3005,
                                  3007,
                                  3008,
                                  3009,
                                  3011,
                                  3012,
                                  3013,
                                  3014,
                                  3015,
                                  3016,
                                  3017,
                                  3018,
                                  3019,
                                  3020,
                                  3021,
                                  3022,
                                  3023,
                                  3024,
                                  3025,
                                  3026,
                                  3027,
                                  3028,
                                  3029,
                                  3030,
                                  3031,
                                  3033,
                                  3034,
                                  3035,
                                  3036,
                                  3037,
                                  3038,
                                  3039,
                                  3040,
                                  3041,
                                  3043,
                                  3044,
                                  3045,
                                  3046,
                                  3047,
                                  3048,
                                  3049,
                                  3050,
                                  3051,
                                  3052,
                                  3053,
                                  3055,
                                  3056,
                                  3057,
                                  3058,
                                  3059,
                                  3060,
                                  3061,
                                  3062,
                                  3063,
                                  3064,
                                  3065,
                                  3066,
                                  3067,
                                  3068,
                                  3069,
                                  3070,
                                  3071,
                                  3073,
                                  3075,
                                  3076,
                                  3077,
                                  3078,
                                  3079,
                                  3080,
                                  3081,
                                  3082,
                                  3083,
                                  3086,
                                  3087,
                                  3089,
                                  3090,
                                  3091,
                                  3092,
                                  3096,
                                  3097,
                                  3098,
                                  3099,
                                  3100,
                                  3101,
                                  3102,
                                  3104,
                                  3105,
                                  3106,
                                  3107,
                                  3109,
                                  3110,
                                  3111,
                                  3112,
                                  3113,
                                  3114,
                                  3115,
                                  3116,
                                  3118,
                                  3119,
                                  3120,
                                  3121,
                                  3122,
                                  3123,
                                  3124,
                                  3125,
                                  3126,
                                  3127,
                                  3129,
                                  3130,
                                  3131,
                                  3132,
                                  3133,
                                  3134,
                                  3135,
                                  3136,
                                  3137,
                                  3139,
                                  3140,
                                  3141,
                                  3142,
                                  3143,
                                  3144,
                                  3146,
                                  3147,
                                  3148,
                                  3149,
                                  3150,
                                  3151,
                                  3154,
                                  3155,
                                  3156,
                                  3157,
                                  3158,
                                  3159,
                                  3160,
                                  3161,
                                  3162,
                                  3163,
                                  3164,
                                  3165,
                                  3166,
                                  3167,
                                  3168,
                                  3169,
                                  3170,
                                  3171,
                                  3172,
                                  3173,
                                  3174,
                                  3176,
                                  3177,
                                  3178,
                                  3179,
                                  3180,
                                  3181,
                                  3182,
                                  3183,
                                  3184,
                                  3186,
                                  3187,
                                  3189,
                                  3190,
                                  3191,
                                  3192,
                                  3193,
                                  3194,
                                  3195,
                                  3196,
                                  3197,
                                  3198,
                                  3199,
                                  3200,
                                  3201,
                                  3202,
                                  3203,
                                  3204,
                                  3205,
                                  3206,
                                  3207,
                                  3208,
                                  3209,
                                  3210,
                                  3211,
                                  3212,
                                  3213,
                                  3214,
                                  3215,
                                  3216,
                                  3217,
                                  3218,
                                  3219,
                                  3220,
                                  3221,
                                  3222,
                                  3223,
                                  3224,
                                  3225,
                                  3226,
                                  3227,
                                  3228,
                                  3229,
                                  3230,
                                  3231,
                                  3232,
                                  3233,
                                  3234,
                                  3235,
                                  3236,
                                  3237,
                                  3238,
                                  3239,
                                  3240,
                                  3241,
                                  3242,
                                  3243,
                                  3244,
                                  3245,
                                  3246,
                                  3247,
                                  3248,
                                  3249,
                                  3250,
                                  3251,
                                  3252,
                                  3253,
                                  3254,
                                  3255,
                                  3256,
                                  3257,
                                  3258,
                                  3259,
                                  3260,
                                  3262,
                                  3264,
                                  3265,
                                  3267,
                                  3269,
                                  3270,
                                  3271,
                                  3272,
                                  3273,
                                  3274,
                                  3275,
                                  3276,
                                  3278,
                                  3279,
                                  3280,
                                  3281,
                                  3285,
                                  3286,
                                  3287,
                                  3289,
                                  3290,
                                  3291,
                                  3292,
                                  3293,
                                  3294,
                                  3295,
                                  3296,
                                  3297,
                                  3298,
                                  3299,
                                  3300,
                                  3301,
                                  3302,
                                  3303,
                                  3304,
                                  3305,
                                  3306,
                                  3307,
                                  3308,
                                  3309,
                                  3310,
                                  3311,
                                  3312,
                                  3314,
                                  3315,
                                  3316,
                                  3317,
                                  3318,
                                  3319,
                                  3321,
                                  3322,
                                  3324,
                                  3325,
                                  3326,
                                  3327,
                                  3328,
                                  3329,
                                  3330,
                                  3331,
                                  3332,
                                  3333,
                                  3334,
                                  3335,
                                  3336,
                                  3337,
                                  3338,
                                  3339,
                                  3341,
                                  3342,
                                  3343,
                                  3344,
                                  3345,
                                  3346,
                                  3347,
                                  3348,
                                  3349,
                                  3350,
                                  3351,
                                  3352,
                                  3353,
                                  3354,
                                  3355,
                                  3356,
                                  3357,
                                  3358,
                                  3359,
                                  3360,
                                  3361,
                                  3362,
                                  3363,
                                  3364,
                                  3365,
                                  3366,
                                  3367,
                                  3368,
                                  3369,
                                  3370,
                                  3371,
                                  3372,
                                  3373,
                                  3374,
                                  3375,
                                  3376,
                                  3377,
                                  3378,
                                  3379,
                                  3380,
                                  3381,
                                  3382,
                                  3383,
                                  3384,
                                  3385,
                                  3386,
                                  3387,
                                  3388,
                                  3389,
                                  3390,
                                  3391,
                                  3392,
                                  3393,
                                  3394,
                                  3395,
                                  3396,
                                  3397,
                                  3398,
                                  3399,
                                  3400,
                                  3401,
                                  3402,
                                  3403,
                                  3404,
                                  3405,
                                  3406,
                                  3407,
                                  3408,
                                  3409,
                                  3410,
                                  3411,
                                  3412,
                                  3413,
                                  3414,
                                  3415,
                                  3416,
                                  3417,
                                  3418,
                                  3419,
                                  3420,
                                  3421,
                                  3422,
                                  3423,
                                  3424,
                                  3425,
                                  3426,
                                  3427,
                                  3428,
                                  3429,
                                  3430,
                                  3431,
                                  3432,
                                  3433,
                                  3434,
                                  3435,
                                  3436,
                                  3437,
                                  3438,
                                  3439,
                                  3440,
                                  3441,
                                  3442,
                                  3443,
                                  3444,
                                  3445,
                                  3446,
                                  3447,
                                  3448,
                                  3449,
                                  3450,
                                  3451,
                                  3452,
                                  3453,
                                  3454,
                                  3455,
                                  3456,
                                  3457,
                                  3458,
                                  3459,
                                  3460,
                                  3461,
                                  3462,
                                  3463,
                                  3464,
                                  3465,
                                  3466,
                                  3467,
                                  3468,
                                  3469,
                                  3470,
                                  3471,
                                  3472,
                                  3473,
                                  3474,
                                  3475,
                                  3476,
                                  3477,
                                  3478,
                                  3479,
                                  3480,
                                  3481,
                                  3482,
                                  3483,
                                  3484,
                                  3485,
                                  3486,
                                  3487,
                                  3488,
                                  3489,
                                  3490,
                                  3491,
                                  3492,
                                  3493,
                                  3494,
                                  3495,
                                  3496,
                                  3497,
                                  3498,
                                  3499,
                                  3500,
                                  3501,
                                  3502,
                                  3503,
                                  3504,
                                  4008,
                                  4283,
                                  4284,
                                  4286,
                                  4342,
                                  4343,
                                  4344,
                                  4345,
                                  4346,
                                  4347,
                                  4348,
                                  4349,
                                  4350,
                                  4351,
                                  4352,
                                  4353,
                                  4354,
                                  4355,
                                  4356,
                                  4357,
                                  4358,
                                  4359,
                                  4360,
                                  4361,
                                  4362,
                                  4364,
                                  4365,
                                  4366,
                                  4367,
                                  4368,
                                  4369,
                                  4370,
                                  4371,
                                  4372,
                                  4373,
                                  4374,
                                  4375,
                                  4376,
                                  4378,
                                  4385,
                                  4387,
                                  4388,
                                  4390,
                                  4392,
                                  4394,
                                  4396,
                                  4398,
                                  4417,
                                  4419,
                                  4421,
                                  4423,
                                  4425,
                                  4427,
                                  4429,
                                  4430,
                                  4431,
                                  4433,
                                  4434,
                                  4437,
                                  4440,
                                  4442,
                                  4444,
                                  4446,
                                  4449,
                                  4451,
                                  4455,
                                  4457,
                                  4458,
                                  4460,
                                  4462,
                                  4464,
                                  4467,
                                  4468,
                                  4470,
                                  4472,
                                  4474,
                                  4475,
                                  4477)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
  LEFT JOIN `student_tuition_payed`
    ON `student_tuition_detail`.`id` = `student_tuition_payed`.`student_tuition_id`
WHERE
  expected_at < '2015-08-20'
  AND IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount
  AND `level_id` IS NOT NULL AND `student_id` IN
                                 (2573,
                                  2574,
                                  2575,
                                  2576,
                                  2577,
                                  2578,
                                  2579,
                                  2580,
                                  2581,
                                  2582,
                                  2583,
                                  2584,
                                  2586,
                                  2587,
                                  2588,
                                  2592,
                                  2593,
                                  2594,
                                  2595,
                                  2596,
                                  2597,
                                  2598,
                                  2599,
                                  2601,
                                  2602,
                                  2603,
                                  2604,
                                  2605,
                                  2606,
                                  2607,
                                  2608,
                                  2609,
                                  2610,
                                  2612,
                                  2613,
                                  2614,
                                  2615,
                                  2616,
                                  2617,
                                  2618,
                                  2619,
                                  2620,
                                  2621,
                                  2622,
                                  2623,
                                  2624,
                                  2625,
                                  2626,
                                  2627,
                                  2628,
                                  2629,
                                  2630,
                                  2631,
                                  2632,
                                  2633,
                                  2634,
                                  2635,
                                  2636,
                                  2637,
                                  2638,
                                  2639,
                                  2640,
                                  2641,
                                  2642,
                                  2643,
                                  2644,
                                  2645,
                                  2646,
                                  2647,
                                  2648,
                                  2649,
                                  2650,
                                  2651,
                                  2652,
                                  2653,
                                  2654,
                                  2655,
                                  2656,
                                  2657,
                                  2658,
                                  2659,
                                  2660,
                                  2661,
                                  2662,
                                  2663,
                                  2664,
                                  2665,
                                  2666,
                                  2667,
                                  2669,
                                  2670,
                                  2671,
                                  2672,
                                  2673,
                                  2674,
                                  2675,
                                  2676,
                                  2677,
                                  2678,
                                  2680,
                                  2681,
                                  2682,
                                  2683,
                                  2684,
                                  2685,
                                  2686,
                                  2687,
                                  2688,
                                  2689,
                                  2690,
                                  2691,
                                  2692,
                                  2693,
                                  2694,
                                  2696,
                                  2697,
                                  2698,
                                  2699,
                                  2700,
                                  2701,
                                  2702,
                                  2703,
                                  2704,
                                  2705,
                                  2706,
                                  2707,
                                  2708,
                                  2709,
                                  2710,
                                  2711,
                                  2714,
                                  2715,
                                  2716,
                                  2717,
                                  2719,
                                  2720,
                                  2721,
                                  2722,
                                  2723,
                                  2724,
                                  2725,
                                  2726,
                                  2728,
                                  2729,
                                  2730,
                                  2731,
                                  2732,
                                  2733,
                                  2734,
                                  2735,
                                  2737,
                                  2738,
                                  2739,
                                  2741,
                                  2743,
                                  2744,
                                  2745,
                                  2746,
                                  2747,
                                  2748,
                                  2749,
                                  2750,
                                  2751,
                                  2752,
                                  2753,
                                  2754,
                                  2755,
                                  2756,
                                  2757,
                                  2758,
                                  2759,
                                  2760,
                                  2761,
                                  2762,
                                  2763,
                                  2764,
                                  2765,
                                  2766,
                                  2767,
                                  2768,
                                  2769,
                                  2770,
                                  2771,
                                  2772,
                                  2774,
                                  2775,
                                  2776,
                                  2777,
                                  2778,
                                  2779,
                                  2780,
                                  2781,
                                  2782,
                                  2783,
                                  2784,
                                  2785,
                                  2786,
                                  2787,
                                  2788,
                                  2789,
                                  2790,
                                  2791,
                                  2792,
                                  2793,
                                  2794,
                                  2795,
                                  2796,
                                  2797,
                                  2798,
                                  2799,
                                  2800,
                                  2801,
                                  2802,
                                  2803,
                                  2804,
                                  2805,
                                  2806,
                                  2807,
                                  2808,
                                  2809,
                                  2810,
                                  2811,
                                  2812,
                                  2813,
                                  2814,
                                  2815,
                                  2816,
                                  2817,
                                  2818,
                                  2820,
                                  2821,
                                  2822,
                                  2823,
                                  2824,
                                  2825,
                                  2826,
                                  2827,
                                  2828,
                                  2829,
                                  2830,
                                  2831,
                                  2832,
                                  2833,
                                  2834,
                                  2835,
                                  2836,
                                  2837,
                                  2838,
                                  2839,
                                  2840,
                                  2841,
                                  2842,
                                  2843,
                                  2844,
                                  2845,
                                  2846,
                                  2847,
                                  2848,
                                  2849,
                                  2850,
                                  2851,
                                  2852,
                                  2853,
                                  2854,
                                  2855,
                                  2856,
                                  2857,
                                  2858,
                                  2859,
                                  2860,
                                  2862,
                                  2863,
                                  2864,
                                  2865,
                                  2866,
                                  2867,
                                  2868,
                                  2869,
                                  2870,
                                  2871,
                                  2872,
                                  2873,
                                  2874,
                                  2875,
                                  2876,
                                  2877,
                                  2879,
                                  2880,
                                  2881,
                                  2882,
                                  2883,
                                  2884,
                                  2885,
                                  2886,
                                  2887,
                                  2888,
                                  2889,
                                  2890,
                                  2891,
                                  2892,
                                  2893,
                                  2894,
                                  2895,
                                  2896,
                                  2897,
                                  2898,
                                  2899,
                                  2900,
                                  2901,
                                  2902,
                                  2903,
                                  2904,
                                  2905,
                                  2906,
                                  2907,
                                  2908,
                                  2909,
                                  2910,
                                  2911,
                                  2912,
                                  2913,
                                  2914,
                                  2915,
                                  2916,
                                  2917,
                                  2918,
                                  2920,
                                  2921,
                                  2922,
                                  2923,
                                  2924,
                                  2925,
                                  2926,
                                  2927,
                                  2928,
                                  2929,
                                  2930,
                                  2931,
                                  2932,
                                  2933,
                                  2934,
                                  2935,
                                  2936,
                                  2937,
                                  2939,
                                  2940,
                                  2941,
                                  2942,
                                  2943,
                                  2944,
                                  2945,
                                  2946,
                                  2947,
                                  2950,
                                  2951,
                                  2952,
                                  2953,
                                  2954,
                                  2955,
                                  2956,
                                  2957,
                                  2958,
                                  2959,
                                  2960,
                                  2961,
                                  2962,
                                  2963,
                                  2964,
                                  2965,
                                  2966,
                                  2967,
                                  2968,
                                  2969,
                                  2970,
                                  2973,
                                  2980,
                                  2981,
                                  2985,
                                  2987,
                                  2988,
                                  2990,
                                  2991,
                                  2992,
                                  2993,
                                  2994,
                                  2995,
                                  2996,
                                  2997,
                                  2998,
                                  2999,
                                  3000,
                                  3001,
                                  3002,
                                  3003,
                                  3004,
                                  3005,
                                  3007,
                                  3008,
                                  3009,
                                  3011,
                                  3012,
                                  3013,
                                  3014,
                                  3015,
                                  3016,
                                  3017,
                                  3018,
                                  3019,
                                  3020,
                                  3021,
                                  3022,
                                  3023,
                                  3024,
                                  3025,
                                  3026,
                                  3027,
                                  3028,
                                  3029,
                                  3030,
                                  3031,
                                  3033,
                                  3034,
                                  3035,
                                  3036,
                                  3037,
                                  3038,
                                  3039,
                                  3040,
                                  3041,
                                  3043,
                                  3044,
                                  3045,
                                  3046,
                                  3047,
                                  3048,
                                  3049,
                                  3050,
                                  3051,
                                  3052,
                                  3053,
                                  3055,
                                  3056,
                                  3057,
                                  3058,
                                  3059,
                                  3060,
                                  3061,
                                  3062,
                                  3063,
                                  3064,
                                  3065,
                                  3066,
                                  3067,
                                  3068,
                                  3069,
                                  3070,
                                  3071,
                                  3073,
                                  3075,
                                  3076,
                                  3077,
                                  3078,
                                  3079,
                                  3080,
                                  3081,
                                  3082,
                                  3083,
                                  3086,
                                  3087,
                                  3089,
                                  3090,
                                  3091,
                                  3092,
                                  3096,
                                  3097,
                                  3098,
                                  3099,
                                  3100,
                                  3101,
                                  3102,
                                  3104,
                                  3105,
                                  3106,
                                  3107,
                                  3109,
                                  3110,
                                  3111,
                                  3112,
                                  3113,
                                  3114,
                                  3115,
                                  3116,
                                  3118,
                                  3119,
                                  3120,
                                  3121,
                                  3122,
                                  3123,
                                  3124,
                                  3125,
                                  3126,
                                  3127,
                                  3129,
                                  3130,
                                  3131,
                                  3132,
                                  3133,
                                  3134,
                                  3135,
                                  3136,
                                  3137,
                                  3139,
                                  3140,
                                  3141,
                                  3142,
                                  3143,
                                  3144,
                                  3146,
                                  3147,
                                  3148,
                                  3149,
                                  3150,
                                  3151,
                                  3154,
                                  3155,
                                  3156,
                                  3157,
                                  3158,
                                  3159,
                                  3160,
                                  3161,
                                  3162,
                                  3163,
                                  3164,
                                  3165,
                                  3166,
                                  3167,
                                  3168,
                                  3169,
                                  3170,
                                  3171,
                                  3172,
                                  3173,
                                  3174,
                                  3176,
                                  3177,
                                  3178,
                                  3179,
                                  3180,
                                  3181,
                                  3182,
                                  3183,
                                  3184,
                                  3186,
                                  3187,
                                  3189,
                                  3190,
                                  3191,
                                  3192,
                                  3193,
                                  3194,
                                  3195,
                                  3196,
                                  3197,
                                  3198,
                                  3199,
                                  3200,
                                  3201,
                                  3202,
                                  3203,
                                  3204,
                                  3205,
                                  3206,
                                  3207,
                                  3208,
                                  3209,
                                  3210,
                                  3211,
                                  3212,
                                  3213,
                                  3214,
                                  3215,
                                  3216,
                                  3217,
                                  3218,
                                  3219,
                                  3220,
                                  3221,
                                  3222,
                                  3223,
                                  3224,
                                  3225,
                                  3226,
                                  3227,
                                  3228,
                                  3229,
                                  3230,
                                  3231,
                                  3232,
                                  3233,
                                  3234,
                                  3235,
                                  3236,
                                  3237,
                                  3238,
                                  3239,
                                  3240,
                                  3241,
                                  3242,
                                  3243,
                                  3244,
                                  3245,
                                  3246,
                                  3247,
                                  3248,
                                  3249,
                                  3250,
                                  3251,
                                  3252,
                                  3253,
                                  3254,
                                  3255,
                                  3256,
                                  3257,
                                  3258,
                                  3259,
                                  3260,
                                  3262,
                                  3264,
                                  3265,
                                  3267,
                                  3269,
                                  3270,
                                  3271,
                                  3272,
                                  3273,
                                  3274,
                                  3275,
                                  3276,
                                  3278,
                                  3279,
                                  3280,
                                  3281,
                                  3285,
                                  3286,
                                  3287,
                                  3289,
                                  3290,
                                  3291,
                                  3292,
                                  3293,
                                  3294,
                                  3295,
                                  3296,
                                  3297,
                                  3298,
                                  3299,
                                  3300,
                                  3301,
                                  3302,
                                  3303,
                                  3304,
                                  3305,
                                  3306,
                                  3307,
                                  3308,
                                  3309,
                                  3310,
                                  3311,
                                  3312,
                                  3314,
                                  3315,
                                  3316,
                                  3317,
                                  3318,
                                  3319,
                                  3321,
                                  3322,
                                  3324,
                                  3325,
                                  3326,
                                  3327,
                                  3328,
                                  3329,
                                  3330,
                                  3331,
                                  3332,
                                  3333,
                                  3334,
                                  3335,
                                  3336,
                                  3337,
                                  3338,
                                  3339,
                                  3341,
                                  3342,
                                  3343,
                                  3344,
                                  3345,
                                  3346,
                                  3347,
                                  3348,
                                  3349,
                                  3350,
                                  3351,
                                  3352,
                                  3353,
                                  3354,
                                  3355,
                                  3356,
                                  3357,
                                  3358,
                                  3359,
                                  3360,
                                  3361,
                                  3362,
                                  3363,
                                  3364,
                                  3365,
                                  3366,
                                  3367,
                                  3368,
                                  3369,
                                  3370,
                                  3371,
                                  3372,
                                  3373,
                                  3374,
                                  3375,
                                  3376,
                                  3377,
                                  3378,
                                  3379,
                                  3380,
                                  3381,
                                  3382,
                                  3383,
                                  3384,
                                  3385,
                                  3386,
                                  3387,
                                  3388,
                                  3389,
                                  3390,
                                  3391,
                                  3392,
                                  3393,
                                  3394,
                                  3395,
                                  3396,
                                  3397,
                                  3398,
                                  3399,
                                  3400,
                                  3401,
                                  3402,
                                  3403,
                                  3404,
                                  3405,
                                  3406,
                                  3407,
                                  3408,
                                  3409,
                                  3410,
                                  3411,
                                  3412,
                                  3413,
                                  3414,
                                  3415,
                                  3416,
                                  3417,
                                  3418,
                                  3419,
                                  3420,
                                  3421,
                                  3422,
                                  3423,
                                  3424,
                                  3425,
                                  3426,
                                  3427,
                                  3428,
                                  3429,
                                  3430,
                                  3431,
                                  3432,
                                  3433,
                                  3434,
                                  3435,
                                  3436,
                                  3437,
                                  3438,
                                  3439,
                                  3440,
                                  3441,
                                  3442,
                                  3443,
                                  3444,
                                  3445,
                                  3446,
                                  3447,
                                  3448,
                                  3449,
                                  3450,
                                  3451,
                                  3452,
                                  3453,
                                  3454,
                                  3455,
                                  3456,
                                  3457,
                                  3458,
                                  3459,
                                  3460,
                                  3461,
                                  3462,
                                  3463,
                                  3464,
                                  3465,
                                  3466,
                                  3467,
                                  3468,
                                  3469,
                                  3470,
                                  3471,
                                  3472,
                                  3473,
                                  3474,
                                  3475,
                                  3476,
                                  3477,
                                  3478,
                                  3479,
                                  3480,
                                  3481,
                                  3482,
                                  3483,
                                  3484,
                                  3485,
                                  3486,
                                  3487,
                                  3488,
                                  3489,
                                  3490,
                                  3491,
                                  3492,
                                  3493,
                                  3494,
                                  3495,
                                  3496,
                                  3497,
                                  3498,
                                  3499,
                                  3500,
                                  3501,
                                  3502,
                                  3503,
                                  3504,
                                  4008,
                                  4283,
                                  4284,
                                  4286,
                                  4342,
                                  4343,
                                  4344,
                                  4345,
                                  4346,
                                  4347,
                                  4348,
                                  4349,
                                  4350,
                                  4351,
                                  4352,
                                  4353,
                                  4354,
                                  4355,
                                  4356,
                                  4357,
                                  4358,
                                  4359,
                                  4360,
                                  4361,
                                  4362,
                                  4364,
                                  4365,
                                  4366,
                                  4367,
                                  4368,
                                  4369,
                                  4370,
                                  4371,
                                  4372,
                                  4373,
                                  4374,
                                  4375,
                                  4376,
                                  4378,
                                  4385,
                                  4387,
                                  4388,
                                  4390,
                                  4392,
                                  4394,
                                  4396,
                                  4398,
                                  4417,
                                  4419,
                                  4421,
                                  4423,
                                  4425,
                                  4427,
                                  4429,
                                  4430,
                                  4431,
                                  4433,
                                  4434,
                                  4437,
                                  4440,
                                  4442,
                                  4444,
                                  4446,
                                  4449,
                                  4451,
                                  4455,
                                  4457,
                                  4458,
                                  4460,
                                  4462,
                                  4464,
                                  4467,
                                  4468,
                                  4470,
                                  4472,
                                  4474,
                                  4475,
                                  4477)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
  LEFT JOIN `student_tuition_payed`
    ON `student_tuition_detail`.`id` = `student_tuition_payed`.`student_tuition_id`
WHERE
  expected_at < '2015-09-01'
  AND IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount
  AND `level_id` IS NOT NULL AND `student_id` IN
                                 (2573,
                                  2574,
                                  2575,
                                  2576,
                                  2577,
                                  2578,
                                  2579,
                                  2580,
                                  2581,
                                  2582,
                                  2583,
                                  2584,
                                  2586,
                                  2587,
                                  2588,
                                  2592,
                                  2593,
                                  2594,
                                  2595,
                                  2596,
                                  2597,
                                  2598,
                                  2599,
                                  2601,
                                  2602,
                                  2603,
                                  2604,
                                  2605,
                                  2606,
                                  2607,
                                  2608,
                                  2609,
                                  2610,
                                  2612,
                                  2613,
                                  2614,
                                  2615,
                                  2616,
                                  2617,
                                  2618,
                                  2619,
                                  2620,
                                  2621,
                                  2622,
                                  2623,
                                  2624,
                                  2625,
                                  2626,
                                  2627,
                                  2628,
                                  2629,
                                  2630,
                                  2631,
                                  2632,
                                  2633,
                                  2634,
                                  2635,
                                  2636,
                                  2637,
                                  2638,
                                  2639,
                                  2640,
                                  2641,
                                  2642,
                                  2643,
                                  2644,
                                  2645,
                                  2646,
                                  2647,
                                  2648,
                                  2649,
                                  2650,
                                  2651,
                                  2652,
                                  2653,
                                  2654,
                                  2655,
                                  2656,
                                  2657,
                                  2658,
                                  2659,
                                  2660,
                                  2661,
                                  2662,
                                  2663,
                                  2664,
                                  2665,
                                  2666,
                                  2667,
                                  2669,
                                  2670,
                                  2671,
                                  2672,
                                  2673,
                                  2674,
                                  2675,
                                  2676,
                                  2677,
                                  2678,
                                  2680,
                                  2681,
                                  2682,
                                  2683,
                                  2684,
                                  2685,
                                  2686,
                                  2687,
                                  2688,
                                  2689,
                                  2690,
                                  2691,
                                  2692,
                                  2693,
                                  2694,
                                  2696,
                                  2697,
                                  2698,
                                  2699,
                                  2700,
                                  2701,
                                  2702,
                                  2703,
                                  2704,
                                  2705,
                                  2706,
                                  2707,
                                  2708,
                                  2709,
                                  2710,
                                  2711,
                                  2714,
                                  2715,
                                  2716,
                                  2717,
                                  2719,
                                  2720,
                                  2721,
                                  2722,
                                  2723,
                                  2724,
                                  2725,
                                  2726,
                                  2728,
                                  2729,
                                  2730,
                                  2731,
                                  2732,
                                  2733,
                                  2734,
                                  2735,
                                  2737,
                                  2738,
                                  2739,
                                  2741,
                                  2743,
                                  2744,
                                  2745,
                                  2746,
                                  2747,
                                  2748,
                                  2749,
                                  2750,
                                  2751,
                                  2752,
                                  2753,
                                  2754,
                                  2755,
                                  2756,
                                  2757,
                                  2758,
                                  2759,
                                  2760,
                                  2761,
                                  2762,
                                  2763,
                                  2764,
                                  2765,
                                  2766,
                                  2767,
                                  2768,
                                  2769,
                                  2770,
                                  2771,
                                  2772,
                                  2774,
                                  2775,
                                  2776,
                                  2777,
                                  2778,
                                  2779,
                                  2780,
                                  2781,
                                  2782,
                                  2783,
                                  2784,
                                  2785,
                                  2786,
                                  2787,
                                  2788,
                                  2789,
                                  2790,
                                  2791,
                                  2792,
                                  2793,
                                  2794,
                                  2795,
                                  2796,
                                  2797,
                                  2798,
                                  2799,
                                  2800,
                                  2801,
                                  2802,
                                  2803,
                                  2804,
                                  2805,
                                  2806,
                                  2807,
                                  2808,
                                  2809,
                                  2810,
                                  2811,
                                  2812,
                                  2813,
                                  2814,
                                  2815,
                                  2816,
                                  2817,
                                  2818,
                                  2820,
                                  2821,
                                  2822,
                                  2823,
                                  2824,
                                  2825,
                                  2826,
                                  2827,
                                  2828,
                                  2829,
                                  2830,
                                  2831,
                                  2832,
                                  2833,
                                  2834,
                                  2835,
                                  2836,
                                  2837,
                                  2838,
                                  2839,
                                  2840,
                                  2841,
                                  2842,
                                  2843,
                                  2844,
                                  2845,
                                  2846,
                                  2847,
                                  2848,
                                  2849,
                                  2850,
                                  2851,
                                  2852,
                                  2853,
                                  2854,
                                  2855,
                                  2856,
                                  2857,
                                  2858,
                                  2859,
                                  2860,
                                  2862,
                                  2863,
                                  2864,
                                  2865,
                                  2866,
                                  2867,
                                  2868,
                                  2869,
                                  2870,
                                  2871,
                                  2872,
                                  2873,
                                  2874,
                                  2875,
                                  2876,
                                  2877,
                                  2879,
                                  2880,
                                  2881,
                                  2882,
                                  2883,
                                  2884,
                                  2885,
                                  2886,
                                  2887,
                                  2888,
                                  2889,
                                  2890,
                                  2891,
                                  2892,
                                  2893,
                                  2894,
                                  2895,
                                  2896,
                                  2897,
                                  2898,
                                  2899,
                                  2900,
                                  2901,
                                  2902,
                                  2903,
                                  2904,
                                  2905,
                                  2906,
                                  2907,
                                  2908,
                                  2909,
                                  2910,
                                  2911,
                                  2912,
                                  2913,
                                  2914,
                                  2915,
                                  2916,
                                  2917,
                                  2918,
                                  2920,
                                  2921,
                                  2922,
                                  2923,
                                  2924,
                                  2925,
                                  2926,
                                  2927,
                                  2928,
                                  2929,
                                  2930,
                                  2931,
                                  2932,
                                  2933,
                                  2934,
                                  2935,
                                  2936,
                                  2937,
                                  2939,
                                  2940,
                                  2941,
                                  2942,
                                  2943,
                                  2944,
                                  2945,
                                  2946,
                                  2947,
                                  2950,
                                  2951,
                                  2952,
                                  2953,
                                  2954,
                                  2955,
                                  2956,
                                  2957,
                                  2958,
                                  2959,
                                  2960,
                                  2961,
                                  2962,
                                  2963,
                                  2964,
                                  2965,
                                  2966,
                                  2967,
                                  2968,
                                  2969,
                                  2970,
                                  2973,
                                  2980,
                                  2981,
                                  2985,
                                  2987,
                                  2988,
                                  2990,
                                  2991,
                                  2992,
                                  2993,
                                  2994,
                                  2995,
                                  2996,
                                  2997,
                                  2998,
                                  2999,
                                  3000,
                                  3001,
                                  3002,
                                  3003,
                                  3004,
                                  3005,
                                  3007,
                                  3008,
                                  3009,
                                  3011,
                                  3012,
                                  3013,
                                  3014,
                                  3015,
                                  3016,
                                  3017,
                                  3018,
                                  3019,
                                  3020,
                                  3021,
                                  3022,
                                  3023,
                                  3024,
                                  3025,
                                  3026,
                                  3027,
                                  3028,
                                  3029,
                                  3030,
                                  3031,
                                  3033,
                                  3034,
                                  3035,
                                  3036,
                                  3037,
                                  3038,
                                  3039,
                                  3040,
                                  3041,
                                  3043,
                                  3044,
                                  3045,
                                  3046,
                                  3047,
                                  3048,
                                  3049,
                                  3050,
                                  3051,
                                  3052,
                                  3053,
                                  3055,
                                  3056,
                                  3057,
                                  3058,
                                  3059,
                                  3060,
                                  3061,
                                  3062,
                                  3063,
                                  3064,
                                  3065,
                                  3066,
                                  3067,
                                  3068,
                                  3069,
                                  3070,
                                  3071,
                                  3073,
                                  3075,
                                  3076,
                                  3077,
                                  3078,
                                  3079,
                                  3080,
                                  3081,
                                  3082,
                                  3083,
                                  3086,
                                  3087,
                                  3089,
                                  3090,
                                  3091,
                                  3092,
                                  3096,
                                  3097,
                                  3098,
                                  3099,
                                  3100,
                                  3101,
                                  3102,
                                  3104,
                                  3105,
                                  3106,
                                  3107,
                                  3109,
                                  3110,
                                  3111,
                                  3112,
                                  3113,
                                  3114,
                                  3115,
                                  3116,
                                  3118,
                                  3119,
                                  3120,
                                  3121,
                                  3122,
                                  3123,
                                  3124,
                                  3125,
                                  3126,
                                  3127,
                                  3129,
                                  3130,
                                  3131,
                                  3132,
                                  3133,
                                  3134,
                                  3135,
                                  3136,
                                  3137,
                                  3139,
                                  3140,
                                  3141,
                                  3142,
                                  3143,
                                  3144,
                                  3146,
                                  3147,
                                  3148,
                                  3149,
                                  3150,
                                  3151,
                                  3154,
                                  3155,
                                  3156,
                                  3157,
                                  3158,
                                  3159,
                                  3160,
                                  3161,
                                  3162,
                                  3163,
                                  3164,
                                  3165,
                                  3166,
                                  3167,
                                  3168,
                                  3169,
                                  3170,
                                  3171,
                                  3172,
                                  3173,
                                  3174,
                                  3176,
                                  3177,
                                  3178,
                                  3179,
                                  3180,
                                  3181,
                                  3182,
                                  3183,
                                  3184,
                                  3186,
                                  3187,
                                  3189,
                                  3190,
                                  3191,
                                  3192,
                                  3193,
                                  3194,
                                  3195,
                                  3196,
                                  3197,
                                  3198,
                                  3199,
                                  3200,
                                  3201,
                                  3202,
                                  3203,
                                  3204,
                                  3205,
                                  3206,
                                  3207,
                                  3208,
                                  3209,
                                  3210,
                                  3211,
                                  3212,
                                  3213,
                                  3214,
                                  3215,
                                  3216,
                                  3217,
                                  3218,
                                  3219,
                                  3220,
                                  3221,
                                  3222,
                                  3223,
                                  3224,
                                  3225,
                                  3226,
                                  3227,
                                  3228,
                                  3229,
                                  3230,
                                  3231,
                                  3232,
                                  3233,
                                  3234,
                                  3235,
                                  3236,
                                  3237,
                                  3238,
                                  3239,
                                  3240,
                                  3241,
                                  3242,
                                  3243,
                                  3244,
                                  3245,
                                  3246,
                                  3247,
                                  3248,
                                  3249,
                                  3250,
                                  3251,
                                  3252,
                                  3253,
                                  3254,
                                  3255,
                                  3256,
                                  3257,
                                  3258,
                                  3259,
                                  3260,
                                  3262,
                                  3264,
                                  3265,
                                  3267,
                                  3269,
                                  3270,
                                  3271,
                                  3272,
                                  3273,
                                  3274,
                                  3275,
                                  3276,
                                  3278,
                                  3279,
                                  3280,
                                  3281,
                                  3285,
                                  3286,
                                  3287,
                                  3289,
                                  3290,
                                  3291,
                                  3292,
                                  3293,
                                  3294,
                                  3295,
                                  3296,
                                  3297,
                                  3298,
                                  3299,
                                  3300,
                                  3301,
                                  3302,
                                  3303,
                                  3304,
                                  3305,
                                  3306,
                                  3307,
                                  3308,
                                  3309,
                                  3310,
                                  3311,
                                  3312,
                                  3314,
                                  3315,
                                  3316,
                                  3317,
                                  3318,
                                  3319,
                                  3321,
                                  3322,
                                  3324,
                                  3325,
                                  3326,
                                  3327,
                                  3328,
                                  3329,
                                  3330,
                                  3331,
                                  3332,
                                  3333,
                                  3334,
                                  3335,
                                  3336,
                                  3337,
                                  3338,
                                  3339,
                                  3341,
                                  3342,
                                  3343,
                                  3344,
                                  3345,
                                  3346,
                                  3347,
                                  3348,
                                  3349,
                                  3350,
                                  3351,
                                  3352,
                                  3353,
                                  3354,
                                  3355,
                                  3356,
                                  3357,
                                  3358,
                                  3359,
                                  3360,
                                  3361,
                                  3362,
                                  3363,
                                  3364,
                                  3365,
                                  3366,
                                  3367,
                                  3368,
                                  3369,
                                  3370,
                                  3371,
                                  3372,
                                  3373,
                                  3374,
                                  3375,
                                  3376,
                                  3377,
                                  3378,
                                  3379,
                                  3380,
                                  3381,
                                  3382,
                                  3383,
                                  3384,
                                  3385,
                                  3386,
                                  3387,
                                  3388,
                                  3389,
                                  3390,
                                  3391,
                                  3392,
                                  3393,
                                  3394,
                                  3395,
                                  3396,
                                  3397,
                                  3398,
                                  3399,
                                  3400,
                                  3401,
                                  3402,
                                  3403,
                                  3404,
                                  3405,
                                  3406,
                                  3407,
                                  3408,
                                  3409,
                                  3410,
                                  3411,
                                  3412,
                                  3413,
                                  3414,
                                  3415,
                                  3416,
                                  3417,
                                  3418,
                                  3419,
                                  3420,
                                  3421,
                                  3422,
                                  3423,
                                  3424,
                                  3425,
                                  3426,
                                  3427,
                                  3428,
                                  3429,
                                  3430,
                                  3431,
                                  3432,
                                  3433,
                                  3434,
                                  3435,
                                  3436,
                                  3437,
                                  3438,
                                  3439,
                                  3440,
                                  3441,
                                  3442,
                                  3443,
                                  3444,
                                  3445,
                                  3446,
                                  3447,
                                  3448,
                                  3449,
                                  3450,
                                  3451,
                                  3452,
                                  3453,
                                  3454,
                                  3455,
                                  3456,
                                  3457,
                                  3458,
                                  3459,
                                  3460,
                                  3461,
                                  3462,
                                  3463,
                                  3464,
                                  3465,
                                  3466,
                                  3467,
                                  3468,
                                  3469,
                                  3470,
                                  3471,
                                  3472,
                                  3473,
                                  3474,
                                  3475,
                                  3476,
                                  3477,
                                  3478,
                                  3479,
                                  3480,
                                  3481,
                                  3482,
                                  3483,
                                  3484,
                                  3485,
                                  3486,
                                  3487,
                                  3488,
                                  3489,
                                  3490,
                                  3491,
                                  3492,
                                  3493,
                                  3494,
                                  3495,
                                  3496,
                                  3497,
                                  3498,
                                  3499,
                                  3500,
                                  3501,
                                  3502,
                                  3503,
                                  3504,
                                  4008,
                                  4283,
                                  4284,
                                  4286,
                                  4342,
                                  4343,
                                  4344,
                                  4345,
                                  4346,
                                  4347,
                                  4348,
                                  4349,
                                  4350,
                                  4351,
                                  4352,
                                  4353,
                                  4354,
                                  4355,
                                  4356,
                                  4357,
                                  4358,
                                  4359,
                                  4360,
                                  4361,
                                  4362,
                                  4364,
                                  4365,
                                  4366,
                                  4367,
                                  4368,
                                  4369,
                                  4370,
                                  4371,
                                  4372,
                                  4373,
                                  4374,
                                  4375,
                                  4376,
                                  4378,
                                  4385,
                                  4387,
                                  4388,
                                  4390,
                                  4392,
                                  4394,
                                  4396,
                                  4398,
                                  4417,
                                  4419,
                                  4421,
                                  4423,
                                  4425,
                                  4427,
                                  4429,
                                  4430,
                                  4431,
                                  4433,
                                  4434,
                                  4437,
                                  4440,
                                  4442,
                                  4444,
                                  4446,
                                  4449,
                                  4451,
                                  4455,
                                  4457,
                                  4458,
                                  4460,
                                  4462,
                                  4464,
                                  4467,
                                  4468,
                                  4470,
                                  4472,
                                  4474,
                                  4475,
                                  4477)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
  LEFT JOIN `student_tuition_payed`
    ON `student_tuition_detail`.`id` = `student_tuition_payed`.`student_tuition_id`
WHERE
  expected_at <= '2015-08-31'
  AND IFNULL(student_tuition_payed.payed, 0) < student_tuition_detail.amount
  AND `level_id` IS NOT NULL AND `student_id` IN
                                 (2573,
                                  2574,
                                  2575,
                                  2576,
                                  2577,
                                  2578,
                                  2579,
                                  2580,
                                  2581,
                                  2582,
                                  2583,
                                  2584,
                                  2586,
                                  2587,
                                  2588,
                                  2592,
                                  2593,
                                  2594,
                                  2595,
                                  2596,
                                  2597,
                                  2598,
                                  2599,
                                  2601,
                                  2602,
                                  2603,
                                  2604,
                                  2605,
                                  2606,
                                  2607,
                                  2608,
                                  2609,
                                  2610,
                                  2612,
                                  2613,
                                  2614,
                                  2615,
                                  2616,
                                  2617,
                                  2618,
                                  2619,
                                  2620,
                                  2621,
                                  2622,
                                  2623,
                                  2624,
                                  2625,
                                  2626,
                                  2627,
                                  2628,
                                  2629,
                                  2630,
                                  2631,
                                  2632,
                                  2633,
                                  2634,
                                  2635,
                                  2636,
                                  2637,
                                  2638,
                                  2639,
                                  2640,
                                  2641,
                                  2642,
                                  2643,
                                  2644,
                                  2645,
                                  2646,
                                  2647,
                                  2648,
                                  2649,
                                  2650,
                                  2651,
                                  2652,
                                  2653,
                                  2654,
                                  2655,
                                  2656,
                                  2657,
                                  2658,
                                  2659,
                                  2660,
                                  2661,
                                  2662,
                                  2663,
                                  2664,
                                  2665,
                                  2666,
                                  2667,
                                  2669,
                                  2670,
                                  2671,
                                  2672,
                                  2673,
                                  2674,
                                  2675,
                                  2676,
                                  2677,
                                  2678,
                                  2680,
                                  2681,
                                  2682,
                                  2683,
                                  2684,
                                  2685,
                                  2686,
                                  2687,
                                  2688,
                                  2689,
                                  2690,
                                  2691,
                                  2692,
                                  2693,
                                  2694,
                                  2696,
                                  2697,
                                  2698,
                                  2699,
                                  2700,
                                  2701,
                                  2702,
                                  2703,
                                  2704,
                                  2705,
                                  2706,
                                  2707,
                                  2708,
                                  2709,
                                  2710,
                                  2711,
                                  2714,
                                  2715,
                                  2716,
                                  2717,
                                  2719,
                                  2720,
                                  2721,
                                  2722,
                                  2723,
                                  2724,
                                  2725,
                                  2726,
                                  2728,
                                  2729,
                                  2730,
                                  2731,
                                  2732,
                                  2733,
                                  2734,
                                  2735,
                                  2737,
                                  2738,
                                  2739,
                                  2741,
                                  2743,
                                  2744,
                                  2745,
                                  2746,
                                  2747,
                                  2748,
                                  2749,
                                  2750,
                                  2751,
                                  2752,
                                  2753,
                                  2754,
                                  2755,
                                  2756,
                                  2757,
                                  2758,
                                  2759,
                                  2760,
                                  2761,
                                  2762,
                                  2763,
                                  2764,
                                  2765,
                                  2766,
                                  2767,
                                  2768,
                                  2769,
                                  2770,
                                  2771,
                                  2772,
                                  2774,
                                  2775,
                                  2776,
                                  2777,
                                  2778,
                                  2779,
                                  2780,
                                  2781,
                                  2782,
                                  2783,
                                  2784,
                                  2785,
                                  2786,
                                  2787,
                                  2788,
                                  2789,
                                  2790,
                                  2791,
                                  2792,
                                  2793,
                                  2794,
                                  2795,
                                  2796,
                                  2797,
                                  2798,
                                  2799,
                                  2800,
                                  2801,
                                  2802,
                                  2803,
                                  2804,
                                  2805,
                                  2806,
                                  2807,
                                  2808,
                                  2809,
                                  2810,
                                  2811,
                                  2812,
                                  2813,
                                  2814,
                                  2815,
                                  2816,
                                  2817,
                                  2818,
                                  2820,
                                  2821,
                                  2822,
                                  2823,
                                  2824,
                                  2825,
                                  2826,
                                  2827,
                                  2828,
                                  2829,
                                  2830,
                                  2831,
                                  2832,
                                  2833,
                                  2834,
                                  2835,
                                  2836,
                                  2837,
                                  2838,
                                  2839,
                                  2840,
                                  2841,
                                  2842,
                                  2843,
                                  2844,
                                  2845,
                                  2846,
                                  2847,
                                  2848,
                                  2849,
                                  2850,
                                  2851,
                                  2852,
                                  2853,
                                  2854,
                                  2855,
                                  2856,
                                  2857,
                                  2858,
                                  2859,
                                  2860,
                                  2862,
                                  2863,
                                  2864,
                                  2865,
                                  2866,
                                  2867,
                                  2868,
                                  2869,
                                  2870,
                                  2871,
                                  2872,
                                  2873,
                                  2874,
                                  2875,
                                  2876,
                                  2877,
                                  2879,
                                  2880,
                                  2881,
                                  2882,
                                  2883,
                                  2884,
                                  2885,
                                  2886,
                                  2887,
                                  2888,
                                  2889,
                                  2890,
                                  2891,
                                  2892,
                                  2893,
                                  2894,
                                  2895,
                                  2896,
                                  2897,
                                  2898,
                                  2899,
                                  2900,
                                  2901,
                                  2902,
                                  2903,
                                  2904,
                                  2905,
                                  2906,
                                  2907,
                                  2908,
                                  2909,
                                  2910,
                                  2911,
                                  2912,
                                  2913,
                                  2914,
                                  2915,
                                  2916,
                                  2917,
                                  2918,
                                  2920,
                                  2921,
                                  2922,
                                  2923,
                                  2924,
                                  2925,
                                  2926,
                                  2927,
                                  2928,
                                  2929,
                                  2930,
                                  2931,
                                  2932,
                                  2933,
                                  2934,
                                  2935,
                                  2936,
                                  2937,
                                  2939,
                                  2940,
                                  2941,
                                  2942,
                                  2943,
                                  2944,
                                  2945,
                                  2946,
                                  2947,
                                  2950,
                                  2951,
                                  2952,
                                  2953,
                                  2954,
                                  2955,
                                  2956,
                                  2957,
                                  2958,
                                  2959,
                                  2960,
                                  2961,
                                  2962,
                                  2963,
                                  2964,
                                  2965,
                                  2966,
                                  2967,
                                  2968,
                                  2969,
                                  2970,
                                  2973,
                                  2980,
                                  2981,
                                  2985,
                                  2987,
                                  2988,
                                  2990,
                                  2991,
                                  2992,
                                  2993,
                                  2994,
                                  2995,
                                  2996,
                                  2997,
                                  2998,
                                  2999,
                                  3000,
                                  3001,
                                  3002,
                                  3003,
                                  3004,
                                  3005,
                                  3007,
                                  3008,
                                  3009,
                                  3011,
                                  3012,
                                  3013,
                                  3014,
                                  3015,
                                  3016,
                                  3017,
                                  3018,
                                  3019,
                                  3020,
                                  3021,
                                  3022,
                                  3023,
                                  3024,
                                  3025,
                                  3026,
                                  3027,
                                  3028,
                                  3029,
                                  3030,
                                  3031,
                                  3033,
                                  3034,
                                  3035,
                                  3036,
                                  3037,
                                  3038,
                                  3039,
                                  3040,
                                  3041,
                                  3043,
                                  3044,
                                  3045,
                                  3046,
                                  3047,
                                  3048,
                                  3049,
                                  3050,
                                  3051,
                                  3052,
                                  3053,
                                  3055,
                                  3056,
                                  3057,
                                  3058,
                                  3059,
                                  3060,
                                  3061,
                                  3062,
                                  3063,
                                  3064,
                                  3065,
                                  3066,
                                  3067,
                                  3068,
                                  3069,
                                  3070,
                                  3071,
                                  3073,
                                  3075,
                                  3076,
                                  3077,
                                  3078,
                                  3079,
                                  3080,
                                  3081,
                                  3082,
                                  3083,
                                  3086,
                                  3087,
                                  3089,
                                  3090,
                                  3091,
                                  3092,
                                  3096,
                                  3097,
                                  3098,
                                  3099,
                                  3100,
                                  3101,
                                  3102,
                                  3104,
                                  3105,
                                  3106,
                                  3107,
                                  3109,
                                  3110,
                                  3111,
                                  3112,
                                  3113,
                                  3114,
                                  3115,
                                  3116,
                                  3118,
                                  3119,
                                  3120,
                                  3121,
                                  3122,
                                  3123,
                                  3124,
                                  3125,
                                  3126,
                                  3127,
                                  3129,
                                  3130,
                                  3131,
                                  3132,
                                  3133,
                                  3134,
                                  3135,
                                  3136,
                                  3137,
                                  3139,
                                  3140,
                                  3141,
                                  3142,
                                  3143,
                                  3144,
                                  3146,
                                  3147,
                                  3148,
                                  3149,
                                  3150,
                                  3151,
                                  3154,
                                  3155,
                                  3156,
                                  3157,
                                  3158,
                                  3159,
                                  3160,
                                  3161,
                                  3162,
                                  3163,
                                  3164,
                                  3165,
                                  3166,
                                  3167,
                                  3168,
                                  3169,
                                  3170,
                                  3171,
                                  3172,
                                  3173,
                                  3174,
                                  3176,
                                  3177,
                                  3178,
                                  3179,
                                  3180,
                                  3181,
                                  3182,
                                  3183,
                                  3184,
                                  3186,
                                  3187,
                                  3189,
                                  3190,
                                  3191,
                                  3192,
                                  3193,
                                  3194,
                                  3195,
                                  3196,
                                  3197,
                                  3198,
                                  3199,
                                  3200,
                                  3201,
                                  3202,
                                  3203,
                                  3204,
                                  3205,
                                  3206,
                                  3207,
                                  3208,
                                  3209,
                                  3210,
                                  3211,
                                  3212,
                                  3213,
                                  3214,
                                  3215,
                                  3216,
                                  3217,
                                  3218,
                                  3219,
                                  3220,
                                  3221,
                                  3222,
                                  3223,
                                  3224,
                                  3225,
                                  3226,
                                  3227,
                                  3228,
                                  3229,
                                  3230,
                                  3231,
                                  3232,
                                  3233,
                                  3234,
                                  3235,
                                  3236,
                                  3237,
                                  3238,
                                  3239,
                                  3240,
                                  3241,
                                  3242,
                                  3243,
                                  3244,
                                  3245,
                                  3246,
                                  3247,
                                  3248,
                                  3249,
                                  3250,
                                  3251,
                                  3252,
                                  3253,
                                  3254,
                                  3255,
                                  3256,
                                  3257,
                                  3258,
                                  3259,
                                  3260,
                                  3262,
                                  3264,
                                  3265,
                                  3267,
                                  3269,
                                  3270,
                                  3271,
                                  3272,
                                  3273,
                                  3274,
                                  3275,
                                  3276,
                                  3278,
                                  3279,
                                  3280,
                                  3281,
                                  3285,
                                  3286,
                                  3287,
                                  3289,
                                  3290,
                                  3291,
                                  3292,
                                  3293,
                                  3294,
                                  3295,
                                  3296,
                                  3297,
                                  3298,
                                  3299,
                                  3300,
                                  3301,
                                  3302,
                                  3303,
                                  3304,
                                  3305,
                                  3306,
                                  3307,
                                  3308,
                                  3309,
                                  3310,
                                  3311,
                                  3312,
                                  3314,
                                  3315,
                                  3316,
                                  3317,
                                  3318,
                                  3319,
                                  3321,
                                  3322,
                                  3324,
                                  3325,
                                  3326,
                                  3327,
                                  3328,
                                  3329,
                                  3330,
                                  3331,
                                  3332,
                                  3333,
                                  3334,
                                  3335,
                                  3336,
                                  3337,
                                  3338,
                                  3339,
                                  3341,
                                  3342,
                                  3343,
                                  3344,
                                  3345,
                                  3346,
                                  3347,
                                  3348,
                                  3349,
                                  3350,
                                  3351,
                                  3352,
                                  3353,
                                  3354,
                                  3355,
                                  3356,
                                  3357,
                                  3358,
                                  3359,
                                  3360,
                                  3361,
                                  3362,
                                  3363,
                                  3364,
                                  3365,
                                  3366,
                                  3367,
                                  3368,
                                  3369,
                                  3370,
                                  3371,
                                  3372,
                                  3373,
                                  3374,
                                  3375,
                                  3376,
                                  3377,
                                  3378,
                                  3379,
                                  3380,
                                  3381,
                                  3382,
                                  3383,
                                  3384,
                                  3385,
                                  3386,
                                  3387,
                                  3388,
                                  3389,
                                  3390,
                                  3391,
                                  3392,
                                  3393,
                                  3394,
                                  3395,
                                  3396,
                                  3397,
                                  3398,
                                  3399,
                                  3400,
                                  3401,
                                  3402,
                                  3403,
                                  3404,
                                  3405,
                                  3406,
                                  3407,
                                  3408,
                                  3409,
                                  3410,
                                  3411,
                                  3412,
                                  3413,
                                  3414,
                                  3415,
                                  3416,
                                  3417,
                                  3418,
                                  3419,
                                  3420,
                                  3421,
                                  3422,
                                  3423,
                                  3424,
                                  3425,
                                  3426,
                                  3427,
                                  3428,
                                  3429,
                                  3430,
                                  3431,
                                  3432,
                                  3433,
                                  3434,
                                  3435,
                                  3436,
                                  3437,
                                  3438,
                                  3439,
                                  3440,
                                  3441,
                                  3442,
                                  3443,
                                  3444,
                                  3445,
                                  3446,
                                  3447,
                                  3448,
                                  3449,
                                  3450,
                                  3451,
                                  3452,
                                  3453,
                                  3454,
                                  3455,
                                  3456,
                                  3457,
                                  3458,
                                  3459,
                                  3460,
                                  3461,
                                  3462,
                                  3463,
                                  3464,
                                  3465,
                                  3466,
                                  3467,
                                  3468,
                                  3469,
                                  3470,
                                  3471,
                                  3472,
                                  3473,
                                  3474,
                                  3475,
                                  3476,
                                  3477,
                                  3478,
                                  3479,
                                  3480,
                                  3481,
                                  3482,
                                  3483,
                                  3484,
                                  3485,
                                  3486,
                                  3487,
                                  3488,
                                  3489,
                                  3490,
                                  3491,
                                  3492,
                                  3493,
                                  3494,
                                  3495,
                                  3496,
                                  3497,
                                  3498,
                                  3499,
                                  3500,
                                  3501,
                                  3502,
                                  3503,
                                  3504,
                                  4008,
                                  4283,
                                  4284,
                                  4286,
                                  4342,
                                  4343,
                                  4344,
                                  4345,
                                  4346,
                                  4347,
                                  4348,
                                  4349,
                                  4350,
                                  4351,
                                  4352,
                                  4353,
                                  4354,
                                  4355,
                                  4356,
                                  4357,
                                  4358,
                                  4359,
                                  4360,
                                  4361,
                                  4362,
                                  4364,
                                  4365,
                                  4366,
                                  4367,
                                  4368,
                                  4369,
                                  4370,
                                  4371,
                                  4372,
                                  4373,
                                  4374,
                                  4375,
                                  4376,
                                  4378,
                                  4385,
                                  4387,
                                  4388,
                                  4390,
                                  4392,
                                  4394,
                                  4396,
                                  4398,
                                  4417,
                                  4419,
                                  4421,
                                  4423,
                                  4425,
                                  4427,
                                  4429,
                                  4430,
                                  4431,
                                  4433,
                                  4434,
                                  4437,
                                  4440,
                                  4442,
                                  4444,
                                  4446,
                                  4449,
                                  4451,
                                  4455,
                                  4457,
                                  4458,
                                  4460,
                                  4462,
                                  4464,
                                  4467,
                                  4468,
                                  4470,
                                  4472,
                                  4474,
                                  4475,
                                  4477)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_payment_options
WHERE address LIKE '%"zip":"37296"'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_payment_options
WHERE address LIKE '%"zip":"37296"%'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_payment_options
WHERE tax_id = "SAAS741122CW8"
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE created_at >= '20151102'
;-- -. . -..- - / . -. - .-. -.--
DELETE 
FROM student_grades
WHERE created_at >= '20151102'
;-- -. . -..- - / . -. - .-. -.--
UPDATE registrations
SET degree_id = 291
WHERE status = 'Pendiente' AND degree_id = 176
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM student_tuitions
WHERE tuition_id=38 AND created_at = '2016-02-01 12:50:40' AND type = 'normal' AND updated_at IS 
                                                                                   NOT NULL
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO schoolyears (structure_id, enrollment_formats_id, status, ends_at, starts_at, inscription_at, created_at, updated_at, deleted_at, description, config) VALUES (198, 1, 'Pre-activo', '2016-06-15', '2015-08-01', null, '2016-01-06 16:55:12', '2016-01-06 16:55:12', null, null, null)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
WHERE schoolyear_id IS (198,288) AND student_id IN (2222,4543,4593)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
WHERE schoolyear_id IN (198,288) AND student_id IN (2222,4543,4593)
;-- -. . -..- - / . -. - .-. -.--
UPDATE teacher_criteria
SET criteria_id = 2
WHERE criteria_id = 5 AND group_id IN (
  SELECT full_heritage.structure_id
  FROM full_heritage
    JOIN school_groups ON full_heritage.structure_id = school_groups.structure_id
  WHERE find_in_set(35, ancestor))
;-- -. . -..- - / . -. - .-. -.--
UPDATE criteria SET scale_id = 3, concepts='[{"editable":false,"name":"Calificación","type":"Único","calculated":false,"grouping":"","percentage":100,"report":true,"breakdown":false,"abbreviation":"CAL"}]' WHERE structure_id IN (35,178,288)
;-- -. . -..- - / . -. - .-. -.--
UPDATE criteria SET scale_id = 3, concepts='[{"editable":false,"name":"Calificación",
"type":"Único","calculated":false,"grouping":"","percentage":100,"report":true,"breakdown":false,"abbreviation":"CAL"}]' WHERE structure_id IN (35,173,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND FIND_IN_SET(113, sons)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(113, sons) OR school_structures.id = 113)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(113, sons) OR school_structures.id = 113)
  OR master = 236
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(113, sons) OR school_structures.id = 113)
  OR school_structures.id = 236
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(113, sons) OR school_structures.id = 113)
        OR (FIND_IN_SET(78, sons) OR school_structures.id = 78)
  OR school_structures.id = 236
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(113, sons) OR school_structures.id = 113)
        OR (FIND_IN_SET(236, sons) OR school_structures.id = 236)
        OR (FIND_IN_SET(78, sons) OR school_structures.id = 78)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(34, ancestor) OR school_structures.id = 34)
        OR (FIND_IN_SET(198, ancestor) OR school_structures.id = 198)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(103, sons) OR school_structures.id = 103)
        OR (FIND_IN_SET(236, sons) OR school_structures.id = 236)
        OR (FIND_IN_SET(201, ancestor) OR school_structures.id = 201)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(103, sons) OR school_structures.id = 103)
        OR (FIND_IN_SET(236, sons) OR school_structures.id = 236)
        OR (FIND_IN_SET(247, ancestor) OR school_structures.id = 247)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(72, sons) OR school_structures.id = 78)
        OR (FIND_IN_SET(239, sons) OR school_structures.id = 239)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(102, sons) OR school_structures.id = 102)
        OR (FIND_IN_SET(231, sons) OR school_structures.id = 231)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(34, ancestor) OR school_structures.id = 34)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(103, sons) OR school_structures.id = 103)
        OR (FIND_IN_SET(236, sons) OR school_structures.id = 236)
        OR (FIND_IN_SET(247, ancestor) OR school_structures.name = 'Primero')
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(103, sons) OR school_structures.id = 103)
        OR (FIND_IN_SET(236, sons) OR school_structures.id = 236)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM group_student
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(46, sons) OR school_structures.id = 46)
        OR (FIND_IN_SET(205, sons) OR school_structures.id = 205)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM group_student
WHERE group_id NOT IN (47)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM group_student
WHERE group_id NOT IN (47, 52)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(49, sons) OR school_structures.id = 49)
        OR (FIND_IN_SET(208, sons) OR school_structures.id = 208)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM group_student
WHERE group_id NOT IN (47, 52,53)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(50, sons) OR school_structures.id = 50)
        OR (FIND_IN_SET(211, sons) OR school_structures.id = 211)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(51, sons) OR school_structures.id = 51)
        OR (FIND_IN_SET(216, sons) OR school_structures.id = 216)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT structure_id
FROM school_groups
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM school_groups
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(59, sons) OR school_structures.id = 59)
        OR (FIND_IN_SET(219, sons) OR school_structures.id = 219)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(60, sons) OR school_structures.id = 60)
        OR (FIND_IN_SET(222, sons) OR school_structures.id = 222)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(61, sons) OR school_structures.id = 61)
        OR (FIND_IN_SET(225, sons) OR school_structures.id = 225)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(62, sons) OR school_structures.id = 62)
        OR (FIND_IN_SET(228, sons) OR school_structures.id = 228)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68,69,70,71,72)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(63, sons) OR school_structures.id = 63)
        OR (FIND_IN_SET(231, sons) OR school_structures.id = 231)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68,69,70,71,72,73,74)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(64, sons) OR school_structures.id = 64)
        OR (FIND_IN_SET(236, sons) OR school_structures.id = 236)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68,69,70,71,72,73,74,75,76)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68,69,70,71,72,73,74,75,76,81,82)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68,69,70,71,72,73,74,75,76,81,82,83,84)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68,69,70,71,72,73,74,75,76,81,82,83,84,85,86)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id NOT IN (47, 52,53,54,55, 56,57,65,66,67,68,69,70,71,72,73,74,75,76,81,82,83)
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(79, sons) OR school_structures.id = 79)
        OR (FIND_IN_SET(242, sons) OR school_structures.id = 242)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id >86
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(80, sons) OR school_structures.id = 80)
        OR (FIND_IN_SET(291, sons) OR school_structures.id = 291)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(78, sons) OR school_structures.id = 78)
        OR (FIND_IN_SET(239, sons) OR school_structures.id = 239)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
AND (
        (FIND_IN_SET(88, sons) OR school_structures.id = 88)
        OR (FIND_IN_SET(205, sons) OR school_structures.id = 205)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT student_tuitions.*,
  SUM(IFNULL(student_payments.amount,0)) AS payed,
CONCAT('[', GROUP_CONCAT(payment_id), ']') AS payments,
CONCAT('[', GROUP_CONCAT(invoice_id), ']') AS invoices,
CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM student_tuitions
LEFT JOIN student_payments ON student_tuitions.id=student_payments.student_tuition_id
  WHERE student_id = 2619
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT student_tuitions.*,
  SUM(IFNULL(student_payments.amount,0)) AS payed,
CONCAT('[', GROUP_CONCAT(payment_id), ']') AS payments,
CONCAT('[', GROUP_CONCAT(invoice_id), ']') AS invoices,
CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM student_tuitions
LEFT JOIN student_payments ON student_tuitions.id=student_payments.student_tuition_id
  WHERE student_id = 2664
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (2664)
GROUP BY `student_tuitions`.`id`
HAVING `payed` < amount
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (2664)
GROUP BY `student_tuitions`.`id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (2664)
GROUP BY `student_tuitions`.`id`
HAVING `payed` < amount OR payed = 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (288)
GROUP BY `student_tuitions`.`id`
HAVING `payed` < amount OR payed = 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (288)
GROUP BY `student_tuitions`.`id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (3339)
GROUP BY `student_tuitions`.`id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (3339)
GROUP BY `student_tuitions`.`id`
HAVING payed < 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (3339)
GROUP BY `student_tuitions`.`id`
HAVING payed < student_tuitions.amount
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (3339)
GROUP BY `student_tuitions`.`id`
HAVING payed < amount
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(199, ancestor) OR school_structures.id = 199)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(88, sons) OR school_structures.id = 88)
        OR (FIND_IN_SET(205, sons) OR school_structures.id = 205)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 89
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(91, sons) OR school_structures.id = 91)
        OR (FIND_IN_SET(208, sons) OR school_structures.id = 208)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 94
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(92, sons) OR school_structures.id = 92)
        OR (FIND_IN_SET(211, sons) OR school_structures.id = 211)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 95
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(93, sons) OR school_structures.id = 93)
        OR (FIND_IN_SET(216, sons) OR school_structures.id = 216)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 96
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(98, sons) OR school_structures.id = 98)
        OR (FIND_IN_SET(219, sons) OR school_structures.id = 219)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 104
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(99, sons) OR school_structures.id = 99)
        OR (FIND_IN_SET(222, sons) OR school_structures.id = 222)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 105
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 106
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(101, sons) OR school_structures.id = 101)
        OR (FIND_IN_SET(228, sons) OR school_structures.id = 228)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 107
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(102, sons) OR school_structures.id = 102)
        OR (FIND_IN_SET(231, sons) OR school_structures.id = 231)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 108
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(103, sons) OR school_structures.id = 103)
        OR (FIND_IN_SET(236, sons) OR school_structures.id = 236)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(111, sons) OR school_structures.id = 111)
        OR (FIND_IN_SET(239, sons) OR school_structures.id = 239)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 109
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 114
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(112, sons) OR school_structures.id = 112)
        OR (FIND_IN_SET(242, sons) OR school_structures.id = 242)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(247, ancestor) OR school_structures.id = 247)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(113, sons) OR school_structures.id = 113)
        OR (FIND_IN_SET(291, sons) OR school_structures.id = 291)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(185, sons) OR school_structures.id = 185)
        OR (FIND_IN_SET(300, sons) OR school_structures.id = 300)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id
FROM group_student
WHERE group_id > 115
GROUP BY group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(179, sons) OR school_structures.id = 179)
        OR (FIND_IN_SET(294, sons) OR school_structures.id = 294)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
WHERE id IN (SELECT registration_id FROM student_registration WHERE schoolyear_id = 198)
;-- -. . -..- - / . -. - .-. -.--
SELECT id, degree_id, CASE degree_id
  WHERE 205 then 253
  WHERE 208 then 255
  WHERE 211 then 257
  WHERE 216 then 261
  WHERE 219 then 263
  WHERE 222 then 265
  WHERE 225 then 267
  WHERE 228 then 269
  WHERE 231 then 271
  WHERE 236 then 275
  WHERE 239 then 277
  WHERE 242 then 279
  WHERE 300 then 303
  WHERE 294 then 297
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  degree_id
  CASE registrations.degree_id
WHERE 205 THEN 253
WHERE 208 THEN 255
WHERE 211 THEN 257
WHERE 216 THEN 261
WHERE 219 THEN 263
WHERE 222 THEN 265
WHERE 225 THEN 267
WHERE 228 THEN 269
WHERE 231 THEN 271
WHERE 236 THEN 275
WHERE 239 THEN 277
WHERE 242 THEN 279
WHERE 300 THEN 303
WHERE 294 THEN 297
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino
FROM registrations
WHERE id IN (SELECT registration_id
             FROM student_registration
             WHERE schoolyear_id = 198)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(288, ancestor) OR school_structures.id = 288)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino
FROM registrations
WHERE id IN (SELECT registration_id
             FROM student_registration
             WHERE schoolyear_id IN (198,288))
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino,
student_id
FROM registrations
WHERE id IN (SELECT registration_id
             FROM student_registration
             WHERE schoolyear_id IN (198,288))
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino,
student_id
FROM registrations
WHERE id IN (SELECT registration_id
             FROM student_registration
             WHERE schoolyear_id IN (198,288))
ORDER BY student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(100, sons) OR school_structures.id = 100)
        OR (FIND_IN_SET(225, sons) OR school_structures.id = 225)
      )
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino,
  student_id
FROM registrations
WHERE id IN (SELECT registration_id
             FROM student_registration
             WHERE
               schoolyear_id = 288 OR (
                 schoolyear_id = 198
                 AND student_id IN (
                   SELECT student_id
                   FROM student_registration
                   WHERE site_id = 43)))
ORDER BY student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino,
  student_id,
  schoolyear_id
FROM student_registration
WHERE id IN (SELECT registration_id
             FROM student_registration
             WHERE
               schoolyear_id = 288 OR (
                 schoolyear_id = 198
                 AND student_id IN (
                   SELECT student_id
                   FROM student_registration
                   WHERE site_id = 43)))
ORDER BY student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registration_id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino,
  student_id,
  schoolyear_id
FROM student_registration
WHERE id IN (SELECT registration_id
             FROM student_registration
             WHERE
               schoolyear_id = 288 OR (
                 schoolyear_id = 198
                 AND student_id IN (
                   SELECT student_id
                   FROM student_registration
                   WHERE site_id = 43)))
ORDER BY student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registration_id,
  degree_id,
  CASE
  WHEN degree_id = 205
    THEN '253'
  WHEN degree_id = 208
    THEN '255'
  WHEN degree_id = 211
    THEN '257'
  WHEN degree_id = 216
    THEN '261'
  WHEN degree_id = 219
    THEN '263'
  WHEN degree_id = 222
    THEN '265'
  WHEN degree_id = 225
    THEN '267'
  WHEN degree_id = 228
    THEN '269'
  WHEN degree_id = 231
    THEN '271'
  WHEN degree_id = 236
    THEN '275'
  WHEN degree_id = 239
    THEN '277'
  WHEN degree_id = 242
    THEN '279'
  WHEN degree_id = 300
    THEN '303'
  WHEN degree_id = 294
    THEN '297'
  ELSE degree_id
  END AS destino,
  student_id,
  schoolyear_id
FROM student_registration
WHERE registration_id IN (SELECT registration_id
             FROM student_registration
             WHERE
               schoolyear_id = 288 OR (
                 schoolyear_id = 198
                 AND student_id IN (
                   SELECT student_id
                   FROM student_registration
                   WHERE site_id = 43)))
ORDER BY student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  full_heritage.*,
  name,
  master
FROM school_structures
  JOIN full_heritage ON school_structures.id = full_heritage.structure_id
WHERE school_structures.type IN ('Schoolyear', 'Site', 'Level', 'Degree')
      AND (
        (FIND_IN_SET(103, sons) OR school_structures.id = 103)
        OR (FIND_IN_SET(275, sons) OR school_structures.id = 275)
      )
;-- -. . -..- - / . -. - .-. -.--
UPDATE registrations
SET degree_id =
CASE
WHEN degree_id = 205
  THEN '253'
WHEN degree_id = 208
  THEN '255'
WHEN degree_id = 211
  THEN '257'
WHEN degree_id = 216
  THEN '261'
WHEN degree_id = 219
  THEN '263'
WHEN degree_id = 222
  THEN '265'
WHEN degree_id = 225
  THEN '267'
WHEN degree_id = 228
  THEN '269'
WHEN degree_id = 231
  THEN '271'
WHEN degree_id = 236
  THEN '275'
WHEN degree_id = 239
  THEN '277'
WHEN degree_id = 242
  THEN '279'
WHEN degree_id = 300
  THEN '303'
WHEN degree_id = 294
  THEN '297'
ELSE degree_id
END
WHERE id IN (2067,
             2065,
             2064,
             2063,
             2061,
             2058,
             2056,
             2045,
             2035,
             2034,
             2278,
             2277,
             2032,
             2031,
             2029,
             2028,
             2027,
             2026,
             2024,
             2023,
             2008,
             2276,
             2275,
             2001,
             2274,
             2273,
             2272,
             2271,
             2270,
             1994,
             1991,
             1990,
             1968,
             1962,
             2269,
             1959,
             2268,
             1955,
             1950,
             1947,
             2267,
             1940,
             2266,
             2265,
             2264,
             2263,
             2262,
             2261,
             1939,
             1937,
             1936,
             2260,
             1935,
             2259,
             1923,
             1895,
             1890,
             2258,
             1881,
             1880,
             2257,
             1878,
             2256,
             1877,
             2255,
             1876,
             1875,
             2254,
             2253,
             2252,
             2251,
             2250,
             2249,
             2248,
             1865,
             1858,
             1855,
             1843,
             1841,
             1829,
             1827,
             1818,
             1808,
             1807,
             1806,
             2247,
             2246,
             2245,
             2244,
             2243,
             2242,
             1779,
             1777,
             1776,
             1773,
             1750,
             1747,
             1737,
             2241,
             2240,
             2239,
             2238,
             2237,
             2236,
             1699,
             1697,
             1692,
             1676,
             1673,
             1659,
             1654,
             1653,
             1652,
             1651,
             1650,
             1649,
             1648,
             2235,
             2234,
             2233,
             2232,
             1647,
             1646,
             1645,
             2231,
             1644,
             2230,
             2229,
             1643,
             1642,
             1641,
             2228,
             2227,
             2226,
             2225,
             2224,
             2223,
             2222,
             2221,
             2220,
             1640,
             1639,
             1638,
             1637,
             1636,
             1635,
             1634,
             1633,
             1632,
             1631,
             1630,
             1629,
             1628,
             1627,
             1626,
             1624,
             1623,
             1622,
             1621,
             1620,
             1619,
             1618,
             1617,
             1616,
             1615,
             1614,
             1613,
             1612,
             1611,
             1610,
             1560,
             1551,
             1540,
             2219,
             1532,
             1521,
             2218,
             1517,
             2217,
             2216,
             2215,
             1515,
             2214,
             2213,
             2212,
             2211,
             1509,
             1508,
             1506,
             1504,
             2210,
             2209,
             2208,
             2207,
             2206,
             1503,
             2205,
             2204,
             2203,
             2202,
             1502,
             2201,
             1501,
             2200,
             1500,
             1499,
             1498,
             1497,
             1496,
             1495,
             2199,
             1494,
             2198,
             1493,
             1492,
             2197,
             2196,
             1491,
             1490,
             1489,
             1488,
             1487,
             1486,
             1485,
             1484,
             1483,
             1482,
             1481,
             1480,
             1479,
             1478,
             1477,
             1476,
             1475,
             1474,
             1473,
             1472,
             1471,
             1470,
             1469,
             1468,
             2195,
             1467,
             1466,
             1465,
             1464,
             1462,
             1460,
             1459,
             1458,
             1457,
             2194,
             2193,
             2192,
             2191,
             2190,
             2189,
             2188,
             2187,
             2186,
             2185,
             2184,
             1392,
             1391,
             1390,
             1389,
             1388,
             1387,
             1386,
             1385,
             1384,
             1383,
             1382,
             1381,
             1380,
             1379,
             1378,
             1377,
             1376,
             1375,
             1374,
             1373,
             1372,
             1371,
             1370,
             1369,
             1368,
             1367,
             1366,
             1365,
             1364,
             1363,
             1362,
             1361,
             1360,
             1359,
             1358,
             1357,
             1356,
             1355,
             1354,
             1353,
             1352,
             1351,
             1350,
             1349,
             1348,
             1347,
             1346,
             1345,
             1344,
             1343,
             1342,
             1341,
             1340,
             1339,
             1338,
             1337,
             1336,
             1335,
             1334,
             1333,
             1332,
             1331,
             1330,
             1329,
             1328,
             1327,
             1326,
             1325,
             1324,
             1323,
             1322,
             1321,
             1320,
             1319,
             1318,
             1317,
             1316,
             1315,
             1314,
             1312,
             2183,
             1310,
             1309,
             1307,
             1306,
             1305,
             1304,
             1303,
             1302,
             1299,
             1298,
             1297,
             1294,
             1292,
             1287,
             1286,
             1281,
             1280,
             2182,
             1275,
             1274,
             1271,
             2181,
             1268,
             1264,
             1263,
             1260,
             1259,
             2180,
             2179,
             2178,
             1258,
             1257,
             2177,
             2176,
             2175,
             1256,
             1254,
             2174,
             1250,
             1240,
             1232,
             1230,
             1227,
             1226,
             1225,
             2173)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
WHERE student_id IN (
  SELECT student_id
  FROM student_registration
  WHERE site_id = 247
) AND tuition_id IN (SELECT id
                     FROM tuitions
                     WHERE type = 'reinscription')
      AND tuition_id > 10
;-- -. . -..- - / . -. - .-. -.--
UPDATE student_tuitions
SET tuition_id = tuition_id - 12
WHERE id IN (88126,
             88140,
             88148,
             88150,
             88160,
             88167,
             88216,
             88217,
             88218,
             88219,
             88231,
             88247,
             88252,
             88256,
             88265,
             88269,
             88276,
             88278,
             88280,
             88289,
             88290,
             88291,
             88292,
             88293,
             88294,
             88295,
             88296,
             88297,
             88298,
             88299,
             88300,
             88301,
             88302,
             88303,
             88304,
             88305,
             88306,
             88307,
             88308,
             88309,
             88310,
             88312,
             88313,
             88314,
             88318,
             88321,
             88328,
             88329,
             88330,
             88331,
             88332,
             88333,
             88340,
             88341,
             88352,
             88357,
             88368,
             88396,
             88407,
             88414,
             88417,
             88429,
             88431,
             88443,
             88479,
             88481,
             88537,
             88540,
             88550,
             88562,
             88563,
             88564,
             88565,
             88566,
             88567,
             88568,
             88569,
             88570,
             88571,
             88572,
             88573,
             88574,
             88575,
             88576,
             88577,
             88578,
             88579,
             88580,
             88581,
             88582,
             88583,
             88584,
             88585,
             88615,
             88621,
             88636,
             88638,
             88639,
             88640,
             88641,
             88642,
             88643,
             88644,
             88645,
             88646,
             88647,
             88648,
             88649,
             88650,
             88651,
             88652,
             88653,
             88654,
             88655,
             88656,
             88657,
             88658,
             88659,
             88660,
             88662,
             88664,
             88665,
             88666,
             88667,
             88694,
             88695,
             88696,
             88697,
             88698,
             88699,
             88700,
             88701,
             88702,
             88703,
             88704,
             88705,
             88706,
             88707,
             88708,
             88709,
             88710,
             88711,
             88712,
             88713,
             88714,
             88715,
             88716,
             88717,
             88718,
             88719,
             88720,
             88721,
             88722,
             88723,
             88724,
             88725,
             88726,
             88727,
             88728,
             88729,
             88732,
             88734,
             88735,
             88737,
             88738,
             88739,
             88741,
             88744,
             88745,
             88750,
             88751,
             88758,
             88767,
             88769,
             88776,
             88782,
             88784,
             88785,
             88786,
             88787,
             88788,
             88816,
             88817,
             88818,
             88819,
             88820,
             88821,
             88822,
             88823,
             88824,
             88825,
             88826,
             88827,
             88828,
             88829,
             88830,
             88861,
             88862,
             88863,
             88864,
             88865,
             88866,
             88867,
             88868,
             88869,
             88870,
             88871,
             88872,
             88873,
             88874,
             88875,
             88876,
             88877,
             88878,
             88879,
             88880,
             88881,
             88882,
             88885,
             88892,
             88893,
             88895,
             88905,
             88906,
             88907)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  amount,
  tuition_id,
  CASE
  WHEN tuition_id = 42
    THEN amount / 8100 * 8620
  WHEN tuition_id = 45
    THEN amount / 7500 * 8100
  WHEN tuition_id = 48
    THEN amount / 6600 * 7450
  END
FROM student_tuitions
WHERE tuition_id IN (42, 45, 48)
;-- -. . -..- - / . -. - .-. -.--
UPDATE student_tuitions
SET amount = CASE
             WHEN tuition_id = 42
               THEN amount / 8100 * 8620
             WHEN tuition_id = 45
               THEN amount / 7500 * 8100
             WHEN tuition_id = 48
               THEN amount / 6600 * 7450
             END
WHERE tuition_id IN (42, 45, 48)
;-- -. . -..- - / . -. - .-. -.--
SELECT
ifnull(level_id, tuition_structure_id) AS levelId,
tuition_id,
date_format(MAX(payments.payed_at), '%Y-%m-%d') AS payed_at,
student_id,
payments.type,
MAX(expected_at) AS expected_at,
SUM(student_payment_detail.amount) AS amount,
student_payment_detail.payment_id
FROM student_payment_detail
LEFT JOIN payments ON payments.id=student_payment_detail.payment_id
WHERE date_format(payments.payed_at, '%Y-%m') = '2016-01'
GROUP BY student_payment_detail.payment_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.school_enrollment,
  reporte1.*
FROM (SELECT
        ifnull(level_id, tuition_structure_id)          AS levelId,
        tuition_id,
        date_format(MAX(payments.payed_at), '%Y-%m-%d') AS payed_at,
        student_id,
        payments.type,
        MAX(expected_at)                                AS expected_at,
        SUM(student_payment_detail.amount)              AS amount,
        student_payment_detail.payment_id
      FROM student_payment_detail
        LEFT JOIN payments ON payments.id = student_payment_detail.payment_id
      WHERE date_format(payments.payed_at, '%Y-%m') = '2016-01'
      GROUP BY student_payment_detail.payment_id) AS reporte1
  LEFT JOIN students ON reporte1.student_id = students.people_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.school_enrollment,
  reporte1.*
FROM (SELECT
        ifnull(level_id, tuition_structure_id)          AS levelId,
        tuition_id,
        date_format(MAX(payments.payed_at), '%Y-%m-%d') AS payed_at,
        student_id,
        payments.type,
        MAX(expected_at)                                AS expected_at,
        SUM(student_payment_detail.amount)              AS amount,
        student_payment_detail.payment_id
      FROM student_payment_detail
        LEFT JOIN payments ON payments.id = student_payment_detail.payment_id
      WHERE date_format(payments.payed_at, '%Y-%m') = '2016-01'
        AND tuition_id = 25
      GROUP BY student_payment_detail.payment_id) AS reporte1
  LEFT JOIN students ON reporte1.student_id = students.people_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.school_enrollment,
  reporte1.*
FROM (SELECT
        ifnull(level_id, tuition_structure_id)          AS levelId,
        tuition_id,
        date_format(MAX(payments.payed_at), '%Y-%m-%d') AS payed_at,
        student_id,
        payments.type,
        MAX(expected_at)                                AS expected_at,
        SUM(student_payment_detail.amount)              AS amount,
        student_payment_detail.payment_id
      FROM student_payment_detail
        LEFT JOIN payments ON payments.id = student_payment_detail.payment_id
      WHERE date_format(payments.payed_at, '%Y-%m') = '2016-01'
        AND tuition_id = 25
      GROUP BY student_payment_detail.payment_id) AS reporte1
  LEFT JOIN students ON reporte1.student_id = students.people_id
ORDER BY school_enrollment
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE status = 0
;-- -. . -..- - / . -. - .-. -.--
SELECT count(id)
FROM student_grades
WHERE status = 0
;-- -. . -..- - / . -. - .-. -.--
SELECT count(id), min(created_at), max(updated_at)
FROM student_grades
WHERE status = 0
;-- -. . -..- - / . -. - .-. -.--
SELECT count(id), min(created_at), max(updated_at)
FROM student_grades
WHERE status = 0 AND created_at < '2016'
;-- -. . -..- - / . -. - .-. -.--
SELECT count(id), min(created_at), max(updated_at)
FROM student_grades
WHERE status = 0 AND created_at < '2016-01-01'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE status = 0 AND created_at < '2016-01-01'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE student_id =3150
;-- -. . -..- - / . -. - .-. -.--
UPDATE student_grades SET status=3 WHERE status=0
;-- -. . -..- - / . -. - .-. -.--
SELECT id, status +0, status
FROM invoices
WHERE (status & 10 OR status & 1) AND NOT status & 10000 AND NOT status & 1000
;-- -. . -..- - / . -. - .-. -.--
SELECT student_tuition_detail.tuition_type, student_registration.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON
                                     student_registration.schoolyear_id = student_tuition_detail
                                     .schoolyear_id AND
                                     student_registration.site_id = student_tuition_detail.site_id
                                     AND
                                     student_registration.level_id = student_tuition_detail.level_id
                                     AND
                                     student_registration.degree_id =
                                     student_tuition_detail.degree_id AND
                                     student_registration.student_id =
                                     student_tuition_detail.student_id
WHERE student_registration.status = 'Activo'
      AND student_registration.degree_id = 255
      AND student_tuition_detail.tuition_type IN ('reinscription','inscription')
      AND payment_time = 1 AND student_tuition_detail.type = 'normal'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_registration`.*,
  `people`.`first_name`,
  `people`.`names`,
  `people`.`second_name`,
  `student_tuition_detail`.`tuition_type`
FROM `student_registration`
  LEFT JOIN `people` ON `student_registration`.`student_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_registration`.`schoolyear_id` =
                                        `student_tuition_detail`.`schoolyear_id` AND
                                        `student_registration`.`site_id` =
                                        `student_tuition_detail`.`site_id` AND
                                        `student_registration`.`level_id` =
                                        `student_tuition_detail`.`level_id` AND
                                        `student_registration`.`degree_id` =
                                        `student_tuition_detail`.`degree_id` AND
                                        `student_registration`.`student_id` =
                                        `student_tuition_detail`.`student_id`
WHERE `student_registration`.`status` = 'Activo' AND `student_tuition_detail`.`tuition_type` IN
                                                    ('reinscription', 'inscription') AND
      `student_tuition_detail`.`payment_time` = 1 AND `student_tuition_detail`.`type` = 'normal'
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(id), MAX(created_at), MIN(created_at)
FROM invoices
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(id), MAX(created_at), MIN(created_at)
FROM invoices
WHERE FIND_IN_SET('stamped', status)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(IF(find_in_set('canceled',status),1,2), MAX(created_at), MIN(created_at)
FROM invoices
WHERE FIND_IN_SET('stamped', status)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(IF(find_in_set('canceled',status),1,2)), MAX(created_at), MIN(created_at)
FROM invoices
WHERE FIND_IN_SET('stamped', status)
;-- -. . -..- - / . -. - .-. -.--
SELECT IF(find_in_set('canceled',status),1,2)), status, id
FROM invoices
WHERE FIND_IN_SET('stamped', status)
;-- -. . -..- - / . -. - .-. -.--
SELECT IF(find_in_set('canceled',status),1,2), status, id
FROM invoices
WHERE FIND_IN_SET('stamped', status)
;-- -. . -..- - / . -. - .-. -.--
SELECT IF(find_in_set('canceled',status),2,1), status, id
FROM invoices
WHERE FIND_IN_SET('stamped', status)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(IF(find_in_set('canceled',status),2,1)), MAX(created_at), MIN(created_at)
FROM invoices
WHERE FIND_IN_SET('stamped', status)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (SELECT SUM(IF(find_in_set('canceled',status),2,1)) AS timbres, MAX(created_at) AS inicio,
               MIN
(created_at) AS fin
FROM invoices
WHERE FIND_IN_SET('stamped', status)) AS tmp
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (SELECT SUM(IF(find_in_set('canceled',status),2,1)) AS timbres, MAX(created_at) AS inicio,
               MIN(created_at) AS fin
FROM invoices
WHERE FIND_IN_SET('stamped', status)) AS tmp
;-- -. . -..- - / . -. - .-. -.--
SELECT *, DATEDIFF(inicio, fin)
FROM (SELECT SUM(IF(find_in_set('canceled',status),2,1)) AS timbres, MAX(created_at) AS inicio,
               MIN(created_at) AS fin
FROM invoices
WHERE FIND_IN_SET('stamped', status)) AS tmp
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *,
  DATEDIFF(inicio, fin) AS dias,
  timbres / (PERIOD_DIFF(date_format(inicio, '%Y%m'), date_format(fin, '%Y%m'))) AS byMonth
FROM (SELECT
        SUM(IF(find_in_set('canceled', status), 2, 1)) AS timbres,
        MAX(created_at)                                AS inicio,
        MIN(created_at)                                AS fin
      FROM invoices
      WHERE FIND_IN_SET('stamped', status)) AS tmp
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *, timbres *0.9
  DATEDIFF(inicio, fin) AS dias,
  timbres / (PERIOD_DIFF(date_format(inicio, '%Y%m'), date_format(fin, '%Y%m'))) AS byMonth
FROM (SELECT
        SUM(IF(find_in_set('canceled', status), 2, 1)) AS timbres,
        MAX(created_at)                                AS inicio,
        MIN(created_at)                                AS fin
      FROM invoices
      WHERE FIND_IN_SET('stamped', status)) AS tmp
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *, timbres *0.9,
  DATEDIFF(inicio, fin) AS dias,
  timbres / (PERIOD_DIFF(date_format(inicio, '%Y%m'), date_format(fin, '%Y%m'))) AS byMonth
FROM (SELECT
        SUM(IF(find_in_set('canceled', status), 2, 1)) AS timbres,
        MAX(created_at)                                AS inicio,
        MIN(created_at)                                AS fin
      FROM invoices
      WHERE FIND_IN_SET('stamped', status)) AS tmp
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = registrations.student_id
  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE tuitions.type IN ('reinscription', 'inscription') AND registrations.status = 'Aprobado'
;-- -. . -..- - / . -. - .-. -.--
SELECT registrations.id,
  registrations.status,
  student_tuition_detail.id,
  tuitions.type
FROM registrations
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = registrations.student_id
  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE tuitions.type IN ('reinscription', 'inscription') AND registrations.status = 'Aprobado'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.id,
  tuitions.type
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = registrations.student_id

  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE tuitions.type IN ('reinscription', 'inscription') AND registrations.status = 'Aprobado'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.id,
  tuitions.type
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id

  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE tuitions.type IN ('reinscription', 'inscription') AND student_registration.status = 'Aprobado'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.id,
  tuitions.type
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id

  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE tuitions.type IN ('reinscription', 'inscription') AND student_registration.status = 'Aprobado'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  tuitions.type,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id

  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE tuitions.type IN ('reinscription', 'inscription') AND student_registration.status = 'Aprobado'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  tuitions.type,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE tuitions.type IN ('reinscription', 'inscription') AND student_registration.status = 'Aprobado'
AND student_registration.schoolyear_id IN (188,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  tuitions.type,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
  LEFT JOIN tuitions ON student_tuition_detail.tuition_id = tuitions.id
WHERE student_registration.status = 'Aprobado'
AND student_registration.schoolyear_id IN (188,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  tuitions.type,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
WHERE student_registration.status = 'Aprobado'
AND student_registration.schoolyear_id IN (188,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
WHERE student_registration.status = 'Aprobado'
AND student_registration.schoolyear_id IN (188,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
WHERE student_registration.schoolyear_id IN (188,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
WHERE student_registration.student_id = 3000
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
WHERE student_registration.status = 'Aprobado'
AND student_registration.schoolyear_id IN (198,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
  AND student_tuition_detail.type !='tuition'
WHERE student_registration.status = 'Aprobado'
AND student_registration.schoolyear_id IN (198,288)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.registration_id,
  student_registration.student_id,
  student_registration.status,
  student_registration.schoolyear_id,
  student_registration.site_id,
  student_registration.level_id,
  student_registration.degree_id,
  student_registration.group_id,
  student_tuition_detail.*
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_tuition_detail.student_id = student_registration.student_id
  AND student_registration.schoolyear_id = student_tuition_detail.schoolyear_id
  AND student_tuition_detail.tuition_type != 'tuition'
WHERE student_registration.status = 'Aprobado'
AND student_registration.schoolyear_id IN (198,288)
;-- -. . -..- - / . -. - .-. -.--
UPDATE student_tuitions SET tuition_id = 51 WHERE id in (89298 ,88885 ,89750 ,88872 ,88869 ,91153)
;-- -. . -..- - / . -. - .-. -.--
SELECT students.school_enrollment, first_name, second_name, names, school_structures.name, 
  grading_periods.time
FROM student_grades
LEFT JOIN students ON students.people_id = student_grades.student_id
LEFT JOIN people ON people.id = student_grades.student_id
LEFT JOIN grading_periods ON grading_periods.id = student_grades.grading_period
LEFT JOIN school_structures ON grading_periods.period_id = school_structures.id
;-- -. . -..- - / . -. - .-. -.--
SELECT students.school_enrollment, first_name, second_name, names, school_structures.name, 
  grading_periods.time
FROM student_grades
LEFT JOIN students ON students.people_id = student_grades.student_id
LEFT JOIN people ON people.id = student_grades.student_id
LEFT JOIN grading_periods ON grading_periods.id = student_grades.grading_period
LEFT JOIN school_structures ON grading_periods.period_id = school_structures.id
WHERE grade > 100
;-- -. . -..- - / . -. - .-. -.--
SELECT students.school_enrollment, first_name, second_name, names, 
  grading_periods.time, school_structures.name
FROM student_grades
LEFT JOIN students ON students.people_id = student_grades.student_id
LEFT JOIN people ON people.id = student_grades.student_id
LEFT JOIN grading_periods ON grading_periods.id = student_grades.grading_period
LEFT JOIN school_structures ON grading_periods.period_id = school_structures.id
WHERE grade > 100
;-- -. . -..- - / . -. - .-. -.--
SELECT students.school_enrollment, first_name, second_name, names, subjects.name,
  grading_periods.time, school_structures.name
FROM student_grades
LEFT JOIN students ON students.people_id = student_grades.student_id
LEFT JOIN people ON people.id = student_grades.student_id
LEFT JOIN grading_periods ON grading_periods.id = student_grades.grading_period
LEFT JOIN school_structures ON grading_periods.period_id = school_structures.id
  LEFT JOIN teacher_criteria ON student_grades.evaluation_id = teacher_criteria.id
  LEFT JOIN subjects ON subjects.id = teacher_criteria.subject_id
WHERE grade > 100
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    MAX(tuitions.structure_id)      AS tuition_structure_id,
    MAX(schoolyears.structure_id)   AS schoolyear_id,
    MAX(sites.structure_id)         AS site_id,
    MAX(levels.structure_id)        AS level_id,
    MAX(degrees.structure_id)       AS degree_id,
    MAX(school_groups.structure_id) AS group_id,
    tuitions.type                   AS tuition_type,
    student_tuitions.*
  FROM student_tuitions
    LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
    LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                               AND structure_tuitions.id = registrations.degree_id
    LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
    LEFT JOIN schoolyears ON (
      structure_tuitions.ancestor = schoolyears.structure_id OR
      structure_tuitions.decendants = schoolyears.structure_id OR
      structure_tuitions.structure_id = schoolyears.structure_id
      )
    LEFT JOIN sites ON (
      structure_tuitions.ancestor = sites.structure_id OR
      structure_tuitions.decendants = sites.structure_id OR
      structure_tuitions.structure_id = sites.structure_id
      )
    LEFT JOIN levels ON (
      structure_tuitions.ancestor = levels.structure_id OR
      structure_tuitions.decendants = levels.structure_id OR
      structure_tuitions.structure_id = levels.structure_id
      )
    LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
      structure_tuitions.ancestor = degrees.structure_id OR
      structure_tuitions.decendants = degrees.structure_id OR
      structure_tuitions.structure_id = degrees.structure_id
    )
    LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
      structure_tuitions.ancestor = school_groups.structure_id OR
      structure_tuitions.decendants = school_groups.structure_id OR
      structure_tuitions.structure_id = school_groups.structure_id
    )
    LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
  WHERE isnull(student_tuitions.deleted_at)
  GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT * 
FROM (
  SELECT DISTINCTROW
    MAX(tuitions.structure_id)      AS tuition_structure_id,
    MAX(schoolyears.structure_id)   AS schoolyear_id,
    MAX(sites.structure_id)         AS site_id,
    MAX(levels.structure_id)        AS level_id,
    MAX(degrees.structure_id)       AS degree_id,
    MAX(school_groups.structure_id) AS group_id,
    tuitions.type                   AS tuition_type,
    student_tuitions.*
  FROM student_tuitions
    LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
    LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                               AND structure_tuitions.structure_id = registrations.degree_id
    LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
    LEFT JOIN schoolyears ON (
      structure_tuitions.ancestor = schoolyears.structure_id OR
      structure_tuitions.decendants = schoolyears.structure_id OR
      structure_tuitions.structure_id = schoolyears.structure_id
      )
    LEFT JOIN sites ON (
      structure_tuitions.ancestor = sites.structure_id OR
      structure_tuitions.decendants = sites.structure_id OR
      structure_tuitions.structure_id = sites.structure_id
      )
    LEFT JOIN levels ON (
      structure_tuitions.ancestor = levels.structure_id OR
      structure_tuitions.decendants = levels.structure_id OR
      structure_tuitions.structure_id = levels.structure_id
      )
    LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
      structure_tuitions.ancestor = degrees.structure_id OR
      structure_tuitions.decendants = degrees.structure_id OR
      structure_tuitions.structure_id = degrees.structure_id
    )
    LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
      structure_tuitions.ancestor = school_groups.structure_id OR
      structure_tuitions.decendants = school_groups.structure_id OR
      structure_tuitions.structure_id = school_groups.structure_id
    )
    LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
  WHERE isnull(student_tuitions.deleted_at)
  GROUP BY student_tuitions.id)
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (
  SELECT DISTINCTROW
    MAX(tuitions.structure_id)      AS tuition_structure_id,
    MAX(schoolyears.structure_id)   AS schoolyear_id,
    MAX(sites.structure_id)         AS site_id,
    MAX(levels.structure_id)        AS level_id,
    MAX(degrees.structure_id)       AS degree_id,
    MAX(school_groups.structure_id) AS group_id,
    tuitions.type                   AS tuition_type,
    student_tuitions.*
  FROM student_tuitions
    LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
    LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                               AND structure_tuitions.structure_id = registrations.degree_id
    LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
    LEFT JOIN schoolyears ON (
      structure_tuitions.ancestor = schoolyears.structure_id OR
      structure_tuitions.decendants = schoolyears.structure_id OR
      structure_tuitions.structure_id = schoolyears.structure_id
      )
    LEFT JOIN sites ON (
      structure_tuitions.ancestor = sites.structure_id OR
      structure_tuitions.decendants = sites.structure_id OR
      structure_tuitions.structure_id = sites.structure_id
      )
    LEFT JOIN levels ON (
      structure_tuitions.ancestor = levels.structure_id OR
      structure_tuitions.decendants = levels.structure_id OR
      structure_tuitions.structure_id = levels.structure_id
      )
    LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
      structure_tuitions.ancestor = degrees.structure_id OR
      structure_tuitions.decendants = degrees.structure_id OR
      structure_tuitions.structure_id = degrees.structure_id
    )
    LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
      structure_tuitions.ancestor = school_groups.structure_id OR
      structure_tuitions.decendants = school_groups.structure_id OR
      structure_tuitions.structure_id = school_groups.structure_id
    )
    LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
  WHERE isnull(student_tuitions.deleted_at)
  GROUP BY student_tuitions.id) AS tmp
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  INNER JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.structure_id = registrations.degree_id
WHERE student_tuitions.student_id = 3373
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.structure_id = registrations.degree_id
WHERE student_tuitions.student_id = 3373
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
WHERE student_id = 3373 AND degree_id=48
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.structure_id = registrations.degree_id
WHERE student_tuitions.student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND (structure_tuitions.ancestor = registrations.degree_id
                             OR structure_tuitions.structure_id = registrations.degree_id
                             OR structure_tuitions.decendants = registrations.degree_id
                             )
WHERE student_tuitions.student_id = 3373
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND (structure_tuitions.ancestor = registrations.degree_id
                             OR structure_tuitions.structure_id = registrations.degree_id
                             OR structure_tuitions.decendants = registrations.degree_id
                             )
WHERE student_tuitions.student_id = 3373
GROUP BY registrations.id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND (structure_tuitions.ancestor = registrations.degree_id
                             OR structure_tuitions.structure_id = registrations.degree_id
                             OR structure_tuitions.decendants = registrations.degree_id
                             )
WHERE student_tuitions.student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  INNER JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND (structure_tuitions.ancestor = registrations.degree_id
                             OR structure_tuitions.structure_id = registrations.degree_id
                             OR structure_tuitions.decendants = registrations.degree_id
                             )
WHERE student_tuitions.student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
                             AND (structure_tuitions.ancestor = registrations.degree_id
                             OR structure_tuitions.structure_id = registrations.degree_id
                             OR structure_tuitions.decendants = registrations.degree_id
                             )
WHERE student_tuitions.student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
                                  AND (structure_tuitions.ancestor = registrations.degree_id
                                       OR structure_tuitions.structure_id = registrations.degree_id
                                       OR structure_tuitions.decendants = registrations.degree_id
                                  )
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
  LEFT JOIN structure_tuitions ON (structure_tuitions.ancestor = registrations.degree_id
                                       OR structure_tuitions.structure_id = registrations.degree_id
                                       OR structure_tuitions.decendants = registrations.degree_id
                                  )
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = registrations.degree_id
                                       OR structure_tuitions.structure_id = registrations.degree_id
                                       OR structure_tuitions.decendants = registrations.degree_id
                                  )
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = registrations.degree_id
                                       OR structure_tuitions.structure_id = registrations.degree_id
                                       OR structure_tuitions.decendants = registrations.degree_id
                                  )
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.degree_id
                                       OR structure_tuitions.structure_id = student_registration.degree_id
                                       OR structure_tuitions.decendants = student_registration.degree_id
                                  )
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.schoolyear_id
                                       AND structure_tuitions.structure_id = student_registration.degree_id
                                       OR structure_tuitions.decendants = student_registration.degree_id
                                  )
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.schoolyear_id
                                  )
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.schoolyear_id
    AND decendants = student_registration.degree_id)
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.schoolyear_id
    AND decendants = student_registration.group_id)
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.schoolyear_id
                                    AND decendants = student_registration.group_id)
  INNER JOIN student_tuitions ON student_registration.student_id = student_tuitions.student_id
                                 AND structure_tuitions.id = student_tuitions.tuition_id
WHERE student_tuitions.student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT student_tuitions.*, student_registration.registration_id, structure_tuitions.id
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.schoolyear_id
                                    AND decendants = student_registration.group_id)
  INNER JOIN student_tuitions ON student_registration.student_id = student_tuitions.student_id
                                 AND structure_tuitions.id = student_tuitions.tuition_id
WHERE student_tuitions.student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT student_tuitions.*, student_registration.registration_id, structure_tuitions.id
FROM student_registration
  INNER JOIN structure_tuitions ON (structure_tuitions.ancestor = student_registration.schoolyear_id
                                    AND decendants = student_registration.group_id)
  left JOIN student_tuitions ON student_registration.student_id = student_tuitions.student_id
                                 AND structure_tuitions.id = student_tuitions.tuition_id
WHERE student_tuitions.student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM cashiers
WHERE authorized RLIKE '1'
;-- -. . -..- - / . -. - .-. -.--
SELECT 315, ancestor, @row_number := @row_number +1
  FROM (SELECT * FROM heritages UNION ALL SELECT 261,261, 1000) AS relUpdater,
    (SELECT @row_number := 0) AS t
  WHERE structure_id = 261
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO heritages (structure_id, ancestor, position)
  SELECT 315, ancestor, @row_number := @row_number +1
  FROM (SELECT * FROM heritages UNION ALL SELECT 261,261, 1000) AS relUpdater,
    (SELECT @row_number := 0) AS t
  WHERE structure_id = 261
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO address_family SELECT
                              address_id,
                              family_id
                            FROM
                              (SELECT
                                 SOUNDEX(address) AS addressSound,
                                 id
                               FROM addresses
                               WHERE created_at > '2016-01-01'
                               GROUP BY SOUNDEX(address)) AS addressCondenced
                              INNER JOIN address_people
                                ON addressCondenced.id = address_people.address_id
                                   AND address_people.type = 'Familiar'
                              INNER JOIN family_people
                                ON address_people.people_id = family_people.people_id
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM address_people
WHERE type = 'Familiar' AND address_id IN (SELECT id
                                           FROM addresses
                                           WHERE created_at > '2016-01-01')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM address_people
WHERE type = 'Familiar' AND address_id IN (SELECT id
                                           FROM addresses
                                           WHERE created_at > '2016-01-01')
;-- -. . -..- - / . -. - .-. -.--
SELECT LENGTH(address),LENGTH(location)
FROM addresses
ORDER BY LENGTH(address)DESC ,LENGTH(location) DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW LENGTH(address),LENGTH(location), address, location
FROM addresses
ORDER BY LENGTH(address)DESC ,LENGTH(location) DESC
LIMIT 10
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW LENGTH(address),LENGTH(location), address, location
FROM addresses
ORDER BY LENGTH(address)DESC ,LENGTH(location) DESC
LIMIT 100
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW LENGTH(address),LENGTH(location), address, location
FROM addresses
ORDER BY LENGTH(address)DESC ,LENGTH(location) DESC
LIMIT 200
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT LENGTH(address),LENGTH(location), address, location
FROM addresses
ORDER BY LENGTH(address)DESC ,LENGTH(location) DESC
LIMIT 200
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT LENGTH(address),LENGTH(location), address, location
FROM addresses
ORDER BY LENGTH(location) DESC, LENGTH(address)DESC
LIMIT 200
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id,
  people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241,243)) AND
      grading_period=65 AND committed_at >= '2016-10-27'
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241,243)) AND
      grading_period=65 AND committed_at >= '2016-10-27'
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (230)) AND
      grading_period=65 AND committed_at >= '2016-10-27'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuitions
WHERE tuition_id = 72 AND payment_index = 0
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
WHERE student_id = 2730
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM registrations
WHERE degree_id BETWEEN 316 AND 337
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM group_student
WHERE group_id BETWEEN 288 AND 315
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM group_student
WHERE group_id BETWEEN 288 AND 308
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id+28, student_id
  FROM group_student
  WHERE group_id BETWEEN 288 AND 308
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id+28, student_id, group_id
  FROM group_student
  WHERE group_id BETWEEN 288 AND 308
;-- -. . -..- - / . -. - .-. -.--
SELECT group_id+28+3, student_id, group_id
  FROM group_student
  WHERE group_id BETWEEN 288 AND 305