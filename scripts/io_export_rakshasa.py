import bpy
from bpy.props import *

bl_info = {
    "name": "Export Rakshasa wire model format (.rwm)",
    "author": "Simon Jonas Larsen",
    "version": (0.1),
    "blender": (2, 78, 0),
    "location": "File > Export > Rakshasa wire model (*.rwm)",
    "description": "Export Rakshasa wire model",
    "warning": "",
    "category": "Import-Export"
}

def save_rwm(o, path):
    verts = o.data.vertices

    f = open(path, "w")
    for e in o.data.edges:
        v1 = verts[e.vertices[0]].co
        v2 = verts[e.vertices[1]].co
        f.write("{}\t{}\t{}\t{}\t{}\t{}\n".format(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z))
    f.close()

class ExportRWM(bpy.types.Operator):
    bl_idname = "export.rwm"
    bl_label = "Export Rakshasa wire model"

    filepath = StringProperty(name="File Path", description="Filepath for exporting", maxlen=1024, default="")

    def execute(self, context):
        save_rwm(context.object, self.properties.filepath)
        return {"FINISHED"}

    def invoke(self, context, event):
        self.filepath = ""
        wm = context.window_manager
        wm.fileselect_add(self)
        return {"RUNNING_MODAL"}

def menu_func(self, context):
    self.layout.operator(ExportRWM.bl_idname, text="Export Rakshasa wire model (.rwm)", icon="EXPORT")

def register():
    bpy.utils.register_class(ExportRWM)
    bpy.types.INFO_MT_file_export.append(menu_func)

def unregister():
    bpy.utils.unregister_class(ExportRWM)
    bpy.types.INFO_MT_file_export.remove(menu_func)

if __name__ == "__main__":
    register()
