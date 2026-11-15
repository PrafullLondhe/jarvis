# Local Face ID

MARK LVI now includes an optional local face-enrollment feature.

## Setup

1. On Windows, double-click `FIX_FACE_ID.bat` once. It repairs OpenCV in the same Python environment used by `RUN_JARVIS.bat`.
2. Start JARVIS with `RUN_JARVIS.bat` (recommended), or run `python main.py` from the same Python environment that was repaired.
3. Choose **FACE** in the top navbar to enroll or manage faces.
3. Approve the camera permission prompt.
4. Enroll the first face. The first enrolled person is the primary owner and is named **Praful**.
5. Enroll up to four additional people by entering their names.
6. Leave **Enable face check automatically when JARVIS starts** checked if you want the camera check whenever JARVIS launches.

When startup checking is enabled, JARVIS waits for the primary face before starting the voice session. A recognized secondary face is told to ask Praful for approval; an unknown face is not granted access. If JARVIS is set to start with Windows, the face check runs when that startup entry launches JARVIS.

## Local storage

Face samples and the trained model are kept under `faces/`:
- `faces/people.json` — enrolled names and primary-owner flag
- `faces/samples/` — local face image samples
- `faces/trainer.yml` — local LBPH model
- `faces/settings.json` — whether startup face checking is enabled

Nothing in this feature uploads face samples to a server. The camera is opened after enrollment consent has been given and startup checking has been enabled.

## Important limitation

This is a convenience face-recognition gate based on OpenCV LBPH, not a certified biometric security system. Lighting, camera quality, angle, and similar-looking faces can affect recognition. Do not rely on it as the only protection for highly sensitive data or irreversible computer actions. JARVIS's existing confirmation controls should remain enabled.

## Quick registration and greeting

Use **FACE ▾** in the navbar, enter a name for an additional person, and press
**QUICK REGISTER**. Keep your face in view while the camera captures samples;
when registration and model training finish, the setup window closes. At startup,
a recognized primary owner closes the camera window, unlocks the voice session,
is greeted by name, and is left in the listening state even when wake-word mode
is enabled. Use `RUN_JARVIS.bat` after `FIX_FACE_ID.bat` so both use the same
Python installation.


## If Face ID reports cv2.face missing

Run FIX_FACE_ID.bat. It explicitly prefers the Python 3.14 installation reported in the diagnostic and removes all four conflicting OpenCV wheel variants before installing opencv-contrib-python. The repair verifies that `from cv2 import face` and `face.LBPHFaceRecognizer_create()` work. Then launch with RUN_JARVIS.bat so both scripts use the same interpreter.
