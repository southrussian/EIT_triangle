//
//  AddPatient.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 10.08.2022.
//

import SwiftUI

struct AddPatient: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var fullname = ""
    @State private var age = ""
    @State private var eitlink = ""
    @State private var diagnosis = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("ФИО", text: $fullname)
                    
                    VStack {
                        TextField("Возраст", text: $age)
                        Divider()
                        TextField("Диагноз", text: $diagnosis)
                        Divider()
                        TextField("Аппарат ЭИТ", text: $eitlink)
                    }
                    
                    HStack {
                        Spacer()
                        Button("Сохранить") {
                            DataController().addPatient(fullname: fullname, age: age, diagnosis: diagnosis, eitlink: eitlink, context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Данные пациента")

        }
    }
}

struct AddPatient_Previews: PreviewProvider {
    static var previews: some View {
        AddPatient()
    }
}
