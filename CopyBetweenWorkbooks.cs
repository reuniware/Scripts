using System;
using System.Windows.Forms;
using Excel = Microsoft.Office.Interop.Excel;

// https://ichimoku-expert.blogspot.com

// C:\Program Files (x86)\Microsoft Visual Studio\Shared\Visual Studio Tools for Office\PIA\Office15\Microsoft.Office.Interop.Excel.dll
// Version : 15.0.0.0
// Version Runtime : v2.0.50727

namespace CopyBetweenWorkbooks
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Application.ApplicationExit += new EventHandler(this.OnApplicationExit);
        }

        Excel.Application excelApp = null;
        private void OnApplicationExit(object sender, EventArgs e)
        {            
            excelApp.Quit();
        }

        String pathSRC = @"Z:\mysourcefile.xlsm";
        String pathDST = @"Z:\mydestfile.xlsm";

        Excel.Workbook workbookSRC = null;
        Excel.Workbook workbookDST = null;
        Excel.Worksheet worksheetSRC = null;
        Excel.Worksheet worksheetDST = null;
        private void btnCopy_Click(object sender, EventArgs e)
        {
            if (excelApp == null) excelApp = new Excel.Application();

            if (workbookSRC == null) workbookSRC = excelApp.Workbooks.Open(pathSRC);
            if (workbookDST == null) workbookDST = excelApp.Workbooks.Open(pathDST);

            if (worksheetSRC == null) worksheetSRC = workbookSRC.Sheets["Donnees"];
            if (worksheetDST == null) worksheetDST = workbookDST.Sheets["Donnees"];

            Object missing = Type.Missing;

            worksheetSRC.Range["A1:E18"].Copy(missing); // Specify range to copy from
            worksheetDST.Range["A1:E18"].PasteSpecial(); // Specify range to copy to

            workbookDST.Save();
            workbookDST.Close();

            workbookSRC.Close(false, missing, missing);
        }
    }
}

