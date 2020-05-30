//
//  TableViewController.swift
//  Browser
//
//  Created by Alexandr Kulya on 27.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Setup Variables
    var managerOfMarkers: ManagerOfMarkers!
    
    var header: UILabel = {
        let header = UILabel()
        header.text = "Закладки"
        header.font = .boldSystemFont(ofSize: 25)
        header.textAlignment = .center
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    var backButton: UIButton = {
        let goBack = UIButton(type: .system)
        goBack.setTitle("Назад", for: .normal)
        goBack.titleLabel?.font = .systemFont(ofSize: 20)
        goBack.addTarget(self, action: #selector(back), for: .touchUpInside)
        goBack.translatesAutoresizingMaskIntoConstraints = false
        return goBack
    }()
    @objc func back() {
        dismiss(animated: true)
    }

    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupHeaderAndButtonLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    
    
    // MARK: - Setup Layout
    func setupHeaderAndButtonLayout() {
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            header.widthAnchor.constraint(equalToConstant: 130)
        ])
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managerOfMarkers.markersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? MarkersCell {
            let marker = managerOfMarkers.markers[indexPath.row]
            cell.setupValue = marker
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "unwindToMainScreen" else { return }
        guard let webVC = segue.destination as? ViewController else { return }
        let currentURL = sender as? Marker
        webVC.seatchField.text = currentURL?.text
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = managerOfMarkers.markers[indexPath.row]
        performSegue(withIdentifier: "unwindToMainScreen", sender: url)
    }
}
