//
//  EditPatientView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 11.08.2022.
//

import SwiftUI

struct EditPatientView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var patients: FetchedResults<Patients>.Element
    
    @State private var fullname = ""
    @State private var age = ""
    @State private var eitlink = ""
    @State private var diagnosis = ""
    
    var body: some View {
        Form {
            Section {
                VStack {
                    TextField("\(patients.fullname!)", text: $fullname)
                        .onAppear {
                            fullname = patients.fullname!
                            age = patients.age!
                            eitlink = patients.eitlink!
                            diagnosis = patients.diagnosis!
                        }
                    
                    Divider()
                    
                    TextField("\(patients.age!)", text: $age)
                        .onAppear {
                            age = patients.age!
                        }
                    
                    Divider()

                    TextField("\(patients.diagnosis!)", text: $diagnosis)
                        .onAppear {
                            diagnosis = patients.diagnosis!
                        }
                    Divider()
                    
                    TextField("\(patients.eitlink!)", text: $eitlink)
                        .onAppear {
                            eitlink = patients.eitlink!
                        }
                    
//                    Divider()
//                    TextField("\(patient.age!)", text: $age)
//                    Divider()
//                    TextField("\(patient.diagnosis!)", text: $diagnosis)
//                    Divider()
//                    TextField("\(patient.eitlink!)", text: $eitlink)
                }
                HStack {
                    Spacer()
                    Button("Сохранить") {
                        DataController().editPatient(patient: patients, fullname: fullname, age: age, diagnosis: diagnosis, eitlink: eitlink, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

