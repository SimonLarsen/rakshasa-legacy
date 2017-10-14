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
  nextobjectid = 135,
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
          id = 35,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 16,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 80, y = 0 }
          },
          properties = {}
        },
        {
          id = 36,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 304,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -80, y = 0 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "2",
          type = "Silo",
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
          properties = {
            ["speed"] = 140
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
          id = 14,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 128,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -16, y = 0 },
            { x = 80, y = 0 }
          },
          properties = {}
        },
        {
          id = 16,
          name = "0.2",
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
            { x = 0, y = 128 },
            { x = 0, y = 240 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 15,
          name = "0.1",
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
            { x = 0, y = 128 },
            { x = 0, y = 240 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 17,
          name = "2.7",
          type = "Laser",
          shape = "polyline",
          x = 16,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 72.5455, y = -0.181818 }
          },
          properties = {}
        },
        {
          id = 18,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 304,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -71.8913, y = 0.00543478 }
          },
          properties = {}
        },
        {
          id = 25,
          name = "1",
          type = "Bunker",
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
          id = 26,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 192,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "1",
          type = "Turret",
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
          id = 56,
          name = "0",
          type = "LaserTurret",
          shape = "rectangle",
          x = 160,
          y = 96,
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
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 66,
          name = "0",
          type = "Drone",
          shape = "polyline",
          x = -32,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 384, y = 0 }
          },
          properties = {}
        },
        {
          id = 67,
          name = "1.5",
          type = "Drone",
          shape = "polyline",
          x = 352,
          y = 128,
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
          id = 61,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 16,
          y = 96,
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
          id = 63,
          name = "2",
          type = "LaserTurret",
          shape = "rectangle",
          x = 88,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 78,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 272,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 5.2
          }
        },
        {
          id = 79,
          name = "0.64",
          type = "Bunker",
          shape = "rectangle",
          x = 240,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 5.2
          }
        },
        {
          id = 81,
          name = "0.64",
          type = "Bunker",
          shape = "rectangle",
          x = 208,
          y = 48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["time"] = 5.2
          }
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
          id = 97,
          name = "0",
          type = "Mine",
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
          id = 90,
          name = "0.5",
          type = "Bunker",
          shape = "rectangle",
          x = 80,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 92,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 240,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 93,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 48,
          y = 224,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 94,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 272,
          y = 224,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 82,
          name = "1",
          type = "Laser",
          shape = "polyline",
          x = 174,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 48, y = -48 }
          },
          properties = {
            ["speed"] = 50
          }
        },
        {
          id = 83,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 146,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -48, y = -48 }
          },
          properties = {
            ["speed"] = 50
          }
        },
        {
          id = 86,
          name = "6",
          type = "Mine",
          shape = "rectangle",
          x = 160,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = 50
          }
        },
        {
          id = 99,
          name = "1",
          type = "Patrol",
          shape = "polyline",
          x = -26,
          y = -27.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -6, y = -4.5 },
            { x = 106, y = 107.5 }
          },
          properties = {}
        },
        {
          id = 100,
          name = "2.5",
          type = "Patrol",
          shape = "polyline",
          x = 352,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -112, y = 112 }
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
          id = 133,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = -32,
          y = 144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 384, y = 0 }
          },
          properties = {
            ["count"] = 3,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 126,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 64,
          y = 384,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = 50
          }
        },
        {
          id = 111,
          name = "1.0",
          type = "Laser",
          shape = "polyline",
          x = 64,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -48, y = 48 },
            { x = 64, y = -64 }
          },
          properties = {
            ["speed"] = 50
          }
        },
        {
          id = 116,
          name = "2",
          type = "Turret",
          shape = "rectangle",
          x = 240,
          y = 304,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = 50
          }
        },
        {
          id = 113,
          name = "2.5",
          type = "Laser",
          shape = "polyline",
          x = 272,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 32, y = 32 },
            { x = -64, y = -64 }
          },
          properties = {
            ["speed"] = 50
          }
        },
        {
          id = 134,
          name = "2.2",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384, y = 0 }
          },
          properties = {
            ["count"] = 3,
            ["delay"] = 0.2,
            ["type"] = "Scout"
          }
        },
        {
          id = 127,
          name = "0.8",
          type = "Bunker",
          shape = "rectangle",
          x = 80,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 128,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 48,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 129,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 112,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 124,
          name = "3",
          type = "LaserTurret",
          shape = "rectangle",
          x = 80,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 130,
          name = "3",
          type = "Drone",
          shape = "polyline",
          x = 352,
          y = 160,
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
          id = 131,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = 352,
          y = 128,
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
          id = 132,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = 352,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384, y = 0 }
          },
          properties = {}
        }
      }
    }
  }
}
