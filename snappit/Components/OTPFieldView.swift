import SwiftUI

struct OTPFieldView: View {
    @Binding var otp: String
    @FocusState private var isFocused: Bool

    private let digitCount = 6

    var body: some View {
        ZStack {
            // Hidden text field for keyboard input
            TextField("", text: $otp)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isFocused)
                .opacity(0.01)
                .frame(width: 1, height: 1)
                .onChange(of: otp) { _, newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count > digitCount {
                        otp = String(filtered.prefix(digitCount))
                    } else if filtered != newValue {
                        otp = filtered
                    }
                }

            // Visible digit boxes
            HStack(spacing: 8) {
                ForEach(0..<digitCount, id: \.self) { index in
                    digitBox(at: index)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = true
            }
        }
        .onAppear {
            isFocused = true
        }
    }

    @ViewBuilder
    private func digitBox(at index: Int) -> some View {
        let digits = Array(otp)
        let isActive = index == digits.count && isFocused
        let isFilled = index < digits.count

        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isActive || isFilled ? Color.green : Color(hex: "EBECF1"),
                    lineWidth: isActive ? 1.5 : 1
                )
                .frame(height: 52)

            if isFilled {
                Text(String(digits[index]))
                    .font(.system(size: 22, weight: .semibold, design: .monospaced))
            }
        }
    }
}
