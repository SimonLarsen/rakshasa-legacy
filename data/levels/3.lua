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
  nextobjectid = 13,
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
    }
  }
}
