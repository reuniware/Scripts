// GDITest.cpp : définit le point d'entrée pour l'application console.
//

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
      
			// Démarrer le job d'impression

			DOC_INFO_1 psDocInfo1 = { 0 };
			psDocInfo1.pDocName = (LPTSTR)L"My document name"; // When used with PDF Creator printer then that will be the document name in the PDF Creator form
			psDocInfo1.pDatatype = (LPWSTR)L"TEXT";

			if (StartDocPrinter(hdl, 1, (LPBYTE)&psDocInfo1) != 0) {
				cout << "StartDocPrinter ok" << endl;

				wchar_t* str = (wchar_t*)"test"; // The text that is printed is defined here
				DWORD pcWritten;
				WritePrinter(hdl, str, 4, &pcWritten); // A pointer to the text to print and the size of the text to print are defined here

				EndDocPrinter(hdl);
			}
			else {
				cout << "StartDocPrinter error : ";
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

