// XpsPrint.cpp : définit le point d'entrée pour l'application console.
// Prior to launching this program, set XPS Printer as default printer in system settings.
// This prints a little rectangle to the XPS file.

#include "stdafx.h"
#include "Windows.h"
#include <string>
#include <iostream>

using namespace std;

int main()
{
	HANDLE hdl;
	DEVMODE* devmode;
	wchar_t szPrinter[MAX_PATH];
	DWORD cchPrinter(ARRAYSIZE(szPrinter));
	GetDefaultPrinter(szPrinter, &cchPrinter);

	wcout << "Default printer is = " << szPrinter << endl;

	if (OpenPrinter(szPrinter, &hdl, NULL)) {
		cout << "OpenPrinter ok" << endl;

		// Avec fMode=0 (dernier paramètre) alors size vaut la taille du buffer requise pour contenir les données d'initialisation du pilote de l'imprimante
		int size = DocumentProperties(NULL, hdl, szPrinter, NULL, NULL, 0);
		//cout << "size = " << size << endl;

		// Ecrire les paramètres d'impression du pilote courant de l'imprimante (fMode = DM_OUT_BUFFER)
		devmode = (DEVMODE*)malloc(size);
		DocumentProperties(NULL, hdl, szPrinter, devmode, NULL, DM_OUT_BUFFER);

		// Créer un Device Context
		HDC printerDC = CreateDC(L"WINSPOOL", szPrinter, NULL, devmode);
		if (printerDC != NULL) {
			cout << "CreateDC ok" << endl;

			DOCINFO info;
			memset(&info, 0, sizeof(info));
			info.cbSize = sizeof(info);

			// Démarrer le job d'impression

			if (StartDoc(printerDC, &info) > 0) {
				cout << "StartDoc ok" << endl;

				if (StartPage(printerDC) > 0) {
					cout << "StartPage ok" << endl;
					if (Rectangle(printerDC, 100, 100, 200, 200) > 0) {
						cout << "Rectangle ok" << endl;
					}
					EndPage(printerDC);
				}

				EndDoc(printerDC);
			}
			else {
				cout << "StartDoc error : ";
				if (GetLastError() == 1804) {
					cout << "ERROR_INVALID_DATATYPE" << endl;
				}
				else {
					cout << GetLastError() << endl;
				}
			}

		}
		else {
			cout << "printerDC == null <=> CreateDC n'a pas réussi" << endl;
		}

		if (printerDC!=NULL) DeleteDC(printerDC);

		if (hdl!=NULL) ClosePrinter(hdl);
	}

	cout << "Fin des traitements" << endl;

	std::cin.get();
    return 0;
}

