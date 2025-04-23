//
//  ViewController.swift
//  SpareRoom-Test
//
//  Created by Shamil Imanov on 19.04.2025.
//

import UIKit

final class ViewController: UIViewController {
	private enum Constants {
		static let sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
		static let sidePadding: CGFloat = 16
		static let verticalSpacing: CGFloat = 10
		static let pageControlTopBottomSpacing: CGFloat = 20
		static let pageControlHeight: CGFloat = 24
		static let buttonSize: CGFloat = 22
		static let collectionViewHorizontalInset: CGFloat = 12
		static let collectionCellHorizontalPadding: CGFloat = 32
		static let titleFontSize: CGFloat = 34
		static let radius: CGFloat = 12
	}
	
	var interactor: BusinessLogic?
	var router: RoutingLogic?
	
	private let userButton = UIButton()
	private let plusButton = UIButton()
	private let titleLabel = UILabel()
	private let segmentedControl = UISegmentedControl(items: [
		"segmentUpcoming".localized,
		"segmentPast".localized,
		"segmentDraft".localized
	])
	
	private let eventsCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.sectionInset = Constants.sectionInset
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.backgroundColor = .clear
		collection.showsHorizontalScrollIndicator = false
		return collection
	}()
	
	private let pageControl: UIPageControl = {
		let control = UIPageControl()
		control.currentPageIndicatorTintColor = .black
		control.pageIndicatorTintColor = .lightGray
		return control
	}()
	
	private let loaderView = UIActivityIndicatorView(style: .large)
	private let errorView = ErrorView()
	
	private var selectedModel: [GlassmorphicEventViewModel] = []
	private var upcomingModel: [GlassmorphicEventViewModel] = []
	private var pastModel: [GlassmorphicEventViewModel] = []
	private var draftModel: [GlassmorphicEventViewModel] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		interactor?.initialize()
	}
}

extension ViewController: DisplayLogic {
	func displayLoader(isLoading: Bool) {
		DispatchQueue.main.async {
			if isLoading {
				self.loaderView.startAnimating()
			} else {
				self.loaderView.stopAnimating()
			}
			self.updateState(.loading)
		}
	}
	
	func displayData(
		upcomingModel: [GlassmorphicEventViewModel],
		pastModel: [GlassmorphicEventViewModel],
		draftModel: [GlassmorphicEventViewModel]
	) {
		DispatchQueue.main.async {
			self.selectedModel = upcomingModel
			self.upcomingModel = upcomingModel
			self.pastModel = pastModel
			self.draftModel = draftModel
			self.pageControl.numberOfPages = upcomingModel.count
			self.eventsCollectionView.reloadData()
			self.updateState(.content)
		}
	}
	
	func displayError(isOffline: Bool) {
		DispatchQueue.main.async {
			self.updateState(.error(isOffline: isOffline))
		}
	}
	
	func displayCheckInController() {
		router?.routeCheckInController()
	}
	
	func displayEditController() {
		router?.routeEditController()
	}
}

extension ViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView == eventsCollectionView {
			let page = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
			guard pageControl.currentPage != page else { return }
			pageControl.currentPage = Int(page)
		}
	}
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return selectedModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: EventCard.reuseIdentifier,
			for: indexPath
		) as? EventCard else { fatalError("GlassmorphicCollectionViewCell") }
		cell.setModel(selectedModel[indexPath.row])
		return cell
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(
			width: collectionView.bounds.width - Constants.collectionCellHorizontalPadding,
			height: collectionView.bounds.height
		)
	}
}

private extension ViewController {
	func setupUI() {
		[
			userButton,
			plusButton,
			titleLabel,
			segmentedControl,
			loaderView,
			errorView,
			eventsCollectionView,
			pageControl
		].forEach { element in
			view.addSubview(element)
			element.translatesAutoresizingMaskIntoConstraints = false
		}
		
		setupConstraints()
		setupAppearance()
		setupSegmentControll()
		setupCollection()
		setupPageControll()
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			userButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			userButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
			userButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
			userButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
			
			plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),
			plusButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
			plusButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
			
			titleLabel.topAnchor.constraint(equalTo: userButton.bottomAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),
			
			segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalSpacing),
			segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
			segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),
			
			eventsCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.verticalSpacing),
			eventsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			eventsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			
			pageControl.topAnchor.constraint(equalTo: eventsCollectionView.bottomAnchor, constant: Constants.pageControlTopBottomSpacing),
			pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.pageControlTopBottomSpacing),
			pageControl.heightAnchor.constraint(equalToConstant: Constants.pageControlHeight),
			
			loaderView.centerYAnchor.constraint(equalTo: eventsCollectionView.centerYAnchor),
			loaderView.centerXAnchor.constraint(equalTo: eventsCollectionView.centerXAnchor),
			
			errorView.centerYAnchor.constraint(equalTo: eventsCollectionView.centerYAnchor),
			errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
	
	func setupAppearance() {
		view.backgroundColor = Colors.Background.primary
		
		let image = UIImage.SymbolConfiguration(pointSize: Constants.buttonSize)
		let userImage = UIImage(systemName: "person.circle", withConfiguration: image)
		let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: image)
		
		userButton.setImage(userImage, for: .normal)
		plusButton.setImage(plusImage, for: .normal)
		userButton.tintColor = Colors.Feature.userButtons
		plusButton.tintColor = Colors.Feature.userButtons
		
		titleLabel.text = "appTitle".localized
		titleLabel.font = .systemFont(ofSize: Constants.titleFontSize, weight: .bold)
		titleLabel.textColor = .label
		
		loaderView.tintColor = Colors.Feature.grayishBlue
		
		errorView.isHidden = true
	}
	
	func setupSegmentControll() {
		segmentedControl.tintColor = Colors.Feature.grayishBlue
		segmentedControl.selectedSegmentTintColor = .white
		segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
		segmentedControl.setTitleTextAttributes([.foregroundColor: Colors.Feature.grayishBlue], for: .normal)
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
	}
	
	func setupCollection() {
		eventsCollectionView.delegate = self
		eventsCollectionView.dataSource = self
		eventsCollectionView.register(EventCard.self, forCellWithReuseIdentifier: EventCard.reuseIdentifier)
		eventsCollectionView.clipsToBounds = true
	}
	
	func setupPageControll() {
		pageControl.backgroundColor = Colors.Background.secondary
		pageControl.currentPageIndicatorTintColor = Colors.Background.neutral
		pageControl.layer.cornerRadius = Constants.radius
		pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
	}
	
	func updateState(_ state: Model.ScreenState) {
		loaderView.stopAnimating()
		loaderView.isHidden = true
		eventsCollectionView.isHidden = true
		pageControl.isHidden = true
		errorView.isHidden = true
		
		switch state {
		case .loading:
			loaderView.isHidden = false
			loaderView.startAnimating()
		case .content:
			eventsCollectionView.isHidden = false
			pageControl.isHidden = false
		case let .error(isOffline):
			errorView.isHidden = false
			showErrorView(isOffline: isOffline)
		}
	}
	
	func showErrorView(isOffline: Bool) {
		let imageName: String
		let title: String
		let text: String
		if isOffline {
			imageName = "wifi.exclamationmark"
			title = "offlineTitle".localized
			text = "offlineText".localized
		} else {
			imageName = "exclamationmark.icloud.fill"
			title = "errorTitle".localized
			text = "errorText".localized
		}
		
		errorView.setModel(
			ErrorModel(
				icon: UIImage(systemName: imageName),
				title: title,
				text: text,
				retryHandle: { [weak self] in
					guard let self else { return }
					self.updateState(.loading)
					self.interactor?.didTapRetry()
				}
			)
		)
	}
	
	@objc
	func didTapSegment() {
		switch segmentedControl.selectedSegmentIndex {
		case 0:
			selectedModel = upcomingModel
		case 1:
			selectedModel = pastModel
		case 2:
			selectedModel = draftModel
		default:
			break
		}
		pageControl.numberOfPages = selectedModel.count
		pageControl.currentPage = 0
		
		eventsCollectionView.setContentOffset(.zero, animated: false)
		eventsCollectionView.reloadData()
	}
	
	@objc
	func pageControlChanged() {
		let index = pageControl.currentPage
		let indexPath = IndexPath(item: index, section: 0)
		eventsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
}
