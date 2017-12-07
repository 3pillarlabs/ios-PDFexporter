//
//  Utils.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import Foundation
import PDFExporter

struct Utils {
    static func getDocumentsDirectory() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }

    static func getPdfFileUrl() -> URL? {
        return Utils.getDocumentsDirectory()?.appendingPathComponent(Constants.pdfDefaultName)
    }

    static func allPaperTypes() -> [PaperType] {
        var allPaperTypes = [PaperType]()
        var paperType = PaperType(name: "US Letter", size: PDFPaperSizeUSLetter)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "US Government Letter", size: PDFPaperSizeUSGovernmentLetter)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "US Legal", size: PDFPaperSizeUSLegal)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "US Junior Legal", size: PDFPaperSizeUSJuniorLegal)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "US Ledger", size: PDFPaperSizeUSLedger)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "US Tabloid", size: PDFPaperSizeUSTabloid)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "US Executive", size: PDFPaperSizeUSExecutive)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Crown Quatro", size: PDFPaperSizeUKMetricCrownQuatro)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Crown Octavo", size: PDFPaperSizeUKMetricCrownOctavo)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Lager Crown Quatro", size: PDFPaperSizeUKMetricLargeCrownQuatro)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Lager Crown Octavo", size: PDFPaperSizeUKMetricLargeCrownOctavo)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Demy Quatro", size: PDFPaperSizeUKMetricDemyQuatro)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Demy Octavo", size: PDFPaperSizeUKMetricDemyOctavo)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Royal Quatro", size: PDFPaperSizeUKMetricRoyalQuatro)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "UK Metric Royal Octavo", size: PDFPaperSizeUKMetricRoyalOctavo)

        allPaperTypes.append(paperType)
        paperType = PaperType(name: "English Small Royal", size: PDFPaperSizeEnglishSmallRoyal)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "English Royal", size: PDFPaperSizeEnglishRoyal)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "English Imperial", size: PDFPaperSizeEnglishImperial)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A0", size: PDFPaperSizeISOA0)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A1", size: PDFPaperSizeISOA1)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A2", size: PDFPaperSizeISOA2)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A3", size: PDFPaperSizeISOA3)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A4", size: PDFPaperSizeISOA4)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A5", size: PDFPaperSizeISOA5)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A6", size: PDFPaperSizeISOA6)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A7", size: PDFPaperSizeISOA7)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO A8", size: PDFPaperSizeISOA8)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B0", size: PDFPaperSizeISOB0)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B1", size: PDFPaperSizeISOB1)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B2", size: PDFPaperSizeISOB2)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B3", size: PDFPaperSizeISOB3)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B4", size: PDFPaperSizeISOB4)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B5", size: PDFPaperSizeISOB5)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B6", size: PDFPaperSizeISOB6)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B7", size: PDFPaperSizeISOB7)

        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B8", size: PDFPaperSizeISOB8)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B9", size: PDFPaperSizeISOB9)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "ISO B10", size: PDFPaperSizeISOB10)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "News Midi", size: PDFPaperSizeNewsMidi)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "News Broadsheet", size: PDFPaperSizeNewsBroadsheet)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "News Tabloid", size: PDFPaperSizeNewsTabloid)
        allPaperTypes.append(paperType)
        paperType = PaperType(name: "News Rhenish", size: PDFPaperSizeNewsRhenish)
        allPaperTypes.append(paperType)

        return allPaperTypes
    }
}
