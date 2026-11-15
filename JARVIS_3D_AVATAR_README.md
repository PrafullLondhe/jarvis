# JARVIS humanoid GLB avatar integration

## Included character
`assets/models/teen-character-rigged.glb` is the humanoid character supplied for this integration.

The GLB contains:
- 1 skinned character mesh
- 1 skin / armature with 52 joints
- Head, neck, spine, chest and pelvis
- Left/right clavicles, upper arms, forearms, hands
- Three-joint thumb, index, middle, ring and pinky chains on both hands
- Left/right thighs, shins, feet and toes

The model is already skinned to the armature. The GLB contains no pre-authored animation clips and no facial morph targets / blendshapes.

## JARVIS animation driver
The local Three.js viewer (`assets/models/viewer.html`) now loads the rigged character and applies procedural skeletal poses:
- **Idle:** subtle breathing, head sway and relaxed arms
- **Listening:** raises the right hand toward the ear and turns the head slightly toward the user
- **Thinking / processing:** head looks around and one hand moves toward the chin
- **Talking:** alternating explanatory arm/hand gestures, driven by JARVIS speaking state and audio level

`ui.py` sends the current JARVIS state and the same smoothed audio / viseme values used by the HUD to the embedded viewer through Qt WebEngine. Bone poses are interpolated in the browser's render loop.

## Facial animation limitation
This GLB has no jaw bone and no facial morph targets. The viewer is prepared to drive standard mouth-open / viseme morph targets if they are added later, but this supplied mesh cannot currently perform true 3D lip-sync or eyelid blinking. Those require a facial rig, jaw bone with suitable geometry, or blendshapes authored in Blender. The existing Python audio/viseme pipeline remains intact.

## Run
1. Extract the complete project ZIP.
2. Install the project dependencies:
   `python -m pip install -r requirements.txt`
3. Ensure `PyQt6-WebEngine` is installed (it is listed in requirements).
4. Launch JARVIS normally with internet access so Three.js can load from jsDelivr.

The viewer supports mouse drag to orbit and wheel scrolling to zoom. If the GLB fails to load, check the terminal for `[Avatar]` messages and confirm that both `assets/models/viewer.html` and `assets/models/teen-character-rigged.glb` exist.
