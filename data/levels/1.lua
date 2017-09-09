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
  nextobjectid = 237,
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
          id = 8,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 355.333,
          y = 126,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384.667, y = 1.33333 }
          },
          properties = {
            ["count"] = 5,
            ["delay"] = 0.25,
            ["type"] = "Scout"
          }
        },
        {
          id = 10,
          name = "2",
          type = "Spawner",
          shape = "polyline",
          x = -24.6667,
          y = 207.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 376.667, y = 0.666667 }
          },
          properties = {
            ["count"] = 5,
            ["delay"] = 0.25,
            ["type"] = "Scout"
          }
        },
        {
          id = 5,
          name = "3",
          type = "Fighter",
          shape = "polyline",
          x = 78.6667,
          y = -19.3334,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -3.33333e-07, y = 98.6666 },
            { x = 0.666667, y = 260.666 },
            { x = -1.33333, y = 515.333 }
          },
          properties = {}
        },
        {
          id = 6,
          name = "2",
          type = "Fighter",
          shape = "polyline",
          x = 243.425,
          y = -22.0151,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -3.33333e-07, y = 98.6666 },
            { x = 0.666667, y = 260.666 },
            { x = -1.33333, y = 515.333 }
          },
          properties = {}
        },
        {
          id = 13,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 161,
          y = 209.27,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 120.167,
          y = 240.77,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 203.167,
          y = 241.27,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 74.1667,
          y = 270.77,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 248.667,
          y = 270.27,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 28.1667,
          y = 308.27,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 293.167,
          y = 307.77,
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
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 32,
          name = "1",
          type = "AimedDrone",
          shape = "polyline",
          x = 350.667,
          y = 168.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -276.667, y = 0.666667 },
            { x = -277.333, y = 63.3333 }
          },
          properties = {}
        },
        {
          id = 34,
          name = "1",
          type = "AimedDrone",
          shape = "polyline",
          x = 342.003,
          y = 195.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -368.667, y = -50.6667 },
            { x = -92.3335, y = -51.6667 },
            { x = -91.3333, y = 38.6667 }
          },
          properties = {}
        },
        {
          id = 229,
          name = "2",
          type = "AimedPatrol",
          shape = "polyline",
          x = 4.66667,
          y = -48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 75.3333, y = 136.667 },
            { x = 74.6667, y = 241.333 }
          },
          properties = {}
        },
        {
          id = 230,
          name = "0",
          type = "AimedPatrol",
          shape = "polyline",
          x = 308.667,
          y = -53.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -67.3333, y = 150 },
            { x = -68.6667, y = 274 }
          },
          properties = {}
        },
        {
          id = 233,
          name = "2",
          type = "Spawner",
          shape = "polyline",
          x = -37.3333,
          y = 165.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 214.667, y = 1.33333 },
            { x = 212, y = 99.3337 },
            { x = 398.667, y = 99.9997 }
          },
          properties = {
            ["count"] = 5,
            ["delay"] = 0.25,
            ["type"] = "Scout"
          }
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
          id = 73,
          name = "0",
          type = "Mine",
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
      name = "4",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 78,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 96,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 79,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 224,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 80,
          name = "4",
          type = "Bunker",
          shape = "rectangle",
          x = 161.139,
          y = 218.742,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 89,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 33.1388,
          y = 218.742,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 90,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 289.139,
          y = 218.742,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 91,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 97.1388,
          y = 202.742,
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
          x = 225.139,
          y = 202.742,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 93,
          name = "4",
          type = "AimedDrone",
          shape = "polyline",
          x = 358,
          y = 21.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -259.333, y = 167.333 },
            { x = -266, y = 258 }
          },
          properties = {}
        },
        {
          id = 94,
          name = "1",
          type = "AimedDrone",
          shape = "polyline",
          x = -38,
          y = 22.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 272.667, y = 169.333 },
            { x = 276, y = 252.667 }
          },
          properties = {}
        },
        {
          id = 97,
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
            { x = 0, y = 96 },
            { x = 0, y = 256 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 98,
          name = "1",
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
            { x = 0, y = 96 },
            { x = 0, y = 256 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 99,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 160,
          y = -34.6667,
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
          id = 72,
          name = "0",
          type = "Drone",
          shape = "polyline",
          x = 356.667,
          y = 94.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -131.333, y = 0 },
            { x = -276.667, y = 131.333 },
            { x = -386.667, y = 128.667 }
          },
          properties = {}
        },
        {
          id = 56,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 46.8333,
          y = 241.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 102.833,
          y = 241.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 60,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 158.833,
          y = 242.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 214.833,
          y = 242.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 270.833,
          y = 242.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 103.485,
          y = 199.955,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 215,
          y = 221.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 159.333,
          y = 221.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 65,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 103.333,
          y = 221.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 47.3333,
          y = 221.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 104,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 215,
          y = 199,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 109,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 103.667,
          y = 179.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 110,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 159.667,
          y = 179.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 111,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 214.667,
          y = 179.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 112,
          name = "0.75",
          type = "Bunker",
          shape = "rectangle",
          x = 270.667,
          y = 179.667,
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
          id = 123,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 160.667,
          y = 8.16667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -48, y = -33 },
            { x = 48, y = 16 },
            { x = 64, y = 32 },
            { x = 64, y = 48 },
            { x = 48, y = 64 },
            { x = -48, y = 111 },
            { x = -64, y = 127 },
            { x = -64, y = 143 },
            { x = -48, y = 159 },
            { x = 48, y = 191 },
            { x = 64, y = 207 },
            { x = 64, y = 223 },
            { x = 48, y = 239 },
            { x = -48, y = 287 },
            { x = -64, y = 303 },
            { x = -64, y = 319 },
            { x = -48, y = 335 },
            { x = 48, y = 383 },
            { x = 64, y = 399 },
            { x = 64, y = 415 },
            { x = 48, y = 431 },
            { x = -48, y = 479 },
            { x = -64, y = 495 }
          },
          properties = {
            ["count"] = 10,
            ["delay"] = 0.18,
            ["type"] = "Scout"
          }
        },
        {
          id = 134,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = 160,
          y = 8.66667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 48, y = -33 },
            { x = -48, y = 16 },
            { x = -64, y = 32 },
            { x = -64, y = 48 },
            { x = -48, y = 64 },
            { x = 48, y = 111 },
            { x = 64, y = 127 },
            { x = 64, y = 143 },
            { x = 48, y = 159 },
            { x = -48, y = 191 },
            { x = -64, y = 207 },
            { x = -64, y = 223 },
            { x = -48, y = 239 },
            { x = 48, y = 287 },
            { x = 64, y = 303 },
            { x = 64, y = 319 },
            { x = 48, y = 335 },
            { x = -48, y = 383 },
            { x = -64, y = 399 },
            { x = -64, y = 415 },
            { x = -48, y = 431 },
            { x = 48, y = 479 },
            { x = 64, y = 495 }
          },
          properties = {
            ["count"] = 10,
            ["delay"] = 0.18,
            ["type"] = "Scout"
          }
        },
        {
          id = 137,
          name = "3",
          type = "Fighter",
          shape = "polyline",
          x = 64.6667,
          y = -27.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -0.666667, y = -2.66667 },
            { x = -0.666667, y = 93.3333 },
            { x = -2.66667, y = 236.667 },
            { x = -1.33333, y = 536 }
          },
          properties = {}
        },
        {
          id = 138,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 256.667,
          y = -29.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -0.666667, y = -2.66667 },
            { x = -0.666667, y = 93.3333 },
            { x = -2.66667, y = 236.667 },
            { x = -1.33333, y = 536 }
          },
          properties = {}
        },
        {
          id = 139,
          name = "3",
          type = "Mine",
          shape = "rectangle",
          x = 159.64,
          y = 166.042,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 140,
          name = "0.8",
          type = "Mine",
          shape = "rectangle",
          x = 159.64,
          y = 140,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 141,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 125.023,
          y = 140.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 142,
          name = "0",
          type = "Mine",
          shape = "rectangle",
          x = 194.75,
          y = 140.125,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 143,
          name = "0.8",
          type = "Mine",
          shape = "rectangle",
          x = 159.64,
          y = 112.523,
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
      name = "7",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 147,
          name = "2",
          type = "Spawner",
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
          properties = {
            ["count"] = 5,
            ["type"] = "Scout"
          }
        },
        {
          id = 151,
          name = "0.15",
          type = "Spawner",
          shape = "polyline",
          x = 352,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -384, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {
            ["count"] = 5,
            ["type"] = "Scout"
          }
        },
        {
          id = 236,
          name = "2",
          type = "AimedDrone",
          shape = "polyline",
          x = 272,
          y = 512,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = -336 },
            { x = -224, y = -80 }
          },
          properties = {}
        },
        {
          id = 234,
          name = "2",
          type = "AimedDrone",
          shape = "polyline",
          x = 48,
          y = 512,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = -336 },
            { x = 224, y = -80 }
          },
          properties = {}
        },
        {
          id = 160,
          name = "2",
          type = "AimedDrone",
          shape = "polyline",
          x = -58,
          y = 14,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 183.333, y = 98 },
            { x = 166.667, y = 180.667 }
          },
          properties = {}
        },
        {
          id = 161,
          name = "1",
          type = "AimedDrone",
          shape = "polyline",
          x = 365.333,
          y = 19.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -172.667, y = 92.6667 },
            { x = -156.667, y = 176 }
          },
          properties = {}
        },
        {
          id = 162,
          name = "2",
          type = "AimedDrone",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 176 },
            { x = 0, y = 240 }
          },
          properties = {}
        },
        {
          id = 163,
          name = "0",
          type = "AimedDrone",
          shape = "polyline",
          x = 160,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -64, y = 176 },
            { x = 0, y = 448 }
          },
          properties = {}
        },
        {
          id = 165,
          name = "0",
          type = "AimedDrone",
          shape = "polyline",
          x = 208,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -48, y = 0 },
            { x = 16, y = 176 },
            { x = -48, y = 448 }
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
          id = 198,
          name = "0",
          type = "AimedDrone",
          shape = "polyline",
          x = 320,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 32, y = -16 },
            { x = -32, y = 16 },
            { x = -32, y = 48 }
          },
          properties = {}
        },
        {
          id = 199,
          name = "0",
          type = "AimedDrone",
          shape = "polyline",
          x = 32,
          y = 16,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -64, y = -16 },
            { x = 0, y = 16 },
            { x = 0, y = 48 }
          },
          properties = {}
        },
        {
          id = 200,
          name = "1",
          type = "AimedDrone",
          shape = "polyline",
          x = 32,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -64, y = -16 },
            { x = 32, y = 32 },
            { x = 32, y = 64 }
          },
          properties = {}
        },
        {
          id = 201,
          name = "0",
          type = "AimedDrone",
          shape = "polyline",
          x = 320,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 32, y = -16 },
            { x = -64, y = 32 },
            { x = -64, y = 64 }
          },
          properties = {}
        },
        {
          id = 202,
          name = "1",
          type = "AimedDrone",
          shape = "polyline",
          x = 32,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -64, y = -16 },
            { x = 64, y = 48 },
            { x = 64, y = 80 }
          },
          properties = {}
        },
        {
          id = 203,
          name = "0",
          type = "AimedDrone",
          shape = "polyline",
          x = 320,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 32, y = -16 },
            { x = -96, y = 48 },
            { x = -96, y = 80 }
          },
          properties = {}
        },
        {
          id = 208,
          name = "1",
          type = "Fighter",
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
            { x = 0, y = 224 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 217,
          name = "1",
          type = "Mine",
          shape = "rectangle",
          x = 44,
          y = 164,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 218,
          name = "2",
          type = "Mine",
          shape = "rectangle",
          x = 202,
          y = 160.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 219,
          name = "2",
          type = "Mine",
          shape = "rectangle",
          x = 115.333,
          y = 161.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 220,
          name = "2",
          type = "Mine",
          shape = "rectangle",
          x = 275.333,
          y = 160.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 221,
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
            { x = 0, y = 224 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 222,
          name = "1.5",
          type = "Fighter",
          shape = "polyline",
          x = 112,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 224 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 223,
          name = "1.5",
          type = "Fighter",
          shape = "polyline",
          x = 208,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 96 },
            { x = 0, y = 224 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 224,
          name = "1.5",
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
            { x = 0, y = 224 },
            { x = 0, y = 544 }
          },
          properties = {}
        }
      }
    }
  }
}
