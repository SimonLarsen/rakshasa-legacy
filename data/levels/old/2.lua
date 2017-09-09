return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.17.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 30,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 152,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "1",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 130,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 74,
          y = -18.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 6, y = -13.3333 },
            { x = 6, y = 242.667 },
            { x = 278, y = 242.667 }
          },
          properties = {
            ["count"] = 5,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 129,
          name = "1",
          type = "Spawner",
          shape = "polyline",
          x = 256.667,
          y = -20.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -0.667, y = -11.3333 },
            { x = -0.667, y = 164.667 },
            { x = -288.667, y = 164.667 }
          },
          properties = {
            ["count"] = 5,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 13,
          name = "1",
          type = "Temple",
          shape = "rectangle",
          x = 159.333,
          y = 78.6667,
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
      name = "2",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 15,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 342.667,
          y = 130,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -6.667, y = -2 },
            { x = -358.667, y = -2 }
          },
          properties = {
            ["count"] = 4,
            ["delay"] = 0.3,
            ["type"] = "Drone"
          }
        },
        {
          id = 17,
          name = "2",
          type = "Mine",
          shape = "rectangle",
          x = 216,
          y = 231.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "1",
          type = "Mine",
          shape = "rectangle",
          x = 103.333,
          y = 230.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "4",
          type = "Fighter",
          shape = "polyline",
          x = 25.3333,
          y = -16.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 336 },
            { x = 0, y = 512 }
          },
          properties = {}
        },
        {
          id = 20,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 296,
          y = -17.3334,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 336 },
            { x = 0, y = 512 }
          },
          properties = {}
        },
        {
          id = 21,
          name = "2",
          type = "Fighter",
          shape = "polyline",
          x = 80,
          y = -20,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 336 },
            { x = 0, y = 512 }
          },
          properties = {}
        },
        {
          id = 22,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 240.667,
          y = -18.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 336 },
            { x = 0, y = 512 }
          },
          properties = {}
        },
        {
          id = 23,
          name = "2",
          type = "Fighter",
          shape = "polyline",
          x = 128.667,
          y = -16.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 336 },
            { x = 0, y = 512 }
          },
          properties = {}
        },
        {
          id = 24,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 192.167,
          y = -15.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 112 },
            { x = 0, y = 336 },
            { x = 0, y = 512 }
          },
          properties = {}
        },
        {
          id = 133,
          name = "1",
          type = "Bomber",
          shape = "polyline",
          x = 160,
          y = -23.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 103.333 },
            { x = 0, y = 231.333 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "3",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 25,
          name = "0",
          type = "Drone",
          shape = "polyline",
          x = 335.333,
          y = 178,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -350, y = -0.666667 }
          },
          properties = {}
        },
        {
          id = 26,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = -12.6667,
          y = 134,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 347.333, y = 0 }
          },
          properties = {}
        },
        {
          id = 28,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = 336.667,
          y = 90,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -355.333, y = -1.33333 }
          },
          properties = {}
        },
        {
          id = 29,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = -16.6667,
          y = 42,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 358, y = 1.33333 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "2",
          type = "Temple",
          shape = "rectangle",
          x = 160,
          y = 88,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 71.3333,
          y = 168,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 247.333,
          y = 167.333,
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
      name = "4",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 38,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 16,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 144, y = 0 }
          },
          properties = {}
        },
        {
          id = 108,
          name = "3",
          type = "Drone",
          shape = "polyline",
          x = 352,
          y = 144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -384, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          id = 39,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 176,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 128, y = 0 }
          },
          properties = {}
        },
        {
          id = 110,
          name = "3",
          type = "Drone",
          shape = "polyline",
          x = 352,
          y = 162,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = -26.6667 },
            { x = -384, y = -26.6667 }
          },
          properties = {}
        },
        {
          id = 44,
          name = "3",
          type = "Fighter",
          shape = "polyline",
          x = 237.333,
          y = -14.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 106 },
            { x = 1.33333, y = 248 },
            { x = -0.666667, y = 514 }
          },
          properties = {}
        },
        {
          id = 46,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 158.667,
          y = -16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 106 },
            { x = 1.33333, y = 248 },
            { x = -0.666667, y = 514 }
          },
          properties = {}
        },
        {
          id = 134,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 72.6667,
          y = -17.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 106 },
            { x = 1.33333, y = 248 },
            { x = -0.666667, y = 514 }
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
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 66,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 64,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 112,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 69,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 208,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 256,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "2",
          type = "Mine",
          shape = "rectangle",
          x = 160,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 142,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 288,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 143,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 232.667,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 141,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 88.6667,
          y = 240.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 140,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 32,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 79,
          name = "3",
          type = "Bunker",
          shape = "rectangle",
          x = 256,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 82,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 64,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 83,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 112,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 80,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 208,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 85,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 138,
          name = "1",
          type = "Spawner",
          shape = "polyline",
          x = -16,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 352, y = 0 }
          },
          properties = {
            ["count"] = 3,
            ["delay"] = 0.3,
            ["type"] = "Drone"
          }
        },
        {
          id = 148,
          name = "3",
          type = "Turret",
          shape = "rectangle",
          x = 80,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 149,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 240,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 151,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 158.667,
          y = -28.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 99.3333 },
            { x = -0.666667, y = 250 },
            { x = 2, y = 526 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "6",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 113,
          name = "0",
          type = "LaserFan",
          shape = "polyline",
          x = 8,
          y = -23.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 135.5, y = 0.25 }
          },
          properties = {
            ["rotation_speed"] = -1
          }
        },
        {
          id = 115,
          name = "0",
          type = "LaserFan",
          shape = "polyline",
          x = 151.333,
          y = -23.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 26.5, y = 0 },
            { x = 160, y = 0 }
          },
          properties = {
            ["rotation_speed"] = 1
          }
        },
        {
          id = 118,
          name = "5",
          type = "Bunker",
          shape = "rectangle",
          x = 161.333,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 119,
          name = "2",
          type = "Bunker",
          shape = "rectangle",
          x = 80,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 120,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 240,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 121,
          name = "4",
          type = "LaserFan",
          shape = "polyline",
          x = 16.5,
          y = -29,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 176, y = 0 }
          },
          properties = {
            ["rotation_speed"] = -1
          }
        },
        {
          id = 127,
          name = "2",
          type = "Fighter",
          shape = "polyline",
          x = 241.5,
          y = -30.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 82.5 },
            { x = -0.333333, y = 241.167 },
            { x = -1.66667, y = 524.5 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "7",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 117,
          name = "0",
          type = "ProximityMine",
          shape = "rectangle",
          x = 180,
          y = 90,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["radius"] = 64
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "boss",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 104,
          name = "0",
          type = "Fear",
          shape = "rectangle",
          x = 160,
          y = 81,
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
