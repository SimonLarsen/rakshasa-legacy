return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 30,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 307,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 12,
          name = "0",
          type = "FanPatrol",
          shape = "polyline",
          x = 158.667,
          y = -32.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 1.33333, y = 114.667 }
          },
          properties = {}
        },
        {
          id = 7,
          name = "3",
          type = "Spawner",
          shape = "polyline",
          x = 94.6667,
          y = -28.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 533.333 }
          },
          properties = {
            ["count"] = 3,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 8,
          name = "2",
          type = "Spawner",
          shape = "polyline",
          x = 224.667,
          y = -30,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 533.333 }
          },
          properties = {
            ["count"] = 3,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 9,
          name = "2",
          type = "Spawner",
          shape = "polyline",
          x = 44,
          y = -30,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 533.333 }
          },
          properties = {
            ["count"] = 3,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 10,
          name = "2",
          type = "Spawner",
          shape = "polyline",
          x = 275.333,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 533.333 }
          },
          properties = {
            ["count"] = 3,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 29,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 128,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 192,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "2.5",
          type = "Bunker",
          shape = "rectangle",
          x = 16,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 80,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 240,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 304,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "0.8",
          type = "Bunker",
          shape = "rectangle",
          x = 48,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 272,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "3",
          type = "Spawner",
          shape = "polyline",
          x = -32,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 384, y = 0 }
          },
          properties = {
            ["count"] = 2,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 52,
          name = "0.4",
          type = "AimedDrone",
          shape = "polyline",
          x = -32,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 192, y = 0 },
            { x = 192, y = 32 }
          },
          properties = {}
        },
        {
          id = 53,
          name = "0.2",
          type = "Spawner",
          shape = "polyline",
          x = -32,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 384, y = 0 }
          },
          properties = {
            ["count"] = 2,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 54,
          name = "2",
          type = "FanPatrol",
          shape = "polyline",
          x = 80,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 128 },
            { x = 0, y = 192 }
          },
          properties = {}
        },
        {
          id = 55,
          name = "0",
          type = "FanPatrol",
          shape = "polyline",
          x = 240,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 128 },
            { x = 0, y = 192 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "3",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 81,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 336,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        },
        {
          id = 105,
          name = "0.2364",
          type = "Bunker",
          shape = "rectangle",
          x = 106.242,
          y = 324.182,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 106,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 215.667,
          y = 323.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 109,
          name = "0.6776",
          type = "Bunker",
          shape = "rectangle",
          x = 61.697,
          y = 290.303,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        },
        {
          id = 110,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 258,
          y = 290.242,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        },
        {
          id = 111,
          name = "0.8294",
          type = "Bunker",
          shape = "rectangle",
          x = 39.6667,
          y = 248.833,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 112,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 279.992,
          y = 248.11,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 113,
          name = "0.8166",
          type = "Bunker",
          shape = "rectangle",
          x = 32,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        },
        {
          id = 127,
          name = "0",
          type = "SuperMine",
          shape = "rectangle",
          x = 160,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 114,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 288,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        },
        {
          id = 115,
          name = "0.8166",
          type = "Bunker",
          shape = "rectangle",
          x = 40.0606,
          y = 167.455,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 116,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 280.3,
          y = 167.545,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 117,
          name = "0.8294",
          type = "Bunker",
          shape = "rectangle",
          x = 61.9091,
          y = 125.758,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        },
        {
          id = 118,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 258,
          y = 125.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        },
        {
          id = 119,
          name = "0.6766",
          type = "Bunker",
          shape = "rectangle",
          x = 109,
          y = 91.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 120,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 212.712,
          y = 91.4848,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = 6
          }
        },
        {
          id = 121,
          name = "0.2364",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 6
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "4",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 131,
          name = "0",
          type = "Temple",
          shape = "rectangle",
          x = 160,
          y = 90,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 142,
          name = "1.5",
          type = "Mine",
          shape = "rectangle",
          x = 64.6667,
          y = 259.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 144,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 257.333,
          y = 258,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "5",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 193,
          name = "0",
          type = "Patrol",
          shape = "polyline",
          x = 143.5,
          y = -28,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 47.5, y = 106.5 }
          },
          properties = {}
        },
        {
          id = 182,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 41.3333,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 184,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 73.3333,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 185,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 105.333,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 186,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 137.333,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 194,
          name = "1",
          type = "Patrol",
          shape = "polyline",
          x = 307,
          y = -33,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -52.5, y = 150.5 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "6",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 211,
          name = "0",
          type = "Patrol",
          shape = "polyline",
          x = 208,
          y = -32.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -89, y = 110 }
          },
          properties = {}
        },
        {
          id = 212,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 277,
          y = 159.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 213,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 181,
          y = 159.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 214,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 213,
          y = 159.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 215,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 245,
          y = 159.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 216,
          name = "1",
          type = "Patrol",
          shape = "polyline",
          x = 12,
          y = -41.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 49, y = 157 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "7",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 220,
          name = "0",
          type = "FanPatrol",
          shape = "polyline",
          x = 161.333,
          y = -46.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 144 },
            { x = 0, y = 224 }
          },
          properties = {}
        },
        {
          id = 221,
          name = "0.5",
          type = "Patrol",
          shape = "polyline",
          x = 367.333,
          y = 158.666,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -104.667, y = -110.667 }
          },
          properties = {}
        },
        {
          id = 222,
          name = "0.5",
          type = "Patrol",
          shape = "polyline",
          x = -46,
          y = 146,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 104.667, y = -98.6667 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "8",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 223,
          name = "0",
          type = "AimedDrone",
          shape = "polyline",
          x = 80,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 224 },
            { x = 0, y = 272 },
            { x = -4, y = 224.667 },
            { x = -144, y = 224 }
          },
          properties = {}
        },
        {
          id = 227,
          name = "0.5",
          type = "AimedDrone",
          shape = "polyline",
          x = 240,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 224 },
            { x = 0, y = 272 },
            { x = 4.66667, y = 223.333 },
            { x = 144, y = 224 }
          },
          properties = {}
        },
        {
          id = 237,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 352,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 248,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 128,
          y = 336,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 249,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 192,
          y = 336,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 250,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 251,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 128,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 252,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 192,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 265,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 267,
          name = "1",
          type = "Mine",
          shape = "rectangle",
          x = 160,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 282,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 48,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 283,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 272,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 284,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 16,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 285,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 80,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 286,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 240,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 287,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 304,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 289,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 48,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 290,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 272,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 291,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 16,
          y = 272,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 292,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 80,
          y = 272,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 293,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 240,
          y = 272,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 294,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 304,
          y = 272,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 295,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 48,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 296,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 272,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false,
            ["time"] = "5"
          }
        },
        {
          id = 297,
          name = "1",
          type = "Mine",
          shape = "rectangle",
          x = 48,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 298,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 272,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 301,
          name = "3",
          type = "Patrol",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 128 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "9",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 304,
          name = "0",
          type = "Temple",
          shape = "rectangle",
          x = 96,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 306,
          name = "0",
          type = "Temple",
          shape = "rectangle",
          x = 224,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
