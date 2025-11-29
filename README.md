# Scan-Drivers:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) : ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Discription](https://github.com/user-attachments/assets/4a778202-1072-463a-bfa3-842226e300af) &nbsp;&nbsp;: ![Scan Drivers](https://github.com/user-attachments/assets/de9eb1ae-f59f-4490-aa16-f995acfeb9a0)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) &nbsp;: ![112025](https://github.com/user-attachments/assets/6c049038-ad2c-4fe3-9b7e-1ca8154910c2)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)

</br>

A dynamic-link library (DLL) is a [shared library](https://en.wikipedia.org/wiki/Shared_library) in the Microsoft Windows or OS/2 operating system. A DLL can contain [executable code](https://en.wikipedia.org/wiki/Executable) (functions), data, and resources.

A DLL file often has file extension .dll even though this is not required. The extension is sometimes used to describe the content of the file. For example, .ocx is a common extension for an ActiveX control and .drv for a legacy (16-bit) device driver.

A DLL that contains only resources can be called a resource DLL. Examples include an icon library, with common extension .icl, and a font library with common extensions .fon and .fot.

The file format of a DLL is the same as for an executable (a.k.a. EXE). The main difference between a DLL file and an EXE file is that a DLL cannot be run directly since the operating system requires an [entry point](https://en.wikipedia.org/wiki/Entry_point) to start execution. Windows provides a utility program ```(RUNDLL.EXE/RUNDLL32.EXE)``` to execute a function exposed by a DLL. Since they have the same format, an EXE can be used as a DLL. Consuming code can load an EXE via the same mechanism as loading a DLL.

This program demonstrates how to read the functions of a driver file and execute them with a parameter. For this to work, the execution and the driver must be located in the same folder. The advantage is that very little code is needed to, for example, address the entire Windows environment. In this case, it's the RunDll32.exe and the Shell32.dll files.

</br>

![ScanDrivers](https://github.com/user-attachments/assets/7cd1a395-0569-46bd-8d53-091c30d99f8a)

</br>

The program contains 30 examples of how to start the functions. By extending the parameters, the respective actions can be performed. For example, to start the network environment, only one line of code is needed:

```pascal
Rundll32.exe shell32.dll,Control_RunDLL ncpa.cpl
```

The program no longer needs to search for its target, but starts it directly from the driver file and can access the environment.

# Examples:

| function | command | 
| :------------ | :------------ | 
| Launch the About Windows screen     | ```Rundll32.exe shell32.dll,ShellAbout```     |
| Launch the Forgotten Password Wizard     | ```Rundll32.exe keymgr.dll,PRShowSaveWizardExW```     |
| Force execute pending idle tasks     | ```Rundll32.exe advapi32.dll,ProcessIdleTasks```     |
| Set Program Access and Computer Defaults     | ```Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,3```     |
|View Windows Features     | ```Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,2```     |
| Go to System Properties – Computer Name tab     | ```Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,1```     |
|Go to System Properties – Hardware tab     | ```Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,2```     |
| Go to System Properties – Advanced tab     | ```Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,3```     |
| Go to System Properties – System Protection tab     | ```Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,4```     |
| Go to System Properties – Remote tab     | ```Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,5```     |
| Open list of User Accounts     | ```Rundll32.exe shell32.dll,Control_RunDLL nusrmgr.cpl```     |

</br>

To modify the respective environment, only the parameter for the required function needs to be extended. In practice, the program lets Windows work for itself without requiring much programming.

You can also test the parameters manually in the Windows console by simply entering them, such as:

### Run rundll32 from the Run dialog:
* Press the Windows key + R.
* Type a command (e.g., ```rundll32.exe shell32.dll,Control_RunDLL``` to open the control panel).
* Hit Enter.




