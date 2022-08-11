//
//  PatientsView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 11.08.2022.
//

import SwiftUI
import CoreData

struct PatientsView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var patients: FetchedResults<Patients>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Пациентов всего: \(patients.count)")
                    .foregroundColor(.mint)
                    .padding(.horizontal)
                List {
                    ForEach(patients) { patients in
                        NavigationLink(destination: Text(patients.fullname!)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(patients.fullname!)
                                        .bold()
                                    Text("Возраст: \(patients.age!)")
                                    
                                }
                                Spacer()
                                Text(calcTimeSince(date: patients.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                            
                        }
                    }
                    .onDelete(perform: deletePatient(offsets:))
                }
                .listStyle(.plain)
            }
            .navigationTitle("Пациенты")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Добавить пациента", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                    
                }
                
            }
            .sheet(isPresented: $showingAddView) {
                AddPatient()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deletePatient(offsets: IndexSet) {
        withAnimation {
            offsets.map { patients[$0] } .forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
    }
}
