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
  nextobjectid = 291,
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
          id = 28,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 160,
          y = 144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "3",
          type = "Bunker",
          shape = "rectangle",
          x = 80,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 240,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 48,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 272,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "2",
          type = "Mine",
          shape = "rectangle",
          x = 125,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 195,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "2",
          type = "Fighter",
          shape = "polyline",
          x = 64,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 43,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 256,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 44,
          name = "2",
          type = "Turret",
          shape = "rectangle",
          x = 112,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 208,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "3",
          type = "AimedDrone",
          shape = "polyline",
          x = 352,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 32 },
            { x = -256, y = 128 },
            { x = -304, y = 512 }
          },
          properties = {}
        },
        {
          id = 53,
          name = "1",
          type = "AimedDrone",
          shape = "polyline",
          x = 272,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -304, y = 32 },
            { x = -32, y = 128 },
            { x = 0, y = 512 }
          },
          properties = {}
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
          id = 86,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = -1,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384, y = 384 }
          },
          properties = {
            ["count"] = 6,
            ["delay"] = 0.25,
            ["type"] = "Scout"
          }
        },
        {
          id = 87,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -384, y = 0 },
            { x = 0, y = 384 }
          },
          properties = {
            ["count"] = 6,
            ["delay"] = 0.25,
            ["type"] = "Scout"
          }
        },
        {
          id = 132,
          name = "2",
          type = "Turret",
          shape = "rectangle",
          x = 160,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 154,
          name = "3",
          type = "Fighter",
          shape = "polyline",
          x = 48,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 208 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 155,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 272,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 208 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 156,
          name = "4",
          type = "Striker",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 304 },
            { x = 0, y = 544 }
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
          id = 191,
          name = "0",
          type = "Patrol",
          shape = "polyline",
          x = 288,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -48, y = 96 }
          },
          properties = {}
        },
        {
          id = 192,
          name = "0.3",
          type = "Patrol",
          shape = "polyline",
          x = 32,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 48, y = 96 }
          },
          properties = {}
        },
        {
          id = 219,
          name = "2",
          type = "Turret",
          shape = "rectangle",
          x = 160,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 215,
          name = "2",
          type = "AimedPatrol",
          shape = "polyline",
          x = 207.333,
          y = -34.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -95.333, y = 2.6667 },
            { x = -159.333, y = 130.667 },
            { x = -127.333, y = 290.667 }
          },
          properties = {
            ["enter_time"] = 2
          }
        },
        {
          id = 216,
          name = "0.5",
          type = "AimedPatrol",
          shape = "polyline",
          x = 110,
          y = -34.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 98, y = 2.6667 },
            { x = 162, y = 130.667 },
            { x = 130, y = 290.667 }
          },
          properties = {
            ["enter_time"] = 2
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
          id = 261,
          name = "0",
          type = "Striker",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 258,
          name = "1.5",
          type = "Striker",
          shape = "polyline",
          x = 256,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 259,
          name = "1.5",
          type = "Striker",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 260,
          name = "1.5",
          type = "Striker",
          shape = "polyline",
          x = 64,
          y = -30,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 268,
          name = "1.5",
          type = "Striker",
          shape = "polyline",
          x = 160,
          y = -29.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 269,
          name = "1.5",
          type = "Striker",
          shape = "polyline",
          x = 256,
          y = -30.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 264,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 137.333,
          y = 183.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 265,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 185.333,
          y = 183.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 263,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 88,
          y = 231.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 266,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 230.667,
          y = 232,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 262,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 39.3333,
          y = 264,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 267,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 280,
          y = 262.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 270,
          name = "1",
          type = "Patrol",
          shape = "polyline",
          x = 30,
          y = -41.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 82, y = 121.333 }
          },
          properties = {}
        },
        {
          id = 271,
          name = "0.5",
          type = "Patrol",
          shape = "polyline",
          x = 280.667,
          y = -48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -72.6667, y = 128 }
          },
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
          id = 274,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 224,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 281,
          name = "1",
          type = "Scout",
          shape = "polyline",
          x = -22.6667,
          y = 49.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 374, y = 130 }
          },
          properties = {}
        },
        {
          id = 280,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 96,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 282,
          name = "1",
          type = "Scout",
          shape = "polyline",
          x = -24.6667,
          y = 232,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 378, y = -82.6667 }
          },
          properties = {}
        },
        {
          id = 285,
          name = "1",
          type = "Scout",
          shape = "polyline",
          x = -26.6667,
          y = 159.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 367.333, y = -104 }
          },
          properties = {}
        },
        {
          id = 286,
          name = "1",
          type = "Scout",
          shape = "polyline",
          x = 354.667,
          y = 205.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -392, y = -86 }
          },
          properties = {}
        },
        {
          id = 287,
          name = "3",
          type = "Mine",
          shape = "rectangle",
          x = 160,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 288,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 78,
          y = -38.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 256 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 289,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 244.667,
          y = -40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 256 },
            { x = 0, y = 544 }
          },
          properties = {}
        }
      }
    }
  }
}
