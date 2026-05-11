import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.base.app.dev"
            resValue(type = "string", name = "app_name", value = "Base app Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.base.app"
            resValue(type = "string", name = "app_name", value = "Base app")
        }
    }
}