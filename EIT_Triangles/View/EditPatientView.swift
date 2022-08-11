//
//  EditPatientView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 11.08.2022.
//

import SwiftUI

struct EditPatientView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var patients: FetchedResults<Patients>
    
    var patient: FetchedResults<Patients>.Element
    
    @State private var fullname = ""
    @State private var age = ""
    @State private var eitlink = ""
    @State private var diagnosis = ""
    
    var body: some View {
        Form {
            Section {
                VStack {
                    TextField("\(patient.fullname!)", text: $fullname)
                    Divider()
                    TextField("\(patient.age!)", text: $age)
                    Divider()
                    TextField("\(patient.diagnosis!)", text: $diagnosis)
                    Divider()
                    TextField("\(patient.eitlink!)", text: $eitlink)
                }
            }
        }
    }
}

