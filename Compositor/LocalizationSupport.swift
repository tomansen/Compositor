import Foundation

// MARK: - 本地化支撑（汉化工程新增，上游无此文件）
//
// 两条铁律：
//  1. 任何**持久化标识**（写进 .comp / PSD / UserDefaults 的字符串）一律不动 —— 枚举 rawValue 只增不改。
//  2. 显示与标识分离 —— 显示走 `displayName`（或 `String(localized:)`），标识继续用 `rawValue`。

/// 供「rawValue 即英文显示名」的枚举使用。
///
/// `rawValue` 保持英文（它同时是 Picker 的 tag 与工程文件里的稳定标识），
/// `displayName` 才是界面显示的名字。查表用动态键 —— 键集由
/// `Localizable.xcstrings` 显式提供，`cs_本地化校验.py` 会核对每个 rawValue 都有条目。
protocol LocalizedRawDisplay: RawRepresentable where RawValue == String {}

extension LocalizedRawDisplay {
    /// 界面显示名。查不到时回落到英文 rawValue（安全兜底，绝不显示空白）。
    var displayName: String { NSLocalizedString(rawValue, comment: "") }
}

/// 格式化型本地化：`localized("%@ color", kind.displayName)`。
/// 键在 catalog 里写作 `%@ color`，中文形如「%@ 的颜色」。
func localized(_ key: String, _ arguments: CVarArg...) -> String {
    String(format: NSLocalizedString(key, comment: ""), arguments: arguments)
}

// MARK: - 采用 `LocalizedRawDisplay` 的枚举
//
// 均为「rawValue == 英文显示名，且 rawValue 同时是持久化标识或 Picker tag」的类型。

extension SpotHealingMode: LocalizedRawDisplay {}
extension CameraRawWhiteBalance: LocalizedRawDisplay {}
extension CameraRawGlowStyle: LocalizedRawDisplay {}
extension CameraRawVignetteStyle: LocalizedRawDisplay {}
extension CameraRawScopeMode: LocalizedRawDisplay {}
extension CameraRawCurvePage: LocalizedRawDisplay {}
extension CameraRawPointChannel: LocalizedRawDisplay {}
extension CameraRawMixerPage: LocalizedRawDisplay {}
extension CameraRawMixerTab: LocalizedRawDisplay {}
extension CameraRawGradePage: LocalizedRawDisplay {}
extension CameraRawUprightMode: LocalizedRawDisplay {}
extension CameraRawProjection: LocalizedRawDisplay {}
extension CameraRawProcessVersion: LocalizedRawDisplay {}
extension CanvasUnit: LocalizedRawDisplay {}
extension DitherStyle: LocalizedRawDisplay {}
extension DitherPixelShape: LocalizedRawDisplay {}
extension DitherColors: LocalizedRawDisplay {}
extension FilterKind: LocalizedRawDisplay {}
extension BackgroundQuality: LocalizedRawDisplay {}
extension GradientStyle: LocalizedRawDisplay {}
extension GradientShape: LocalizedRawDisplay {}
extension GridAppearance.Preset: LocalizedRawDisplay {}
extension GridAppearance.Style: LocalizedRawDisplay {}
extension ColorRange: LocalizedRawDisplay {}
extension TrimBasedOn: LocalizedRawDisplay {}
extension AdjustmentKind: LocalizedRawDisplay {}
extension LayerBlendMode: LocalizedRawDisplay {}
extension LayerEffectKind: LocalizedRawDisplay {}
extension LayerSampling: LocalizedRawDisplay {}
extension LevelsChannel: LocalizedRawDisplay {}
extension LevelsAuto: LocalizedRawDisplay {}
extension LevelsSample: LocalizedRawDisplay {}
extension WandMode: LocalizedRawDisplay {}
extension LassoKind: LocalizedRawDisplay {}
extension SelectionMode: LocalizedRawDisplay {}
extension EditorSession.SelectionAmountOperation: LocalizedRawDisplay {}
extension ShapeKind: LocalizedRawDisplay {}
extension BrushToolMode: LocalizedRawDisplay {}
extension BlurToolMode: LocalizedRawDisplay {}
extension ExportFormat: LocalizedRawDisplay {}
extension HueSampleMode: LocalizedRawDisplay {}

// MARK: - 显示名与 rawValue 形态不同的枚举，逐个补 `displayName`

extension CanvasUnit {
    /// 「Pixels / Percent / Inches / Centimeters」以外还要在摘要里写出的短名。
    var shortName: String {
        switch self {
        case .pixels: NSLocalizedString("px", comment: "")
        case .percent: NSLocalizedString("%", comment: "")
        case .inches: NSLocalizedString("in", comment: "")
        case .centimeters: NSLocalizedString("cm", comment: "")
        }
    }
}

extension NewCanvasUnit {
    /// 单位缩写（输入框右侧的 `px` / `in` / `cm` / `mm`）—— 不译。
    var abbreviation: String { rawValue }
}

extension NewCanvasBackground {
    /// 「Transparent canvas / White canvas / Black canvas」。
    var displayName: String {
        switch self {
        case .transparent: NSLocalizedString("Transparent canvas", comment: "")
        case .white: NSLocalizedString("White canvas", comment: "")
        case .black: NSLocalizedString("Black canvas", comment: "")
        }
    }
}

extension WandSampleSize {
    /// 「Point Sample / 3 by 3 Average / 5 by 5 Average」。
    var displayName: String {
        switch self {
        case .point: NSLocalizedString("Point Sample", comment: "")
        case .threeByThree: NSLocalizedString("3 by 3 Average", comment: "")
        case .fiveByFive: NSLocalizedString("5 by 5 Average", comment: "")
        }
    }
}

extension TextAlignment {
    /// 工具提示里的「Align left」→「左对齐」。
    var displayName: String {
        switch self {
        case .left: NSLocalizedString("Align left", comment: "")
        case .center: NSLocalizedString("Align center", comment: "")
        case .right: NSLocalizedString("Align right", comment: "")
        }
    }
}
