//
//  ViewController.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 07.12.24.

import UIKit
import MapKit
final class CountryViewController: BaseViewController {
    
    private var coordinator: CLLocationCoordinate2D?
    
    let cellSpacingHeight: CGFloat = 100
    
    private lazy var refreshController: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        return r
    }()
    
    private lazy var mapView: MKMapView = {
           let m = MKMapView()
            m.overrideUserInterfaceStyle = .dark
            m.delegate = self
            return m
        }()
    
    private lazy var search: UITextField = {
           let text = ReusableTextField(placeholder: "Enter Country", leftPadding: 10, bgcolor: .white)
           text.delegate = self
           return text
       }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(cell: TitleSubtitleCell.self)
        t.separatorStyle = .none
        t.refreshControl = refreshController
        t.backgroundColor = .clear
        return t
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .large)
        v.tintColor = .red
        return v
    }()
    
    
    private let viewModel: CountryViewModule
    
    init(viewModel: CountryViewModule) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel.countryRequest()
       
    }
    
    override func configureView() {
        super.configureView()
        view.addSubViews(table, loadingView, search , mapView)
        view.bringSubviewToFront(search)
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        loadingView.fillSuperview()
        search.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, leading: 24, trailing: -24))
                search.anchorSize(CGSize(width: 0, height: 50))
        mapView.fillSuperview()
        
        table.anchor(
            top: search.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 4, left: 20, bottom: 100, right: -20)
        )
        
    }
    
    override func configureTargets() {
        super.configureTargets()
    }
    
    fileprivate func configureViewModel() {
        viewModel.listener = { [weak self] state in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch state {
                    case .loading:
                        self.loadingView.startAnimating()
                    case .loaded:
                        self.loadingView.stopAnimating()
                    self.refreshController.endRefreshing()
                    case .success:
                        self.table.reloadData()
                    case .error(let message):
                        self.showMessage(title: "Xeta", message: message)
                }
            }
        }
    }
    
    @objc func reloadPage(){
        
    }
    fileprivate func showCountryOnMap(coordinate: CLLocationCoordinate2D, countryName: String) {
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = countryName
            mapView.isHidden = false
            table.isHidden = true
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(pin)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
            mapView.setRegion(region, animated: true)
        }
    
   
}
extension CountryViewController: UITableViewDelegate,
                              UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.getItems()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: TitleSubtitleCell.self, for: indexPath)
        
        guard let item = viewModel.getProtocol(index: indexPath.row) else {return UITableViewCell()}
        cell.configureCell(model: item)

        return cell
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let selectedCountry = viewModel.getProtocol(index: indexPath.row) else { return }
               if let latlng = selectedCountry.latlng, latlng.count >= 2 {
                   let coordinate = CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
                   showCountryOnMap(coordinate: coordinate, countryName: selectedCountry.titleString)
               }
               tableView.deselectRow(at: indexPath, animated: true)
            }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}


extension CountryViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        
            if text.isEmpty {
             viewModel.search(text: "")
                table.isHidden = true
                mapView.isHidden = false
            } else {
              viewModel.search(text: text)
                table.isHidden = false
                view.backgroundColor = .gray
                mapView.isHidden = true
            }
            table.reloadData()
        }
    }

extension CountryViewController: MKMapViewDelegate {
    
}
