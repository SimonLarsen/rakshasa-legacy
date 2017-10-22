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
  nextobjectid = 130,
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
          id = 16,
          name = "0",
          type = "Drone",
          shape = "polyline",
          x = -33.3333,
          y = 104,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 387.333, y = 1.33333 }
          },
          properties = {}
        },
        {
          id = 8,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 125.5,
          y = 289,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "2",
          type = "Turret",
          shape = "rectangle",
          x = 273,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = 352,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384, y = 0 }
          },
          properties = {}
        },
        {
          id = 10,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 50.5,
          y = 203.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "2",
          type = "Turret",
          shape = "rectangle",
          x = 198.5,
          y = 171,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = -32,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 387.333, y = 0 },
            { x = 2, y = 3.33333 }
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
          id = 22,
          name = "1",
          type = "Bunker",
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
          id = 23,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 128,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false
          }
        },
        {
          id = 24,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 192,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shoot"] = false
          }
        },
        {
          id = 27,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 96,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 224,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "2",
          type = "LaserTurret",
          shape = "rectangle",
          x = 64,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "2",
          type = "LaserTurret",
          shape = "rectangle",
          x = 256,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "2.5",
          type = "LaserTurret",
          shape = "rectangle",
          x = 96,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "2",
          type = "LaserTurret",
          shape = "rectangle",
          x = 224,
          y = 80,
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
      name = "3",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 32,
          name = "0",
          type = "Patrol",
          shape = "polyline",
          x = -46.6667,
          y = -40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 20, y = 18 },
            { x = 123.333, y = 172.667 }
          },
          properties = {}
        },
        {
          id = 33,
          name = "0.5",
          type = "Patrol",
          shape = "polyline",
          x = 25.3333,
          y = -55.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -45.3333, y = 19.3333 },
            { x = 148.667, y = 154 }
          },
          properties = {}
        },
        {
          id = 34,
          name = "0.5",
          type = "Patrol",
          shape = "polyline",
          x = 148,
          y = -66,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -98, y = 31.3333 },
            { x = 116.667, y = 127.333 }
          },
          properties = {}
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
          id = 35,
          name = "1",
          type = "Striker",
          shape = "polyline",
          x = 80,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 104.667 },
            { x = -0.666667, y = 239.333 },
            { x = 0.666667, y = 553.333 }
          },
          properties = {}
        },
        {
          id = 46,
          name = "1.3",
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
            { x = 0, y = 104.667 },
            { x = -0.666667, y = 239.333 },
            { x = 0.666667, y = 553.333 }
          },
          properties = {}
        },
        {
          id = 47,
          name = "1.3",
          type = "Striker",
          shape = "polyline",
          x = 240,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 104.667 },
            { x = -0.666667, y = 239.333 },
            { x = 0.666667, y = 553.333 }
          },
          properties = {}
        },
        {
          id = 68,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 272,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 71,
          name = "0.3",
          type = "Bunker",
          shape = "rectangle",
          x = 110,
          y = 257,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 73,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 210,
          y = 257,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "0.54",
          type = "Bunker",
          shape = "rectangle",
          x = 72,
          y = 230,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 75,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 248,
          y = 230,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "0.7",
          type = "Bunker",
          shape = "rectangle",
          x = 50,
          y = 195,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 270,
          y = 195,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 79,
          name = "1",
          type = "SuperMine",
          shape = "rectangle",
          x = 160,
          y = 224,
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
          id = 87,
          name = "0",
          type = "Drone",
          shape = "polyline",
          x = 248,
          y = -40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -290, y = 264 }
          },
          properties = {}
        },
        {
          id = 90,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = 80,
          y = -40.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 280.667, y = 260 }
          },
          properties = {}
        },
        {
          id = 88,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = -48.6667,
          y = 106,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 415.333, y = 56.6667 }
          },
          properties = {}
        },
        {
          id = 89,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = 344,
          y = 85.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 11.3333, y = -8 },
            { x = -387.333, y = 94 }
          },
          properties = {}
        },
        {
          id = 92,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 67.3333,
          y = -38,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 102.667 },
            { x = -1.33333, y = 283.333 },
            { x = -2, y = 556 }
          },
          properties = {}
        },
        {
          id = 93,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 255.333,
          y = -38.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 102.667 },
            { x = -1.33333, y = 283.333 },
            { x = -2, y = 556 }
          },
          properties = {}
        },
        {
          id = 94,
          name = "1",
          type = "Temple",
          shape = "rectangle",
          x = 160,
          y = 112,
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
      name = "6",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 96,
          name = "0",
          type = "SuperMine",
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
          id = 104,
          name = "1",
          type = "Patrol",
          shape = "polyline",
          x = -12,
          y = -54,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 92, y = 134 }
          },
          properties = {}
        },
        {
          id = 105,
          name = "1",
          type = "Patrol",
          shape = "polyline",
          x = 338,
          y = -49.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -98, y = 129.333 }
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
          id = 106,
          name = "0",
          type = "LaserTurret",
          shape = "rectangle",
          x = 160,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 111,
          name = "0.75",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384, y = 0 }
          },
          properties = {
            ["count"] = 4,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 112,
          name = "0.75",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -384, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {
            ["count"] = 4,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 113,
          name = "0.75",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384, y = 0 }
          },
          properties = {
            ["count"] = 4,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 115,
          name = "0.75",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -384, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {
            ["count"] = 4,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
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
          id = 128,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 256 },
            { x = -192, y = 256 }
          },
          properties = {
            ["count"] = 2,
            ["delay"] = 0.4,
            ["type"] = "Scout"
          }
        },
        {
          id = 129,
          name = "0.2",
          type = "Spawner",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 256 },
            { x = 192, y = 256 }
          },
          properties = {
            ["count"] = 2,
            ["delay"] = 0.4,
            ["type"] = "Scout"
          }
        },
        {
          id = 118,
          name = "1",
          type = "Patrol",
          shape = "polyline",
          x = -62,
          y = -48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 22.6667, y = 12 },
            { x = 158, y = 112 }
          },
          properties = {}
        },
        {
          id = 119,
          name = "0.25",
          type = "Patrol",
          shape = "polyline",
          x = 391.333,
          y = -45.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -28, y = 10 },
            { x = -167.333, y = 109.333 }
          },
          properties = {}
        },
        {
          id = 120,
          name = "1.5",
          type = "Patrol",
          shape = "polyline",
          x = -65.3333,
          y = 64.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 10.6667, y = -8 },
            { x = 113.333, y = 95.3333 }
          },
          properties = {}
        },
        {
          id = 121,
          name = "0.5",
          type = "Patrol",
          shape = "polyline",
          x = 386.667,
          y = 76,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -24, y = -16.6667 },
            { x = -130.667, y = 84 }
          },
          properties = {}
        },
        {
          id = 127,
          name = "1",
          type = "Spawner",
          shape = "polyline",
          x = 368,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -16, y = 0 },
            { x = -400, y = 0 }
          },
          properties = {
            ["count"] = 4,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
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
          id = 116,
          name = "0",
          type = "Falcon",
          shape = "rectangle",
          x = 160,
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
