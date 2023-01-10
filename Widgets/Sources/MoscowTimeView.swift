import WidgetKit
import SwiftUI

struct MoscowTimeView: View {

    @Environment(\.widgetFamily) var family: WidgetFamily
    var moscowTime: MoscowTimeProvider.Entry

    var body: some View {
        if #available(iOSApplicationExtension 16.0, *), family == .accessoryRectangular || family == .accessoryInline {
            accessoryView(for: family)
        } else {
            ZStack {
                BitcoinBackground(family: family)
                systemView(for: family)
            }
        }
    }

    @available(iOSApplicationExtension 16.0, *)
    func accessoryView(for family: WidgetFamily) -> some View {
        VStack(alignment: .trailing) {
            if family == .accessoryInline {
                Label(moscowTime(for: moscowTime.format).string(for: moscowTime.primaryPrice), systemImage: "bitcoinsign.square.fill")
            } else {
                Text(moscowTime.primaryPrice, formatter: moscowTime(for: moscowTime.format))
                    .font(.system(size: 37))
                Text(moscowTime.primaryPrice, formatter: currency(for: moscowTime.primaryCurrencyCode))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.trailing, 2)
            }
        }
    }

    func systemView(for family: WidgetFamily) -> some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(moscowTime.primaryPrice, formatter: moscowTime(for: moscowTime.format))
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text(moscowTime.primaryPrice, formatter: currency(for: moscowTime.primaryCurrencyCode))
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.trailing, 2)
            }.padding()
            if family == .systemMedium {
                VStack(alignment: .trailing) {
                    Text(moscowTime.secondaryPrice, formatter: moscowTime(for: moscowTime.format))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text(moscowTime.secondaryPrice, formatter: currency(for: moscowTime.secondaryCurrencyCode))
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.trailing, 2)
                }.padding()
            }
        }
    }

    private func moscowTime(for format: MoscowTimeFormat) -> MoscowTimeFormatter {
        let formatter = MoscowTimeFormatter();
        formatter.format = format

        return formatter
    }

    private func currency(for currencyCode: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.maximumFractionDigits = 0

        return formatter
    }

}

struct MoscowTimeView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            MoscowTimeView(moscowTime: MoscowTime(format: .time, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            MoscowTimeView(moscowTime: MoscowTime(format: .plain, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            MoscowTimeView(moscowTime: MoscowTime(format: .time, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            MoscowTimeView(moscowTime: MoscowTime(format: .plain, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            if #available(iOSApplicationExtension 16.0, *) {
                MoscowTimeView(moscowTime: MoscowTime(format: .time, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                MoscowTimeView(moscowTime: MoscowTime(format: .plain, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))

                MoscowTimeView(moscowTime: MoscowTime(format: .time, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                    .previewContext(WidgetPreviewContext(family: .accessoryInline))
                MoscowTimeView(moscowTime: MoscowTime(format: .plain, primaryPrice: 51229.50, primaryCurrencyCode: "USD", secondaryPrice: 43546.19, secondaryCurrencyCode: "EUR"))
                    .previewContext(WidgetPreviewContext(family: .accessoryInline))
            }
        }
    }

}