"""Common functions used throughout the project."""

import Scripts.GlobalVariables as GVars
import os
import subprocess

# for hiding the cmd window on windows
si = None
if (GVars.iow):
    si = subprocess.STARTUPINFO()
    si.dwFlags |= subprocess.STARTF_USESHOWWINDOW

def NormalizePath(path: str) -> str:
    """Normalizes the given path

    Parameters
    ----------
    path : str

    Returns
    -------
    str
        A path that's compatible by the OS
    """

    if (GVars.iol) or (GVars.iosd):
        path = path.replace("~", os.path.expanduser("~"))

    return os.path.normpath(path)

def DeleteFolder(path: str) -> None:
    """Deletes folder using OS specific commands

    Parameters
    ----------
    path : str
        folder path
    """

    if (GVars.iow):
        subprocess.call("cmd /c rmdir /s /q \"" + path + "\"", startupinfo=si)
    elif (GVars.iol) or (GVars.iosd):
        os.system("rm -rf \"" + path + "\"")


def CopyFolder(src: str, dst: str) -> str:
    """Copies folder using OS specific commands

    Parameters
    ----------
    src : str
        original folder path
    dst : str
        the destination to copy the folder to

    Returns
    -------
    str
        path copied to.
    """

    if (GVars.iow):
        subprocess.call("cmd /c xcopy /E /H /C /I /Y \"" + src + "\" \"" + dst + "\"", startupinfo=si)
    elif (GVars.iol) or (GVars.iosd):
        os.system("cp -r \"" + src + "\" \"" + dst + "\"")
    return dst


def DeleteFile(path: str) -> None:
    """Deletes a file using OS specific commands

    Parameters
    ----------
    path : str
        file path
    """

    if (GVars.iow):
        subprocess.call("cmd /c Del \"" + path + "\"", startupinfo=si)
    elif (GVars.iol) or (GVars.iosd):
        os.system("rm \"" + path + "\"")

# Copies a file using the OSes copy command
def CopyFile(src: str, dst: str) -> str:
    """Copies file using OS specific commands

    Parameters
    ----------
    src : str
        original file path
    dst : str
        the destination to copy the file to

    Returns
    -------
    str
        dst
    """

    if (GVars.iow):
        subprocess.call("cmd /c copy \"" + src + "\" \"" + dst + "\"", startupinfo=si)
    elif (GVars.iol) or (GVars.iosd):
        os.system("cp \"" + src + "\" \"" + dst + "\"")
    return dst

def MoveFile(src: str, dst: str) -> str:
    """Moves file using OS specific commands

    Parameters
    ----------
    src : str
        original file path
    dst : str
        path to move the file to

    Returns
    -------
    str
        dst
    """

    if (GVars.iow):
        subprocess.call("cmd /c move \"" + src + "\" \"" + dst + "\"", startupinfo=si)
    elif (GVars.iol) or (GVars.iosd):
        os.system("mv \"" + src + "\" \"" + dst + "\"")
    return dst

def CheckForClipboardCommandsLinux() -> bool:
    """Check if xclip (X11) or wl-clipboard (Wayland) exists on the Linux system.

    Returns
    -------
    bool
        Whether or not the systems clipboard commands are available.
    """

    # Simply call the clipboard command associated with the systems windowing system to see if it exists
    if GVars.linuxSessionType == "x11":
        try:
            subprocess.call(["xclip", ""])
        except:
            return False
    else:
        try:
            subprocess.call(["wl-copy", ""])
            subprocess.call(["wl-paste", ""])
        except:
            return False
    return True

def ClipboardOperation(data: str | None = None, copy: bool = True) -> str | bool:
    """Perform copy or pasting operations with the systems clipboard.

    Parameters
    ----------
    data (optional): str | None
        Data to be copied to the systems clipboard. Defaults to None when clipboard data is to be pasted instead.

    copy (optional): bool
        Whether to copy to the clipboard, or whether to paste. Defaults to True.

    Returns
    -------
    str | bool
        Data that was taken from the clipboard
        in order to be pasted into the Input Prompt.

        Will return False if pasting or copying fails.
    """

    if (GVars.iol or GVars.iosd) and (not CheckForClipboardCommandsLinux()):
        return False

    # Remove any \r and \n characters and trailing spaces from the received data
    if data is not None: data = data.replace("\r", "").replace("\n", "").strip()

    if (GVars.iol or GVars.iosd):
        if copy:
            # Copying operations
            copyCMD = ["xclip", "-selection", "c"] if GVars.linuxSessionType == "x11" else ["wl-copy", "-n", "-p"]
            
            # Copy text to the clipboard
            subprocess.Popen(copyCMD, stdin=subprocess.PIPE, stdout=None, text=True, shell=False).communicate(input=data)
            return True
        else:
            # Pasting operations
            pasteCMD = ["xclip", "-selection", "clipboard", "-o"] if GVars.linuxSessionType == "x11" else ["wl-paste", "-n", "-p"]
            
            # Paste text from the clipboard
            pasteProcess = subprocess.Popen(pasteCMD, stdin=None, stdout=subprocess.PIPE, shell=False)
            return str(pasteProcess.stdout.read().decode().replace("\r", "").replace("\n", "").strip())
    else:
        # Windows clipboard operations
        if copy:
            # Copy text to the clipboard
            subprocess.Popen(["clip"], stdin=subprocess.PIPE, stdout=None, text=True, shell=False).communicate(input=data)
            return True
        else:
            # Paste text from the clipboard
            pasteProcess = subprocess.Popen(["powershell", "get-clipboard"], stdin=None, stdout=subprocess.PIPE, shell=False)
            return str(pasteProcess.stdout.read().decode().replace("\r", "").replace("\n", "").strip())

def TryFindPortal2Path() -> str | bool:
    """Attempts to find the game's path mainly on windows

    Returns
    -------
    str | bool
        path to the game if found / false if it doesn't exist
    """

    if (GVars.iol or GVars.iosd):
        # Should be default linux path for the game
        defaultLinuxPath = NormalizePath("~/.local/share/Steam/steamapps/common/Portal 2")

        if (os.path.isfile(defaultLinuxPath + "/portal2_linux")):
            return defaultLinuxPath

    if (GVars.iow):
        import winreg
        try:
            hkey = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\Valve\Steam")
            steamPath = winreg.QueryValueEx(hkey, "InstallPath")
            manifestPath = steamPath[0] + NormalizePath("/steamapps/libraryfolders.vdf")
            if GVars.configData["Dev-Mode"]["value"]:
                print(hkey)
                print(steamPath)
                print(manifestPath)

            if (os.path.isfile(manifestPath)):
                # read the manifest file
                manifest = open(manifestPath, "r", encoding="utf-8").readlines()
                paths = []

                for line in manifest:
                    line = line.strip()
                    # remove the quotes
                    line = line.replace("\"", "")
                    if GVars.configData["Dev-Mode"]["value"]: print(line)
                    if (line.startswith("path")):
                        line = line.replace("path", "")
                        line = line.strip()
                        paths.append(line)

                for path in paths:
                    if GVars.configData["Dev-Mode"]["value"]: print(path)
                    if (os.path.isdir(path + NormalizePath("/steamapps/common/Portal 2"))):
                        return path + NormalizePath("/steamapps/common/Portal 2")

        except Exception as e:
            print("ERROR: " + str(e))

    return False

def StringToParagraph(text: str, length: int) -> list[str]:
    """formats a string to a paragraph like text

    Parameters
    ----------
    text : str
        text to format
    length : int
        how many characters can be in 1 line

    Returns
    -------
    str
        formatted text
    """

    words = text.split(" ")
    lines : list[str] = []
    line : str= ""
    currentLineLength = 0

    for i in range(len(words)):
        line += words[i] + " "
        currentLineLength += len(words[i]) +1

        if (currentLineLength + len(words[i])) > length:
            currentLineLength = 0
            lines.append(line)
            line = ""

    return lines

def GetAvailableLanguages() -> list[str]:
    """Returns a list of all available languages

    Returns
    -------
    list[str]
        a list with the file names of available languages
    """

    langs = []

    for file in os.listdir("Languages"):
        langs.append(file[:-5])

    if os.path.exists(GVars.modPath + os.sep + "Languages"):
        for file in os.listdir(GVars.modPath + os.sep + "Languages"):
            langs.append(file[:-5])

    return langs
