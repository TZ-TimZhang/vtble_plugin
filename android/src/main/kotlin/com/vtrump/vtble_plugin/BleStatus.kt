package com.vtrump.vtble_plugin

/**
 * @author timzhang
 * @date 2023/2/17
 */
enum class BleStatus(val code: Int) {
    UNKNOWN(code = 0),
    UNSUPPORTED(code = 1),
    UNAUTHORIZED(code = 2),
    POWERED_OFF(code = 3),
    LOCATION_SERVICES_DISABLED(code = 4),
    READY(code = 5)
}