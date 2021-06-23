//
//  ViewController.swift
//  Step1
//
//  Created by sean on 2021/06/20.
//

import UIKit

import YogaKit

class ViewController: UIViewController {
	
	enum Padding {
		static let `default`: YGValue = 8.0
		static let horizontal: YGValue = 8.0
	}
	
	private let backgroundColor: UIColor = .black
	
	fileprivate var shows: [Show] = []
	
	fileprivate let contentView: UIScrollView = UIScrollView(frame: .zero)
	fileprivate let showCellIdentifier = "ShowCell"
	
	// Overall show info
	private let showPopularity = 5
	private let showYear = "2010"
	private let showRating = "TV-14"
	private let showLength = "3 Series"
	private let showCast = "Benedict Cumberbatch, Martin Freeman, Una Stubbs"
	private let showCreators = "Mark Gatiss, Steven Moffat"
	
	// Show selected
	private let showSelectedIndex = 2
	private let selectedShowSeriesLabel = "S3:E3"
	
	// MARK: - Life cycle methods
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		var contentViewRect: CGRect = .zero
		for view in contentView.subviews {
			contentViewRect = contentViewRect.union(view.frame)
		}
		contentView.contentSize = contentViewRect.size
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		shows = Show.loadShows()
		
		let show = shows[showSelectedIndex]
		
		contentView.backgroundColor = backgroundColor
		contentView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.height = YGValue(self.view.bounds.size.height)
			layout.width = YGValue(self.view.bounds.size.width)
			layout.justifyContent = .flexStart
		}
		
		let episodeImageView = UIImageView(frame: .zero)
		episodeImageView.backgroundColor = .gray
		
		let image = UIImage(named: show.image)
		episodeImageView.image = image
		
		let imageWidth = image?.size.width ?? 1.0
		let imageHeight = image?.size.height ?? 1.0
		
		episodeImageView.configureLayout {
			$0.isEnabled = true
			$0.aspectRatio = imageWidth / imageHeight
		}
		
		contentView.addSubview(episodeImageView)
		
		let summaryView = UIView(frame: .zero)
		summaryView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = Padding.default
		}
		
		let summaryPopularityLabel = UILabel(frame: .zero)
		summaryPopularityLabel.text = String(repeating: "★", count: showPopularity)
		summaryPopularityLabel.textColor = .red
		summaryPopularityLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexGrow = 1.0
		}
		summaryView.addSubview(summaryPopularityLabel)

		contentView.addSubview(summaryView)
		
		view.addSubview(contentView)
		
		contentView.yoga.applyLayout(preservingOrigin: false)
	}
}

// MARK: - Private methods

private extension ViewController {
	func showLabelFor(
		text: String,
		font: UIFont = UIFont.systemFont(ofSize: 14.0)) -> UILabel {
		let label = UILabel(frame: .zero)
		label.font = font
		label.textColor = .lightGray
		label.text = text
		label.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginBottom = 5.0
		}
		return label
	}
	
	// TODO: Add private methods below
	
}

// MARK: - UITableViewDataSource methods

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return shows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: ShowTableViewCell =
			tableView.dequeueReusableCell(withIdentifier: showCellIdentifier, for: indexPath) as! ShowTableViewCell
		cell.show = shows[indexPath.row]
		return cell
	}
	
}

// MARK: - UITableViewDelegate methods

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected row \(indexPath.row)")
	}
}
